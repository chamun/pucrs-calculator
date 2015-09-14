#!/usr/bin/env ruby

class HP9100A
  OPERATORS = %w(+ * - / pop dup swap cos sin atan)

  attr_reader :max_stack_size

  def initialize(input = '')
    @data = input.split(' ').collect { |i| parse(i) }
    @stack = []
    @max_stack_size = 0
    calculate
  end

  def stack_size
    @stack.size
  end

  def stack_top
    @stack.last
  end

  def push(input)
    item = parse(input)
    @stack << ( apply(item) || item )
  end

  private

  def calculate
    while @data.size != 0
      item = @data.shift
      item = apply(item) if operator?(item)
      @stack << item unless item.nil?
      @max_stack_size = [@max_stack_size, @stack.size].max
    end
  end

  def operator?(operator)
    OPERATORS.include?(operator)
  end

  def apply(operator)
    return nil unless operator?(operator)
    send(operator)
  rescue NoMethodError
    @stack.pop(2).reverse.reduce(operator)
  end

  def pop
    @stack.pop && nil
  end

  def dup
    @stack.last
  end

  def swap
    @stack[-1], @stack[-2] = @stack[-2], @stack[1]
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

  def parse(data)
    operator?(data) ? data : data.to_f
  end
end
