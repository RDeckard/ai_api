# frozen_string_literal: true

require "httparty"

require_relative "ai_api/version"

module AIApi
  DEFAULT_TIMEOUT = 60
  Error = Class.new(StandardError)
end

require_relative "ai_api/base"
require_relative "ai_api/response"

require_relative "ai_api/openai/base"
require_relative "ai_api/openai/chat"
require_relative "ai_api/openai/completion"
require_relative "ai_api/openai/edit"
require_relative "ai_api/openai/embedding"
require_relative "ai_api/openai/model"

require_relative "ai_api/anthropic/base"
require_relative "ai_api/anthropic/complete"
