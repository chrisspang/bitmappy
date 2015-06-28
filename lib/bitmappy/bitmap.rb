
# Bitmap class for handling the image

class Bitmap
  attr_accessor :width, :height, :grid

  def initialize(width, height)
    @width, @height = width, height
    reset_grid()
  end

  # API calls

  def reset_grid
    @grid = Array.new(@height) { Array.new(@width) { 'O' } }
  end

  def paint_pixel(x, y, c)

  end

  def paint_vertical(x, y1, y2, c)

  end

  def paint_horizontal(x1, x2, y, c)

  end

  def fill(x, y, c)

  end

end

