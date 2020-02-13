require_relative 'test_helper.rb'
require './lib/ship.rb'

class ShipTest < Minitest::Test

  def setup
    @ship = Ship.new("Cruiser", 3)
  end

  def test_it_exists_with_attributes
    assert_instance_of Ship, @ship
    assert_equal "Cruiser", @ship.name
    assert_equal 3, @ship.length
    assert_equal 3, @ship.health
  end

  def test_it_does_not_start_out_sunk
    assert_equal false, @ship.sunk?
  end

  def test_when_hit_it_loses_health_but_stops_at_zero
    @ship.hit
    assert_equal 2, @ship.health
    @ship.hit
    assert_equal 1, @ship.health
    @ship.hit
    assert_equal 0, @ship.health
    @ship.hit
    assert_equal 0, @ship.health 
  end

  def test_it_becomes_sunk_when_health_reaches_zero
    @ship.hit
    @ship.hit
    @ship.hit
    assert_equal 0, @ship.health
    assert @ship.sunk?
  end

end
