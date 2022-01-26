require "bury/version"

module Bury

  # Merge Hash according to the array of keys passed to Hash
  # @param [Array<String|Symbol>] keys
  # @param [Object] value
  # @option [Integer] index
  # @return [Hash]
  # @example example
  #   {}.bury([:a,:b,:c], 1) # => {a:{b:{c: 1}}}
  #   {a: {d: 2}}.bury([:a,:b,:c], 1) # => {a:{b:{c:1},d:2}}
  def bury(keys, value)
    merge_for_burying = lambda do |hash, _keys, target_hash, index = 0|
      key = _keys[index]
      if hash.has_key?(key) && hash[key].is_a?(Hash)
        merge_for_burying.call(hash[key], _keys, target_hash, index + 1)
      else
        hash.merge!(index.zero? ? target_hash : target_hash.dig(*_keys.take(index)))
      end
    end

    create_hash_recursively = lambda do |_keys, _value, index = 0|
      if _keys.size - 1 == index
        { _keys[index] => _value }
      else
        { _keys[index] => create_hash_recursively.call(_keys, _value, index + 1)}
      end
    end

    merge_for_burying.call(self, keys, create_hash_recursively.call(keys, value))

    self
  end

end

Hash.include(Bury)
