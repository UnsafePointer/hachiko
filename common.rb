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
