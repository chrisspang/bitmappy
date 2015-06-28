
require 'test_helper'

class ReaderTest < Minitest::Test

  def setup
    @reader = Reader.new
  end

  def test_reader_new
    assert_instance_of Reader, @reader
  end


end
