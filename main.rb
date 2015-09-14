#!/usr/bin/env ruby

require_relative './hp9100a.rb'

puts "Usage: ./#{__FILE__} file1 file2 filen" if ARGV.size == 0

ARGV.each do |file|
  hp = HP9100A.new
  File.open(file).each_line { |line| hp.push(line.chomp) }
  puts "Input file: #{file}"
  puts "Max stack size: #{hp.max_stack_size}"
  puts "Stack size: #{hp.stack_size}"
  puts "Value at top: #{hp.stack_top}"
  puts "\n" unless file == ARGV.last
end

