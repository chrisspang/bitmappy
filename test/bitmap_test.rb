
require 'test_helper'

class BitmapTest < Minitest::Test

  def setup
    @small_bitmap = Bitmap.new(3,3)
    @large_bitmap = Bitmap.new(10,10)
  end

  def test_bitmap_new
    assert_instance_of Bitmap, @small_bitmap
  end

  # Requirement: Colours are specified by capital letters
  def test_valid_colour
    @small_bitmap.paint_pixel(1, 1, 'A')
  end

  # Requirement: Colours are specified by capital letters
  def test_invalid_colour1
    assert_raises ArgumentError do
      @small_bitmap.paint_pixel(1, 1, 'a')
    end
  end

  def test_invalid_colour2
    assert_raises ArgumentError do
      @small_bitmap.paint_pixel(1, 1, '!')
    end
  end

  # API calls

  def test_reset_grid
    @small_bitmap.paint_pixel(1, 1, 'R')
    @small_bitmap.reset_grid
    assert_equal 'O', @small_bitmap.grid.get_value_at_point(1, 1)
  end

  def test_paint_pixel
    @small_bitmap.paint_pixel(1, 1, 'P')
    assert_equal 'P', @small_bitmap.grid.get_value_at_point(1, 1)
  end

  def test_paint_vertical
    @large_bitmap.paint_vertical(1, 2, 9, 'V')
    pixels = (1..10).collect { |y| @large_bitmap.grid.get_value_at_point(1, y) }
    assert_equal 'OVVVVVVVVO', pixels.join
  end

  ## Test when y2 < y1
  def test_paint_vertical_reverse_args
    @large_bitmap.paint_vertical(4, 9, 2, 'V')
    pixels = (1..10).collect { |y| @large_bitmap.grid.get_value_at_point(4, y) }
    assert_equal 'OVVVVVVVVO', pixels.join
  end

  def test_paint_horizontal
    @large_bitmap.paint_horizontal(2, 9, 6, 'H')
    pixels = (1..10).collect { |x| @large_bitmap.grid.get_value_at_point(x, 6) }
    assert_equal 'OHHHHHHHHO', pixels.join
  end

  # Test when x2 < x1
  def test_paint_horizontal
    @large_bitmap.paint_horizontal(9, 2, 6, 'H')
    pixels = (1..10).collect { |x| @large_bitmap.grid.get_value_at_point(x, 6) }
    assert_equal 'OHHHHHHHHO', pixels.join
  end

  def test_fill

  end

end
