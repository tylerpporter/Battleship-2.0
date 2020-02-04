require_relative 'test_helper.rb'
require './lib/cell.rb'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_it_exists_with_attributes

    assert_instance_of Cell, @cell
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
    assert_equal false, @cell.fired_upon
  end

end
