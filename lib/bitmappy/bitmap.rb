
# Bitmap class for handling the image

# 1-based coordinate system (the Grid class handles the underlying grid
# implementation and transformations)

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
    @grid.set_value_at_point(x, y, c)
  end

  def paint_vertical(x, y1, y2, c)

  end

  def paint_horizontal(x1, x2, y, c)

  end

  def fill(x, y, c)

  end

end

