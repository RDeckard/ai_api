# frozen_string_literal: true

module AIApi
  module OpenAI
    class Base < AIApi::Base
      base_uri "https://api.openai.com"

      API_KEY_FETCHER = -> { ENV.fetch("OPENAI_API_KEY") }

      def headers_contructor(api_key)
        {
          "content-type" => "application/json",
          "authorization" => "Bearer #{api_key}"
        }
      end
    end
  end
end
