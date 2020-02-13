require_relative 'test_helper.rb'
require './lib/ship.rb'
require './lib/cell.rb'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cell2 = Cell.new("C4")
    @cell3 = Cell.new("D4")
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

  def test_get_error_message_if_already_fired_upon
    @cell.place_ship(@ship)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert_equal "Already fired upon this cell!", @cell.fire_upon
  end

  def test_it_returns_dot_if_not_fired_upon
    assert @cell.empty?
    assert_equal ".", @cell.render
  end

  def test_it_returns_M_if_fired_upon_without_a_ship
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_it_can_reveal_a_ship
    @cell.place_ship(@ship)
    assert_equal "S", @cell.render(true)
  end

  def test_it_returns_H_if_fired_upon_and_ship_is_not_sunk
    @cell.place_ship(@ship)
    @cell.fire_upon
    assert @cell.fired_upon?
    assert_equal 2, @cell.ship.health
    assert_equal "H", @cell.render
  end

  def test_it_returns_X_if_fired_upon_and_ship_is_sunk
    @cell.place_ship(@ship)
    @cell2.place_ship(@ship)
    @cell3.place_ship(@ship)
    @cell.fire_upon
    @cell2.fire_upon
    @cell3.fire_upon
    assert @cell.ship.sunk?
    assert_equal "X", @cell.render
  end

end
