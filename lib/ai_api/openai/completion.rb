# frozen_string_literal: true

module AIApi
  module OpenAI
    class Completion < Base # rubocop:disable Metrics/ClassLength
      API_PATH = "/v1/completions"
      API_VERB = "post"

      # rubocop:disable Layout/LineLength
      API_PARAMS = [
        {
          name: "model",
          types: %w[string],
          required: true,
          default_value: "text-ada-001",
          description: "ID of the model to use. You can use the Model API to see all of your available models."
        },
        {
          name: "prompt",
          types: %w[array string],
          required: false,
          description: "The prompt to use as a starting point for the completion. If you pass an array, the API will concatenate the elements together. If you don't include a prompt, the API will start with an empty string."
        },
        {
          name: "suffix",
          types: %w[string],
          required: false,
          description: "A string to append to the end of the completion. This is useful for cases where you want to limit the number of tokens to a certain number, but don't want to cut off the end of the completion."
        },
        {
          name: "max_tokens",
          types: %w[integer],
          required: false,
          description: "Defaults to 16. The maximum number of tokens to generate in the completion. The token count of your prompt plus max_tokens cannot exceed the model's context length. Most models have a context length of 2048 tokens (except for the newest models, which support 4096)."
        },
        {
          name: "temperature",
          types: %w[float integer],
          required: false,
          description: "Defaults to 1. What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both."
        },
        {
          name: "top_p",
          types: %w[float integer],
          required: false,
          description: "Defaults to 1. An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. We generally recommend altering this or temperature but not both."
        },
        {
          name: "n",
          types: %w[integer],
          required: false,
          description: "Defaults to 1. How many completions to generate for each prompt. Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop."
        },
        {
          name: "stream",
          types: %w[boolean],
          required: false,
          description: "Defaults to false. If true, the API will stream back partial progress as it generates each completion, so that you can show a spinner or something in the UI. This is recommended if you're calling the API from a webpage, so that the user knows that the request hasn't failed. The number of `data` objects that stream back is equal to the `n` parameter. It's up to you to concatenate them together, but note that they may overlap because the last tokens of one completion may be the first tokens of the next completion."
        },
        {
          name: "logprobs",
          types: %w[integer],
          required: false,
          description: "Include the log probabilities on the logprobs most likely tokens, as well the chosen tokens. For example, if logprobs is 5, the API will return a list of the 5 most likely tokens. The API will always return the logprob of the sampled token, so there may be up to logprobs+1 elements in the response. The maximum value for logprobs is 5."
        },
        {
          name: "echo",
          types: %w[boolean],
          required: false,
          description: "Defaults to false. If true, it will echo back the prompt in addition to the completion."
        },
        {
          name: "stop",
          types: %w[array string],
          required: false,
          description: "Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence."
        },
        {
          name: "presence_penalty",
          types: %w[float integer],
          required: false,
          description: "Defaults to 0. Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim. See more information about frequency and presence penalties."
        },
        {
          name: "frequency_penalty",
          types: %w[float integer],
          required: false,
          description: "Defaults to 0. Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics."
        },
        {
          name: "best_of",
          types: %w[integer],
          required: false,
          description: %(Defaults to 1. Generates best_of completions server-side and returns the "best" (the one with the highest log probability per token). Results cannot be streamed. When used with n, best_of controls the number of candidate completions and n specifies how many to return – best_of must be greater than n. Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.)
        },
        {
          name: "logit_bias",
          types: %w[hash],
          required: false,
          description: %(Modify the likelihood of specified tokens appearing in the completion. Accepts a json object that maps tokens (specified by their token ID in the GPT tokenizer) to an associated bias value from -100 to 100. You can use this tokenizer tool (which works for both GPT-2 and GPT-3) to convert text to token IDs. Mathematically, the bias is added to the logits generated by the model prior to sampling. The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token. As an example, you can pass {"50256": -100} to prevent the <|endoftext|> token from being generated.)
        },
        {
          name: "user",
          types: %w[string],
          required: false,
          description: %(A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.)
        }
      ].freeze
      # rubocop:enable Layout/LineLength

      RESPONSE_DIGGER = proc { _1.dig("choices", 0, "text").strip }
      STREAM_FRAGMENT_DIGGER = proc { _1.dig("choices", 0, "text") }

      def call(prompt = nil, **options_and_api_params)
        super(prompt:, **options_and_api_params)
      end
    end
  end
end
