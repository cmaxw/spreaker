module Spreaker
  class User
    attr_reader :properties

    def initialize(properties:)
      @properties = properties
    end

    def self.client
      @@client ||= Spreaker::Client.new
    end

    def id
      properties["user_id"]
    end
  end
end
