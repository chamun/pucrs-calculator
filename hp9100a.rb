#!/usr/bin/env ruby

class HP9100A
  OPERATORS = %w(+ * - /)

  def initialize(input)
    @data = parse(input)
  end

  def self.calculate(input)
    new(input).calculate
  end

  def calculate
    operands = []
    stack = []

    while @data.size != 0
      result = @data.shift
      result = apply(result, stack) if operator?(result)
      stack << result
    end

    stack.last
  end

  private

  def operator?(operator)
    OPERATORS.include?(operator)
  end

  def apply(operator, stack)
    stack.pop(2).reverse.reduce(operator)  
  end

  def parse(data)
    data.split(" ").map { |i| operator?(i) ? i : i.to_f }
  end
end
