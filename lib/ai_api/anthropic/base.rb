# frozen_string_literal: true

module AIApi
  module Anthropic
    class Base < AIApi::Base
      base_uri "https://api.anthropic.com"

      API_KEY_FETCHER = -> { ENV.fetch("ANTHROPIC_API_KEY") }
      ANTHROPIC_VERSION_FETCHER = -> { ENV.fetch("ANTHROPIC_VERSION") }

      def headers_contructor(api_key)
        {
          "content-type" => content_type,
          "anthropic-version" => anthropic_version,
          "x-api-key" => api_key,
        }
      end

      def anthropic_version
        @anthropic_version ||= ANTHROPIC_VERSION_FETCHER.call
      end
    end
  end
end
