def count_lines(file_path:)
  raise ArgumentError.new("File path #{file_path} doesn't exist") unless File.file?(file_path)
  return `wc -l #{file_path}`.split(' ').first.to_i
end

class StackTrace
  def initialize(limit: 10)
    @stack = []
    @limit = limit
  end

  def push(instruction:, at_line: )
    @stack.shift() if @stack.size >= @limit
    @stack.push("#{at_line}:    #{instruction}")
  end

  def print()
    while !@stack.empty? do
      puts @stack.pop()
    end
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
    if log_line.empty?
      @counter.keys.each do |key|
       print_opcode(opcode: key)
      end
      return
    end
    print_opcode(opcode: match(line: log_line))
  end

  private

  def print_opcode(opcode:)
    puts "OP: #{opcode}, Count: #{@counter[opcode]}"
  end

  def match(line:)
    raise ArgumentError.new("Empty line") if line.empty?
    return line.match(/OP: (0[xX][0-9a-fA-F]+)/).captures.first
  end
end
