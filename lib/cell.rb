class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    return "Already fired upon this cell!" if fired_upon?
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(ship = false)
    return "." if !fired_upon? && !ship
    return "M" if empty?
    return "S" if ship == true && !empty?
    if !empty? && !@ship.sunk?
      "H"
    elsif !empty? && @ship.sunk?
      "X"
    end
  end

end
