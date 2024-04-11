# frozen_string_literal: true

module AIApi
  module Anthropic
    class Message < Base
      API_PATH = "/v1/messages"
      API_VERB = "post"

      # rubocop:disable Layout/LineLength
      API_PARAMS = [
        {
          name: "model",
          types: %w[string],
          required: true,
          default_value: "claude-3-haiku-20240307",
          description: "The model that will complete your prompt."
        },
        {
          name: "messages",
          types: %w[array],
          required: true,
          description: <<~TEXT
            Input messages.

            Our models are trained to operate on alternating user and assistant conversational turns. When creating a new Message, you specify the prior conversational turns with the messages parameter, and the model then generates the next Message in the conversation.

            Each input message must be an object with a role and content. You can specify a single user-role message, or you can include multiple user and assistant messages. The first message must always use the user role.

            If the final message uses the assistant role, the response content will continue immediately from the content in that message. This can be used to constrain part of the model's response.
          TEXT
        },
        {
          name: "max_tokens",
          types: %w[integer],
          required: true,
          default_value: 4096,
          description: <<~TEXT
            The maximum number of tokens to generate before stopping.

            Note that our models may stop before reaching this maximum. This parameter only specifies the absolute maximum number of tokens to generate.

            Different models have different maximum values for this parameter.
          TEXT
        },
        {
          name: "metadata",
          types: %w[hash],
          required: false,
          description: <<~TEXT
            An object describing metadata about the request.

            ### user_id

            An external identifier for the user who is associated with the request.

            This should be a uuid, hash value, or other opaque identifier. Anthropic may use this id to help detect abuse. Do not include any identifying information such as name, email address, or phone number.
          TEXT
        },
        {
          name: "stop_sequences",
          types: %w[array],
          required: false,
          description: <<~TEXT
            Custom text sequences that will cause the model to stop generating.

            Our models will normally stop when they have naturally completed their turn, which will result in a response stop_reason of "end_turn".

            If you want the model to stop generating when it encounters custom strings of text, you can use the stop_sequences parameter. If the model encounters one of the custom sequences, the response stop_reason value will be "stop_sequence" and the response stop_sequence value will contain the matched stop sequence.
          TEXT
        },
        {
          name: "stream",
          types: %w[boolean],
          required: false,
          description: "Defaults to false. Whether to incrementally stream the response using server-sent events."
        },
        {
          name: "system",
          types: %w[string],
          required: false,
          description: "A system prompt is a way of providing context and instructions to Claude, such as specifying a particular goal or role."
        },
        {
          name: "temperature",
          types: %w[float integer],
          required: false,
          description: <<~TEXT
            Defaults to 1.0. Amount of randomness injected into the response.

            Ranges from 0.0 to 1.0. Use temperature closer to 0.0 for analytical / multiple choice, and closer to 1.0 for creative and generative tasks.

            Note that even with temperature of 0.0, the results will not be fully deterministic.
          TEXT
        },
        {
          name: "tools",
          types: %w[array],
          required: false,
          description: <<~TEXT
            Definitions of tools that the model may use.

            If you include tools in your API request, the model may return tool_use content blocks that represent the model's use of those tools. You can then run those tools using the tool input generated by the model and then optionally return results back to the model using tool_result content blocks.

            Each tool definition includes:

            - name: Name of the tool.
            - description: Optional, but strongly-recommended description of the tool.
            - input_schema: JSON schema for the tool input shape that the model will produce in tool_use output content blocks.

          TEXT
        },
        {
          name: "top_k",
          types: %w[float integer],
          required: false,
          description: <<~TEXT
            Only sample from the top K options for each subsequent token.

            Used to remove "long tail" low probability responses. Learn more technical details here.

            Recommended for advanced use cases only. You usually only need to use temperature.
          TEXT
        },
        {
          name: "top_p",
          types: %w[float integer],
          required: false,
          description: <<~TEXT
            Use nucleus sampling.

            In nucleus sampling, we compute the cumulative distribution over all the options for each subsequent token in decreasing probability order and cut it off once it reaches a particular probability specified by top_p. You should either alter temperature or top_p, but not both.

            Recommended for advanced use cases only. You usually only need to use temperature.
          TEXT
        },
      ].freeze
      # rubocop:enable Layout/LineLength

      RESPONSE_DIGGER = proc { _1.dig("content", 0, "text").strip }
      STREAM_FRAGMENT_DIGGER = proc { _1.dig("delta", "text") }

      def call(messages = [], **options_and_api_params)
        super(messages:, **options_and_api_params)
      end
    end
  end
end
