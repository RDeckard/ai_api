# frozen_string_literal: true

module AIApi
  module Anthropic
    class Complete < Base
      API_PATH = "/v1/complete"
      API_VERB = "post"

      # rubocop:disable Layout/LineLength
      API_PARAMS = [
        {
          name: "model",
          types: %w[string],
          required: true,
          default_value: "claude-instant-v1",
          description: "This controls which version of Claude answers your request.",
        },
        {
          name: "prompt",
          types: %w[string],
          required: false,
          description: "The prompt you want Claude to complete.",
        },
        {
          name: "max_tokens_to_sample",
          types: %w[integer],
          required: false,
          default_value: 16,
          description: "Default to 16. A maximum number of tokens to generate before stopping.",
        },
        {
          name: "stop_sequences",
          types: %w[array],
          required: false,
          description: 'Default to ["\n\nHuman:"]. A list of strings upon which to stop generating.',
        },
        {
          name: "stream",
          types: %w[boolean],
          required: false,
          description: "Defaults to false. Whether to incrementally stream the response using SSE.",
        },
        {
          name: "temperature",
          types: %w[float integer],
          required: false,
          description: "Defaults to 1. Amount of randomness injected into the response. Ranges from 0 to 1. Use temp closer to 0 for analytical / multiple choice, and temp closer to 1 for creative and generative tasks.",
        },
        {
          name: "top_k",
          types: %w[integer],
          required: false,
          description: 'Defaults to -1 (disabled). Only sample from the top K options for each subsequent token. Used to remove "long tail" low probability responses. Defaults to -1',
        },
        {
          name: "top_p",
          types: %w[float integer],
          required: false,
          description: "Defaults to -1 (disabled). Does nucleus sampling, in which we compute the cumulative distribution over all the options for each subsequent token in decreasing probability order and cut it off once it reaches a particular probability specified by top_p. Note that you should either alter temperature or top_p, but not both.",
        },
      ].freeze
      # rubocop:enable Layout/LineLength

      RESPONSE_DIGGER = proc { _1["completion"].strip }
      STREAM_FRAGMENT_DIGGER = proc { _1["completion"] }

      def call(prompt = nil, **options_and_api_params)
        super(prompt:, **options_and_api_params)
      end
    end
  end
end
