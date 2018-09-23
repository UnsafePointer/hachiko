def count_lines(file_path:)
  raise ArgumentError.new("File path #{file_path} doesn't exist") unless File.file?(file_path)
  return `wc -l #{file_path}`.split(' ').first.to_i
end

def instruction_line?(log_line:)
  raise ArgumentError.new("Empty line") if log_line.empty?
  return !log_line.match(/OP: (0[xX][0-9a-fA-F]+)/).nil?
end

class StackTrace
  def initialize(limit: 20)
    @stack = []
    @limit = limit
  end

  def push(instruction:, at_line: )
    @stack.shift() if @stack.size >= @limit
    @stack.push("#{at_line}:    #{instruction}")
  end

  def print()
    buffer = ""
    while !@stack.empty? do
      buffer += @stack.pop()
    end
    buffer
  end
end

class InstructionCounter
  def initialize()
    @counter = Hash.new(0)
  end

  def count(log_line:)
    raise ArgumentError.new("Empty log line") if log_line.empty?

    opcode = match(line: log_line)
    @counter[opcode] += 1
  end

  def dump(log_line: '')
    buffer = ""
    if log_line.empty?
      @counter.keys.each do |key|
        buffer += print_opcode(opcode: key)
      end
      return buffer
    end
    print_opcode(opcode: match(line: log_line))
  end

  private

  def print_opcode(opcode:)
    "OP: #{opcode}, Count: #{@counter[opcode]}\n"
  end

  def match(line:)
    raise ArgumentError.new("Empty line") if line.empty?
    return line.match(/OP: (0[xX][0-9a-fA-F]+)/).captures.first
  end
end

class VBlankCounter
  attr_reader :vblank_counter

  def initialize()
    @vblank_counter = 0
  end

  def count(log_line:)
    raise ArgumentError.new("Empty log line") if log_line.empty?

    @scanline = match(line: log_line)
    return unless @scanline

    if @scanline.to_i >= 143
      @vblank_counter += 1
    end
  end

  private

  def match(line:)
    raise ArgumentError.new("Empty line") if line.empty?
    match = line.match(/Scanline: ([0-9]+)/)
    return nil unless match
    return match.captures.first
  end
end
