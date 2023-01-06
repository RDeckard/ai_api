# frozen_string_literal: true

require "httparty"

require_relative "openai_api/version"

module OpenAIApi
  Error = Class.new(StandardError)
end

require_relative "openai_api/base"
require_relative "openai_api/completion"
require_relative "openai_api/edit"
require_relative "openai_api/model"

require_relative "openai_api/response"
