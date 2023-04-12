# frozen_string_literal: true

module AIApi
  module Anthropic
    class Base < AIApi::Base
      base_uri "https://api.anthropic.com"

      API_KEY_FETCHER = -> { ENV.fetch("ANTHROPIC_API_KEY") }

      def headers_contructor(api_key)
        {
          "Content-Type" => "application/json",
          "x-api-key" => api_key
        }
      end
    end
  end
end
