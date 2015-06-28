
# Representation of a grid
# This handles all coord translation (from 1... to 0...)

class Grid
  attr_accessor :height, :width, :grid

  def initialize(width, height)
    validate_coordinates(width, height)
    @width, @height = width, height
    @grid = Array.new(@height) { Array.new(@width) { 'O' } }
  end

  def set_value_at_point(x, y, value)
    tx, ty = translate(x,y)
    @grid[ty][tx] = value
  end

  def get_value_at_point(x, y)
    tx, ty = translate(x,y)
    return @grid[ty][tx]
  end

  def to_s
    @grid.collect { |row| row.join("") }.join("")
  end

  private

  def validate_coordinates(x, y)
    # Validate we have an integer
    Integer(x)
    Integer(y)
    # Validate it is within our expected range (1-250)
    raise ArgumentError, "#{x} not in valid range" unless (x.between?(1, 250))
    raise ArgumentError, "#{y} not in valid range" unless (y.between?(1, 250))
  end

  def translate(x, y)
    validate_coordinates(x, y)

    tx = x - 1
    ty = y - 1

#    puts "Checking #{tx} #{ty}"
    raise ArgumentError, "#{x} not a valid X coordinate" unless (tx.between?(0, @width-1))
    raise ArgumentError, "#{y} not a valid Y coordinate" unless (ty.between?(0, @height-1))    

    return [ tx, ty ]
  end
end
