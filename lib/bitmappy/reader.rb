
# Reader class to handle parsing input

class Reader
  attr_accessor :bitmap

  def initialize
    @bitmap = nil
  end

  def read_command_loop

    print_prompt
    ARGF.each_with_index do |line, idx|
      begin
        handle_input(line)
      rescue StandardError => e
        puts e.message
      end
      print_prompt
    end
  end

  def handle_input(line)
    # Note: We don't left strip due to the specification
    # "command is [...] capital letter at the beginning of the line"
    command, *args = line.rstrip.split(/\s+/)
    return if !command

    run_command(command, args)
  end

  private

  def print_prompt
    print "> "
  end

  # Commands

  # Create
  def cmd_I(width, height)
    @bitmap = Bitmap.new(width, height)
  end

  # Clear
  def cmd_C
    @bitmap.reset_grid
  end

  # Paint Pixel
  def cmd_L(x, y, c)
    @bitmap.paint_pixel(x, y, c)
  end

  # Paint vertical
  def cmd_V(x, y1, y2, c)
    @bitmap.paint_vertical(x, y1, y2, c)
  end

  # Paint horizontal
  def cmd_H(x1, x2, y, c)
    @bitmap.paint_horizontal(x1, x2, y, c)
  end

  # Fill Region
  def cmd_F(x, y, c)
    @bitmap.fill(x, y, c)
  end

  # Show Image
  def cmd_S
    puts @bitmap.to_s
  end

  # Exit
  def cmd_X
    exit
  end

  # Validate a bitmap has been created
  def validate_bitmap
    raise "Create a bitmap first" unless @bitmap
  end

  # Validation commands and parameters
  def validate_params(wanted, got)
    arg_regex = {
      :integer   => /\A\d+\z/,     # Integer (not range checked here)
      :character => /\A[A-Z]\z/,   # Upper case letter
    }

    raise ArgumentError, "Bad arguments for command" if (wanted.length != got.length)

    actual_params = Array.new

    wanted.zip(got).each do |a,b|
      raise ArgumentError, "Bad argument '#{b}'" unless arg_regex[a] =~ b
      actual_params.push(a == :integer ? b.to_i : b.to_s)
    end

    return actual_params
  end

  # Validate command and parameters are good, run the command
  def run_command(cmd, args)
    valid_commands = {
      'I' => [ :integer, :integer ],                        # I X Y
      'C' => [],                                            # C
      'L' => [ :integer, :integer, :character ],            # L X Y C
      'V' => [ :integer, :integer, :integer, :character ],  # V X Y1 Y2 C
      'H' => [ :integer, :integer, :integer, :character ],  # H X1 X2 Y C
      'F' => [ :integer, :integer, :character ],            # F X Y C
      'S' => [],                                            # S
      'X' => [],                                            # X
    }

    raise "Invalid command" unless valid_commands.has_key?(cmd)

    valid_params = validate_params(valid_commands[cmd], args)

    method = "cmd_#{cmd}".to_sym

    # All methods other than 'I' require us to have created a bitmap
    validate_bitmap() unless (cmd.eql?('I'))

#    p method, valid_params
    self.send(method, *valid_params)
  end

end

