# frozen_string_literal: true

module AIApi
  module OpenAI
    class Embedding < Base
      API_PATH = "/v1/embeddings"
      API_VERB = "post"

      # rubocop:disable Layout/LineLength
      API_PARAMS = [
        {
          name: "model",
          types: %w[string],
          required: true,
          default_value: "text-embedding-ada-002",
          description: "ID of the model to use. You can use the Model API to see all of your available models."
        },
        {
          name: "input",
          types: %w[array string],
          required: true,
          description: "Input text to get embeddings for, encoded as a string or array of tokens. To get embeddings for multiple inputs in a single request, pass an array of strings or array of token arrays. Each input must not exceed 8192 tokens in length."
        },
        {
          name: "user",
          types: %w[string],
          required: false,
          description: "A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse."
        }
      ].freeze
      # rubocop:enable Layout/LineLength

      RESPONSE_DIGGER = proc { _1.dig("data", 0, "embedding") }

      def call(messages = [], **options_and_api_params)
        super(messages:, **options_and_api_params)
      end
    end
  end
end
