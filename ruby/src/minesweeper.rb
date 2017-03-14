class MineField
  attr_reader :width
  attr_reader :length

  def initialize(width, length)
    @width = width
    @length = length
    @mines = []
  end
  
  def drop_mine(coord)
    raise "coord.x must less than #{@width}"  unless coord.x < @width
    raise "coord.y must less than #{@length}" unless coord.y < @length

    @mines.push coord
  end

  def boom(coord)
    @mines.any? do |mine|
      mine == coord
    end
  end

  def hint(coord)
    h = 0

    @mines.each do |mine|
      h += 1 if mine.adjacent_to(coord)
    end

    h
  end
end

class Coord
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    raise "x must be greater or equal to 0" unless x >= 0
    raise "y must be greater or equal to 0" unless y >= 0

    @x = x
    @y = y
  end

  def adjacent_to(coord)
    (@x - coord.x).abs <= 1 and
    (@y - coord.y).abs <= 1 and
    self != coord
  end

  def ==(coord)
    coord.x == @x and coord.y == @y
  end
end
