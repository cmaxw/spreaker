module Spreaker
  class Show
    attr_reader :properties

    def initialize(properties:)
      @properties = properties
    end

    def id
      show_id
    end

    def method_missing(m, *args, &block)
      return properties[m.to_s] if properties.has_key?(m.to_s)

      super
    end
  end
end
