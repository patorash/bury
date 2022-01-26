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
    hash = create_hash_recursively(keys, value)
    merge_for_burying!(keys, hash)
    self
  end

  protected

  # @param [Array<String|Symbol>] keys
  # @param [Hash] hash
  # @param [Integer] index
  # @return [Void]
  def merge_for_burying!(keys, hash, index = 0)
    key = keys[index]
    if self.has_key?(key) && self[key].is_a?(Hash)
      self[key].merge_for_burying!(keys, hash, index + 1)
    else
      merge!(index.zero? ? hash : hash.dig(*keys.take(index)))
    end
  end

  private

  # @param [Array<String|Symbol>] keys
  # @param [Object] value
  # @option [Integer] index
  # @return [Hash]
  def create_hash_recursively(keys, value, index = 0)
    if keys.size - 1 == index
      { keys[index] => value }
    else
      { keys[index] => create_hash_recursively(keys, value, index + 1) }
    end
  end

end

Hash.include(Bury)
