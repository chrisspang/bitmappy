
require 'test_helper'

class ReaderTest < Minitest::Test

  def setup
    @reader = Reader.new
  end

  def test_reader_new
    assert_instance_of Reader, @reader
  end

  # For brevity, just check everything at once
  # cmd_ methods are private, so send() is used
  def test_create_all_commands
    @reader.send(:cmd_I, 6, 6)
    @reader.send(:cmd_L, 1, 1, 'A')
    @reader.send(:cmd_C)
    @reader.send(:cmd_L, 1, 1, 'B')
    @reader.send(:cmd_V, 2, 1, 6, 'V')
    @reader.send(:cmd_H, 4, 1, 6, 'H')
    @reader.send(:cmd_F, 6, 6, 'F')
    final_grid = @reader.bitmap.to_s.gsub(/\n/, '')
    assert_equal 'BVFFFFOVFFFFOVFFFFOVFFFFOVFFFFHHHHFF', final_grid
  end

  def test_validate_params_good
    @reader.handle_input('I 5 5')
  end

  def test_validate_params_bad
    assert_raises ArgumentError do
      @reader.handle_input('I 5')
    end
  end

  def test_validate_bitmap_exists_good
    @reader.handle_input('I 6 6')
    @reader.handle_input('L 1 1 L')
  end

  def test_validate_bitmap_exists_bad
    assert_raises StandardError do
      @reader.handle_input('L 1 1 L')
    end
  end

  def test_handle_input_junk
    junk = [
            " asd9f8asdfbasdf b 9^$*(^&V",
            "           I          5 6    ",
            "L 1 2 \u2028",
            "some ctrl [\1\2\3\4\5\6] characters",
            "& * & *) % (* %",
            # etc
           ];
    junk.each do |j|
      assert_raises StandardError do
        @reader.handle_input(j)
      end
    end
  end
end
