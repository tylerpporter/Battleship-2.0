require_relative 'test_helper.rb'
require './lib/ship.rb'
require './lib/cell.rb'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @ship = Ship.new("Cruiser", 3)
  end

  def test_it_exists_with_attributes

    assert_instance_of Cell, @cell
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
    assert_equal false, @cell.fired_upon
  end

  def test_it_starts_out_empty

    assert @cell.empty?
  end

  def test_it_can_have_a_ship
    @cell.place_ship(@ship)

    assert_equal "Cruiser", @cell.ship.name
  end

  def test_it_knows_if_its_been_fired_upon
    @cell.fire_upon

    assert @cell.fired_upon?
  end

  def test_its_ship_has_been_hit_after_fired_upon
    @cell.place_ship(@ship)
    @cell.fire_upon
    
    assert_equal 2, @cell.ship.health
  end

end
