# frozen_string_literal: true

module AIApi
  module OpenAI
    module Audio
      class Speech < Base
        API_PATH = "/v1/audio/speech"
        API_VERB = "post"

        # rubocop:disable Layout/LineLength
        API_PARAMS = [
          {
            name: "model",
            types: %w[string],
            required: true,
            default_value: "tts-1",
            description: "Defaults to `tts-1`. The AI model that converts text to natural sounding spoken text. There is two different model variants. `tts-1` is optimized for real time text to speech use cases and `tts-1-hd` is optimized for quality.",
          },
          {
            name: "input",
            types: %w[string],
            required: true,
            description: "The text to generate audio for. The maximum length is 4096 characters.",
          },
          {
            name: "voice",
            types: %w[string],
            required: false,
            default_value: "alloy",
            description: "Defaults to `alloy`. The voice to use when generating the audio. Supported voices are `alloy`, `echo`, `fable`, `onyx`, `nova`, and `shimmer`.",
          },
          {
            name: "response_format",
            types: %w[string],
            required: false,
            description: "Defaults to `mp3`. The format to audio in. Supported formats are `mp3`, `opus`, `aac`, and `flac`.",
          },
          {
            name: "speed",
            types: %w[integer],
            required: false,
            description: "Defaults to 1.0. The speed of the generated audio. Select a value from 0.25 to 4.0. 1.0 is the default.",
          },
        ].freeze
        # rubocop:enable Layout/LineLength

        def call(input, **options_and_api_params)
          super(input:, **options_and_api_params)
        end
      end
    end
  end
end
