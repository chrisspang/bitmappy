
require 'test_helper'

class BitmapTest < Minitest::Test

  def setup
    @small_bitmap = Bitmap.new(3,3)
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
  
end
