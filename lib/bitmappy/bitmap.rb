
# Bitmap class for handling the image

# 1-based coordinate system (the Grid class handles the underlying grid
# implementation and transformations)

require 'json'

class Bitmap
  attr_accessor :width, :height, :grid

  def initialize(width, height)
    @width, @height = width, height
    reset_grid()
  end

  def to_s
    @grid.to_s if @grid
  end

  # API calls

  def reset_grid
#    @grid = Array.new(@height) { Array.new(@width) { 'O' } }
    @grid = Grid.new(@width, @height)
  end

  def paint_pixel(x, y, c)
    validate_colour(c)
    @grid.set_value_at_point(x, y, c)
  end

  def paint_vertical(x, y1, y2, c)
    validate_colour(c)
    y1, y2 = [ y1, y2 ].minmax
    (y1..y2).each { |y| @grid.set_value_at_point(x, y, c) }
  end

  def paint_horizontal(x1, x2, y, c)
    validate_colour(c)
    x1, x2 = [ x1, x2 ].minmax
    (x1..x2).each { |x| @grid.set_value_at_point(x, y, c) }
  end

  def fill(x, y, c)
    validate_colour(c)
    original_colour = @grid.get_value_at_point(x, y)
    recursive_fill(x, y, c, original_colour)
  end

  def to_json
    return JSON.pretty_generate({
                                  :height => @height,
                                  :width  => @width,
                                  :grid   => @grid.grid
                                })
  end

  def load_from_json(serialized)
    data = JSON.parse(serialized)
    @height = data['height']
    @width  = data['width']
    @grid   = Grid.new(@width, @height)
    @grid.grid = data['grid']
  end

  private

  def validate_colour(c)
    raise ArgumentError, "#{c} is not a valid colour" unless c =~ /\A[A-Z]\z/
  end

  # Recursively fill outwards from the initial point
  def recursive_fill(x, y, colour, original_colour)
    #    puts "Setting #{x},#{y} to #{colour}"
    @grid.set_value_at_point(x, y, colour)

    points = @grid.all_touching_points(x, y)
    points.each do |p|
      col = @grid.get_value_at_point(p[0], p[1])
      recursive_fill(p[0], p[1], colour, original_colour) if (col == original_colour)
    end
  end
end

