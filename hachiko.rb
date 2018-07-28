#!/usr/bin/env ruby
require 'thor'
require_relative './common.rb'

class Hachiko < Thor
  desc "instrcmp [LOG1] [LOG2]", "Compare two instruction logs"
  def instrcmp(log1, log2)
    size1 = count_lines(file_path: log1)
    size2 = count_lines(file_path: log2)
    if size1 != size2
      puts "#{log1}: #{size1}"
      puts "#{log2}: #{size2}"
    end

    file1 = File.open(log1, 'r').to_enum
    file2 = File.open(log2, 'r').to_enum

    stack1 = StackTrace.new()
    stack2 = StackTrace.new()

    instruction_counter1 = InstructionCounter.new()
    instruction_counter2 = InstructionCounter.new()
    line = 1
    loop do
      log1_line = file1.next
      stack1.push(instruction: log1_line, at_line: line)
      instruction_counter1.count(log_line: log1_line)
      log2_line = file2.next
      stack2.push(instruction: log2_line, at_line: line)
      instruction_counter2.count(log_line: log2_line)

      unless log1_line.eql?(log2_line)
        puts "Line: #{line}"
        puts "#{log1}:"
        instruction_counter1.dump()
        stack1.print()
        puts "#{log2}:"
        instruction_counter2.dump()
        stack2.print()
        break
      end
      line += 1
    end
  end
end

Hachiko.start
