
require 'test_helper'

class BitmapTest < Minitest::Test

  def setup
    @small_bitmap = Bitmap.new(3,3)
  end

  def test_bitmap_new
    assert_instance_of Bitmap, @small_bitmap
  end

  # Requirement: width/height must be in range 1-250
  def test_bitmap_new_badargs

    [ -10, 0, 251 ].each do |arg|
      assert_raises ArgumentError do
        bitmap = Bitmap.new(arg, 10)
      end

      assert_raises ArgumentError do
        bitmap = Bitmap.new(10, arg)
      end
    end
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
