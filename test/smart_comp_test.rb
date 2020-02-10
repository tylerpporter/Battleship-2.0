require_relative 'test_helper.rb'
require './lib/smart_comp.rb'

class SmartCompTest < Minitest::Test

  def setup
    @smart_comp = SmartComp.new("A3")
  end

  def test_it_exists_with_keys

    assert_instance_of SmartComp, @smart_comp
    assert_equal "A3", @smart_comp.current_key
    assert_equal "A2", @smart_comp.left_key
    assert_equal "A4", @smart_comp.right_key
    assert_equal "@3", @smart_comp.top_key
    assert_equal "B3", @smart_comp.bottom_key
  end

end
