require "bitmappy/version"

require 'bitmappy/grid'
require 'bitmappy/bitmap'
require 'bitmappy/reader'

module Bitmappy

  def self.read_input_forever
    reader = Reader.new
    reader.read_command_loop
  end

end
