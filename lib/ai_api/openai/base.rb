# frozen_string_literal: true

module AIApi
  module OpenAI
    class Base < AIApi::Base
      base_uri "https://api.openai.com"

      API_KEY = ENV.fetch("OPENAI_API_KEY")

      def headers_contructor(api_key)
        {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{api_key}"
        }
      end
    end
  end
end
