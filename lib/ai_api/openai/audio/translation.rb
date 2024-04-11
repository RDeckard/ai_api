# frozen_string_literal: true

module AIApi
  module OpenAI
    module Audio
      class Translation < Base
        API_PATH = "/v1/audio/translations"
        API_VERB = "post"

        # rubocop:disable Layout/LineLength
        API_PARAMS = [
          {
            name: "file",
            types: %w[file], # The "file" type automatically sets the Content-Type of the POST request to "multipart/form-data"
            required: true,
            description: "The audio file object (not file name) to translate, in one of these formats: `flac`, `mp3`, `mp4`, `mpeg`, `mpga`, `m4a`, `ogg`, `wav`, or `webm`.",
          },
          {
            name: "model",
            types: %w[string],
            required: true,
            default_value: "whisper-1",
            description: "ID of the model to use. Only whisper-1 is currently available.",
          },
          {
            name: "prompt",
            types: %w[string],
            required: false,
            description: "An optional text to guide the model's style or continue a previous audio segment. The prompt should be in English.",
          },
          {
            name: "response_format",
            types: %w[string],
            required: false,
            description: "Defaults to `json`. The format of the transcript output, in one of these options: `json`, `text`, `srt`, `verbose_json`, or `vtt`.",
          },
          {
            name: "temperature",
            types: %w[float integer],
            required: false,
            description: "Defaults to 0. The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.",
          },
        ].freeze
        # rubocop:enable Layout/LineLength

        RESPONSE_DIGGER = proc { _1["text"].strip }

        def call(file, **options_and_api_params)
          super(file:, **options_and_api_params)
        end
      end
    end
  end
end
