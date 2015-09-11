require 'rspec'
require_relative '../hp9100a.rb'

describe HP9100A do
  describe '#calculate' do
    def calculation_with(input)
      HP9100A.new(input).calculate
    end

    INPUTS = [
      [ '2 2 +', 4.0],
      [ '2 4 *', 8.0],
      [ '4 2 -', -2],
      [ '2 4 -', 2],
      [ '4 2 /', 0.5],
      [ '2 4 /', 2],
      [ '2 pop', nil],
      [ '3 2 dup', 2],
      [ '3 2 swap', 3],
      [ "#{Math::PI / 2} cos", Math.cos(Math::PI / 2)],
      [ "#{Math::PI / 2} sin", Math.sin(Math::PI / 2)],
      [ "2 3 atan", Math.atan2(3, 2)]
    ]

    INPUTS.each do |input, result|
      describe input do
        it 'gets the right result' do
          expect(calculation_with(input)).to eq(result)
        end
      end
    end
  end

  describe '.calculate' do
    let(:input) { 'some input' }

    it 'delegates to #create' do
      hp9100a = double('hp9100a')
      expect(hp9100a).to receive(:calculate)
      expect(described_class).to(
        receive(:new)
          .with(input)
          .and_return(hp9100a)
      )
      described_class.calculate(input)
    end
  end
end
