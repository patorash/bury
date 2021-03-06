require "bury/version"

module Bury

  # Merge Hash according to the array of keys passed to Hash
  # @param [Array<String|Symbol>] keys
  # @param [Object] value
  # @return [Hash]
  # @example example
  #   hash = {a: {d: 2}}
  #   hash.bury([:a,:b,:c], 1) # => {a:{b:{c:1},d:2}}
  #   hash # => {a: {d: 2}}
  def bury(keys, value)
    merge_proc = lambda do |_key, old_value, new_value|
      [old_value, new_value].all? { |v| v.is_a? Hash } ? old_value.merge(new_value, &merge_proc) : new_value
    end
    create_hash_recursively = lambda do |i = 0|
      { keys[i] => keys.size - 1 == i ? value : create_hash_recursively.call(i + 1) }
    end
    merge(create_hash_recursively.call, &merge_proc)
  end

  # Destructively merges Hashes according to the array of keys passed to it
  # @param [Array<String|Symbol>] keys
  # @param [Object] value
  # @return [Hash]
  # @example example
  #   hash = {a: {d: 2}}
  #   hash.bury!([:a,:b,:c], 1) # => {a:{b:{c:1},d:2}}
  #   hash # => {a:{b:{c:1},d:2}}
  def bury!(keys, value)
    replace(bury(keys, value))
  end

end

Hash.include(Bury)
