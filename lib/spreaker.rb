# frozen_string_literal: true

require_relative "spreaker/version"

class Spreaker
  class Error < StandardError; end
  
  def initialize(access_token:)
    @access_token = access_token
  end

  
end
