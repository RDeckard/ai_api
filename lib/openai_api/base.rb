# frozen_string_literal: true

module OpenAIApi
  class Base
    include HTTParty
    base_uri "https://api.openai.com"

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

    def self.call(*args, api_key: nil, **options_and_api_params)
      new(api_key:).call(*args, **options_and_api_params)
    end

    def initialize(api_key: nil, **api_params)
      @api_key = api_key || ENV.fetch("OPENAI_API_KEY")

      @api_params = default_api_params.merge!(api_params)

      @responses = []
    end

    def call(complete_response: false, **params)
      @api_params.merge!(params)
      @responses << result = __send__(api_verb)

      if !complete_response && result.success? && defined?(self.class::RESPONSE_DIGGER)
        result.formatted_response
      else
        result.parsed_response
      end
    end

    private

    def get
      dynamic_api_path, api_query = dynamic_path_and_query

      self.class
          .get(dynamic_api_path, headers:, query: JSON.generate(api_query, allow_nan: true))
          .extend(OpenAIApi::Response.new(request_params: @api_params, response_digger:))
    end

    def post
      self.class
          .post(api_path, headers:, body: JSON.generate(@api_params, allow_nan: true))
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
      @headers ||= {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@api_key}"
      }
    end

    def response_digger
      return @response_digger if defined?(@response_digger)

      @response_digger = defined?(self.class::RESPONSE_DIGGER) && self.class::RESPONSE_DIGGER
    end

    def result_extender
      lambda do |api_response, request_params|
        api_response.extend(OpenAIApi::Response.new(request_params:, response_digger:))
      end
    end
  end
end
