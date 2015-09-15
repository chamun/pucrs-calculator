#!/usr/bin/env ruby

class HP9100A
  attr_reader :max_stack_size

  def initialize
    @stack = []
    @max_stack_size = 0
  end

  def stack_size
    @stack.size
  end

  def stack_top
    @stack.last
  end

  def push(input)
    item = parse(input)
    @stack << item unless item.nil?
    @max_stack_size = [@max_stack_size, @stack.size].max
  end

  private

  def parse(input)
    send(input)
  rescue NoMethodError
    input.to_f
  end

  def pop
    @stack.pop
    nil
  end

  def dup
    @stack.last
  end

  def swap
    @stack[-1], @stack[-2] = @stack[-2], @stack[-1]
    nil
  end

  def cos
    Math.cos(@stack.pop)
  end

  def sin
    Math.sin(@stack.pop)
  end

  def atan
    Math.atan2(@stack.pop, @stack.pop)
  end

  def +
    @stack.pop + @stack.pop
  end

  def *
    @stack.pop * @stack.pop
  end

  def -
    @stack.pop - @stack.pop
  end

  def /
    @stack.pop / @stack.pop
  end
end
