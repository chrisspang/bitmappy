
require 'test_helper'

class GridTest < Minitest::Test

  def setup
    @small_grid = Grid.new(3,3)
  end

  def test_grid_new
    assert_instance_of Grid, @small_grid
  end

  # Requirement: width/height must be in range 1-250
  def test_grid_new_badargs

    [ -10, 0, 251 ].each do |arg|
      assert_raises ArgumentError do
        grid = Grid.new(arg, 10)
      end

      assert_raises ArgumentError do
        grid = Grid.new(10, arg)
      end
    end
  end

  # set_value_at_point() / get_value_at_point()
  def test_get_value_at_point_default_value
    value = @small_grid.get_value_at_point(1,1)
    assert_equal 'O', value
  end

  def test_set_value_at_point
    value = @small_grid.set_value_at_point(1,1, 'X')
    assert_equal 'X', value
  end

  def test_get_value_at_point_bad_coords
    assert_raises ArgumentError do
      value = @small_grid.get_value_at_point(10,10)
    end
  end

  def test_set_value_at_point_bad_coords
    assert_raises ArgumentError do
      @small_grid.set_value_at_point(10,10, 'X')
    end
  end

end
