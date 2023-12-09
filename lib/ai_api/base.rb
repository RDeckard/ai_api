# frozen_string_literal: true

module AIApi
  class Base
    include HTTParty
    debug_output $stdout if ENV["AI_API_DEBUG"]

    API_VERB = "get"
    API_PARAMS = {}.freeze

    def self.default_api_params
      self::API_PARAMS.filter_map do |api_param|
        next unless api_param.key?(:default_value)

        [api_param.fetch(:name), api_param.fetch(:default_value)]
      end.to_h
    end

    def default_api_params = self.class.default_api_params

    def self.api_verb = self::API_VERB
    def api_verb = self.class.api_verb

    attr_reader :responses

    def self.call(*args, api_key: nil, timeout: nil, complete_response: false, **options_and_api_params, &)
      new(api_key:, timeout:, complete_response:, &).call(*args, **options_and_api_params)
    end

    def initialize(api_key: nil, timeout: nil, complete_response: false, **api_params, &block)
      @api_key = api_key || self.class::API_KEY_FETCHER.call
      @timeout = timeout || ENV.fetch("AI_API_TIMEOUT", DEFAULT_TIMEOUT)
      @complete_response = complete_response

      @api_params = default_api_params.merge!(api_params)

      @block = block

      @responses = []
    end

    def call(**params)
      @content_type = nil

      @api_params.merge!(params)
      @responses << result = __send__(api_verb)

      if !@block && !@complete_response && result.success? && defined?(self.class::RESPONSE_DIGGER)
        result.formatted_response
      else
        result.parsed_response
      end
    end

    private

    def get
      dynamic_api_path, api_query = dynamic_path_and_query

      self.class
          .get(
            dynamic_api_path,
            headers:,
            query: JSON.generate(api_query, allow_nan: true),
            timeout: @timeout
          ) { |body_fragment| body_fragment_parser(body_fragment).map { @block.call(_1) } unless @block.nil? }
          .extend(AIApi::Response.new(request_params: @api_params, response_digger:))
    end

    def post
      self.class
          .post(
            api_path,
            headers:,
            body:,
            timeout: @timeout
          ) { |body_fragment| body_fragment_parser(body_fragment).map { @block.call(_1) } unless @block.nil? }
          .tap { result_extender.call(_1, @api_params) }
    end

    def api_path
      @api_path ||= self.class::API_PATH
    end

    def dynamic_path_and_query
      dynamic_path = api_path.dup
      query = @api_params.dup

      @api_params.each do |key, value|
        dynamic_path.gsub!(":#{key}", value.to_s) && query.delete(key)
      end
      dynamic_path.gsub!(/:[\w_]+/, "")
      dynamic_path.delete_suffix!("/")

      [dynamic_path, query]
    end

    def headers
      @headers ||= headers_contructor(@api_key)
    end

    def headers_contructor(*)
      raise NotImplementedError
    end

    def body
      case content_type
      when "application/json"
        JSON.generate(@api_params, allow_nan: true)
      when "multipart/form-data"
        @api_params
      end
    end

    def content_type
      @content_type ||=
        self.class::API_PARAMS.any? { _1[:types].include?("file") } ? "multipart/form-data" : "application/json"
    end

    def body_fragment_parser(body_fragment)
      body_fragment
        .lines
        .flat_map do |body_fragment_line|
          body_fragment_line
            .match(/^data: (.*)$/)
            &.captures
            &.map do |data|
              next data.strip if stream_fragment_digger.nil? || @complete_response

              stream_fragment_digger.call(JSON.parse(data.strip))
            rescue JSON::ParserError
            end
        end
        .compact
    end

    def response_digger
      return @response_digger if defined?(@response_digger)

      @response_digger = defined?(self.class::RESPONSE_DIGGER) && self.class::RESPONSE_DIGGER
    end

    def stream_fragment_digger
      return @stream_fragment_digger if defined?(@stream_fragment_digger)

      @stream_fragment_digger = defined?(self.class::STREAM_FRAGMENT_DIGGER) && self.class::STREAM_FRAGMENT_DIGGER
    end

    def result_extender
      lambda do |api_response, request_params|
        api_response.extend(AIApi::Response.new(request_params:, response_digger:))
      end
    end
  end
end
