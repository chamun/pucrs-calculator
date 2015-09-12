require 'rspec'
require_relative '../hp9100a.rb'

describe HP9100A do
  subject { HP9100A.new(input) }

  describe '#calculate' do
    shared_examples_for 'an operation' do
      it 'yields the right result' do
        expect(subject.calculate).to eq(result)
      end
    end
    
    describe 'sum' do
      let(:input) { '2 2 +' }
      let(:result) { 4.0 }
      include_examples 'an operation'
    end

     describe 'multiplication' do
       let(:input) { '2 4 *' }
       let(:result) { 8.0 }
       include_examples 'an operation'
     end

     describe 'subtraction' do
       context 'a - b' do
         let(:input) { '2 4 -' }
         let(:result) { 2 }
         include_examples 'an operation'
       end

       context 'b - a' do
         let(:input) { '4 2 -' }
         let(:result) { -2 }
         include_examples 'an operation'
       end
     end

     describe 'division' do
       context 'a / b' do
         let(:input) { '4 2 /' }
         let(:result) { 0.5 }
         include_examples 'an operation'
       end

       context 'b / a' do
         let(:input) { '2 4 /' }
         let(:result) { 2 }
         include_examples 'an operation'
       end
     end

     describe 'pop' do
       let(:input) { '2 pop' }
       let(:result) { nil }
       include_examples 'an operation'
     end

     describe 'dup' do
       let(:input) { '3 2 dup' }
       let(:result) { 2 }
       include_examples 'an operation'
     end

     describe 'swap' do
       let(:input) { '3 2 swap' }
       let(:result) { 3 }
       include_examples 'an operation'
     end

     describe 'cos' do
       let(:input) { "#{Math::PI / 2} cos" }
       let(:result) { Math.cos(Math::PI / 2) }
       include_examples 'an operation'
     end

     describe 'sin' do
       let(:input) { "#{Math::PI / 2} sin" }
       let(:result) { Math.sin(Math::PI / 2) }
       include_examples 'an operation'
     end

     describe 'atan' do
       let(:input) { "2 3 atan" }
       let(:result) { Math.atan2(3, 2) }
       include_examples 'an operation'
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
