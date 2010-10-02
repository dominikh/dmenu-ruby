class Dmenu
  class Item
    # @return [#to_s] The key is what will be displayed in the menu.
    attr_reader :key
    # @return [Object] The value can be any kind of object you wish to
    #   assign to the key.
    attr_reader :value
    def initialize(key, value)
      @key   = key
      @value = value
    end
  end
end
