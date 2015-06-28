require "bitmappy/version"

require 'bitmappy/bitmap'
require 'bitmappy/reader'

module Bitmappy

  def self.read_input_forever
    puts "Hello"

    reader = Reader.new
    reader.read_command_loop
  end

end
