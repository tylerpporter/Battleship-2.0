require_relative 'test_helper.rb'
require './lib/ship.rb'

class ShipTest < Minitest::Test

  def setup
    @ship = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @ship
  end

end
