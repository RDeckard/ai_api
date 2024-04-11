# frozen_string_literal: true

module AIApi
  module OpenAI
    class Edit < Base
      API_PATH = "/v1/edits"
      API_VERB = "post"

      # rubocop:disable Layout/LineLength
      API_PARAMS = [
        {
          name: "model",
          types: %w[string],
          required: true,
          default_value: "text-davinci-edit-001",
          description: "ID of the model to use. You can use the Model API to see all of your available models.",
        },
        {
          name: "instruction",
          types: %w[string],
          required: true,
          description: "The instruction that tells the model how to edit the input.",
        },
        {
          name: "input",
          types: %w[string],
          required: false,
          description: "The input text to use as a starting point for the edit.",
        },
        {
          name: "n",
          types: %w[integer],
          required: false,
          description: "Defaults to 1. How many completions to generate for each prompt. Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.",
        },
        {
          name: "temperature",
          types: %w[float integer],
          required: false,
          description: "The temperature for the model. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer. The default is 0.5. We generally recommend altering this or top_p but not both.",
        },
        {
          name: "top_p",
          types: %w[float integer],
          required: false,
          description: "Defaults to 1. An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. We generally recommend altering this or temperature but not both.",
        },
      ].freeze
      # rubocop:enable Layout/LineLength

      RESPONSE_DIGGER = proc { _1.dig("choices", 0, "text").strip }

      def call(instruction, input: nil, **options_and_api_params)
        super(instruction:, input:, **options_and_api_params)
      end
    end
  end
end
