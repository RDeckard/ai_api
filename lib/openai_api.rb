# frozen_string_literal: true

require "httparty"

require_relative "openai_api/version"

module OpenAIApi
  DEFAULT_TIMEOUT = 60
  Error = Class.new(StandardError)
end

require_relative "openai_api/base"
require_relative "openai_api/chat"
require_relative "openai_api/completion"
require_relative "openai_api/edit"
require_relative "openai_api/embedding"
require_relative "openai_api/model"

require_relative "openai_api/response"
