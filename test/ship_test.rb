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

end
