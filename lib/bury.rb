require "bury/version"

module Bury

  # Merge Hash according to the array of keys passed to Hash
  # @param [Array<String|Symbol>] keys
  # @param [Object] value
  # @return [Hash]
  # @example example
  #   {}.bury([:a,:b,:c], 1) # => {a:{b:{c: 1}}}
  #   {a: {d: 2}}.bury([:a,:b,:c], 1) # => {a:{b:{c:1},d:2}}
  def bury(keys, value)
    merge_proc = lambda do |_key, old_value, new_value|
      [old_value, new_value].all? { |v| v.is_a? Hash } ? old_value.merge!(new_value, &merge_proc) : new_value
    end
    create_hash_recursively = lambda do |_keys, _value, index = 0|
      if _keys.size - 1 == index
        { _keys[index] => _value }
      else
        { _keys[index] => create_hash_recursively.call(_keys, _value, index + 1)}
      end
    end
    merge!(create_hash_recursively.call(keys, value), &merge_proc)
  end

end

Hash.include(Bury)
