# frozen_string_literal: true

module OpenAIApi
  class Response < Module
    def initialize(request_params: nil, response_digger: nil)
      super()
      @request_params = request_params
      @response_digger = response_digger
    end

    def extended(base) # rubocop:disable Metrics/MethodLength
      request_params = @request_params
      response_digger = @response_digger

      base.instance_eval do
        define_singleton_method(:formatted_response) do
          return parsed_response unless response_digger

          response_digger.call(parsed_response)
        end

        define_singleton_method(:request_params) do
          request_params
        end
      end
    end
  end
end
