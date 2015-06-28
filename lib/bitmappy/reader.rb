
# Reader class to handle parsing input

class Reader
  attr_accessor :bitmap

  def initialize
    @bitmap = nil
  end

  def read_command_loop

    ## Simple debugging
    puts "10x5 grid"
    @bitmap = Bitmap.new(10,5)

    puts "S (show)"
    puts @bitmap.to_s

    puts "L 1 2 X (paint pixel)"
    @bitmap.paint_pixel(1, 2, 'X')

    puts "S (show)"
    puts @bitmap.to_s

    puts "V X Y1 Y2 C (paint vertical)"
    @bitmap.paint_vertical(7, 2, 3, 'V')

    puts "V X Y1 Y2 C (paint vertical)"
    @bitmap.paint_vertical(8, 3, 2, 'A')

    puts "S (show)"
    puts @bitmap.to_s

    puts "H X1 X2 Y C (paint horizontal)"
    @bitmap.paint_horizontal(2, 9, 5, 'H')

    puts "S (show)"
    puts @bitmap.to_s

    puts "F X Y C (fill region)"
    @bitmap.fill(4, 4, 'F')

    puts "S (show)"
    puts @bitmap.to_s

    return
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

