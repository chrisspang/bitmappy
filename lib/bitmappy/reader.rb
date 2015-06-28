
# Reader class to handle parsing input

class Reader
  attr_accessor :bitmap

  def initialize
    @bitmap = nil
  end

  def read_command_loop
    print ">"
    ARGF.each_with_index do |line, idx|
      begin
        handle_input(line)
      rescue StandardError => e
        puts e.message
      end
      print ">"
    end
  end

  private

  def handle_input(line)
    ## Do something or error
  end

  # Commands

  # Create
  def cmd_I

  end

  # Clear
  def cmd_C

  end

  # Paint Pixel
  def cmd_L

  end

  # Paint vertical
  def cmd_V

  end

  # Paint horizontal
  def cmd_H

  end

  # Fill Region
  def cmd_F

  end

  # Show Image
  def cmd_S

  end

  # Exit
  def cmd_X
    exit
  end

end

