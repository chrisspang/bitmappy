
# Reader class to handle parsing input

class Reader
  attr_accessor :bitmap, :snapshots, :current_snapshot

  def initialize
    @bitmap = nil
    @snapshots = Array.new
    @current_snapshot = nil
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

  # Undo
  def cmd_U
    # Make sure we don't try to save the result of this action
    @current_snapshot = nil

    raise "No undos left" if @snapshots.length == 0

    last_snapshot = @snapshots.pop
    @bitmap = Bitmap.new(1, 1)  # Size will be overwritten
    @bitmap.load_from_json(last_snapshot)
  end

  # Save our current state into current_snapshot
  def create_snapshot
    @current_snapshot = @bitmap.to_json if @bitmap
  end

  # Save the current_snapshot if our state has changed
  def save_snapshot
    return unless @current_snapshot
    current_state = @bitmap.to_json
    return if snapshots_match?(@current_snapshot, current_state)

    @snapshots << @current_snapshot
  end

  # Validate a bitmap has been created
  def validate_bitmap
    raise "Create a bitmap first" unless @bitmap
  end

  ## Snapshots are just JSON so quick and dirty solution is just to
  ## compare them (assume key ordering is consistent...)
  def snapshots_match?(s1, s2)
    s1 == s2
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

      'U' => [],                                            # U
    }

    raise "Invalid command" unless valid_commands.has_key?(cmd)

    valid_params = validate_params(valid_commands[cmd], args)

    # Most methods require us to have created a bitmap
    validate_bitmap() if %w( C L V H F S ).include?(cmd)

    create_snapshot()

    method = "cmd_#{cmd}".to_sym
    #    p method, valid_params
    self.send(method, *valid_params)

    save_snapshot()
  end

end

