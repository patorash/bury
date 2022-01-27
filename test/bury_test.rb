require "test_helper"

class BuryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bury::VERSION
  end

  def test_it_get_simple_hash
    assert_equal({a:{b:{c: 1}}}, {}.bury([:a, :b, :c], 1))
  end

  def test_it_get_complexed_hash
    hash = {a: {d: 2}}
    assert_equal({a:{d: 2,b:{c: 1}}}, hash.bury([:a,:b,:c],1))
  end

  def test_it_includes_same_key
    hash = {a: {a: 2}}
    assert_equal({a:{a: 2,b:{c: 1}}}, hash.bury([:a,:b,:c],1))
  end

  def test_it_have_multiple_keys
    hash = {a: {d: 2}, e: 1}
    assert_equal({a:{d: 2,b:{c: 1}}, e: 1}, hash.bury([:a,:b,:c],1))
  end

  def test_it_have_multiple_keys2
    hash = {e: 1}
    assert_equal({a:{b:{c: 1}}, e: 1}, hash.bury([:a,:b,:c],1))
  end

  def test_it_have_multiple_keys3
    hash = {b: {a: {c: 1}}}
    assert_equal({a:{b:{c: 1}}, b:{a: {c: 1}}}, hash.bury([:a,:b,:c],1))
  end

  def test_it_have_multiple_keys4
    hash = {a: {b: {d: 1}}}
    assert_equal({a:{b:{c: 1, d: 1}}}, hash.bury([:a,:b,:c],1))
  end
end
