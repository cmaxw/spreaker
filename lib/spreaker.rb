# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require_relative "spreaker/version"
require_relative "spreaker/user"
require_relative "spreaker/show"
require_relative "spreaker/client"
require_relative "spreaker/episode"

module Spreaker
  class Error < StandardError; end

  def me
    Spreaker::User.new(JSON.parse(@connection.get("/v2/me").body["response"]))
  end
end
