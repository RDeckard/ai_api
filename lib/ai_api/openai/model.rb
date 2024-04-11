# frozen_string_literal: true

module AIApi
  module OpenAI
    class Model < Base
      API_PATH = "/v1/models/:id"

      API_PARAMS = [
        {
          name: "id",
          types: %w[string],
          required: false,
          description: "The model ID. If you don't specify an ID, the API returns a list of all your models.",
        },
      ].freeze

      RESPONSE_DIGGER = proc { _1.key?("data") ? _1["data"] : _1 }

      def call(id = nil, **options_and_api_params)
        super(id:, **options_and_api_params)
      end
    end
  end
end
