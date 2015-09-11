require 'rspec'
require_relative '../hp9100a.rb'

describe HP9100A do
  shared_context 'a calculation method' do
    INPUTS = [
      [ '2 2 +', 4.0],
      [ '2 4 *', 8.0],
      [ '4 2 -', -2],
      [ '2 4 -', 2],
      [ '4 2 /', 0.5],
      [ '2 4 /', 2],
      [ '2 pop', nil],
      [ '3 2 dup', 2]
    ]

    INPUTS.each do |input, result|
      describe input do
        it 'gets the right result' do
          expect(calculation_with(input)).to eq(result)
        end
      end
    end
  end

  describe '#calculate' do
    def calculation_with(input)
      HP9100A.new(input).calculate
    end

    include_context 'a calculation method'
  end

  describe '.calculate' do
    def calculation_with(input)
      HP9100A.calculate(input)
    end

    include_context 'a calculation method'
  end
end
