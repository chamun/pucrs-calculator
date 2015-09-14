require 'rspec'
require_relative 'support/tokenizer.rb'
require_relative '../hp9100a.rb'

describe HP9100A do
  describe '#max_stack_size' do
    include_context 'tokenizer'

    shared_examples_for 'max stack size' do
      it 'returns the maximum size for the internal stack' do
        expect(subject.max_stack_size).to eq(expected_size)
      end
    end

    context 'size 2' do
      let(:input) { '2 2 +' }
      let(:expected_size) { 2 }
      include_examples 'max stack size'
    end

    context 'size 3' do
      let(:input) { '2 2 dup ' }
      let(:expected_size) { 3 }
      include_examples 'max stack size'
    end

    context 'size 4' do
      let(:input) { '2 2 2 2' }
      let(:expected_size) { 4 }
      include_examples 'max stack size'
    end

    context 'size 4 with empty stack' do
      let(:input) { '2 2 2 2 pop pop pop pop' }
      let(:expected_size) { 4 }
      include_examples 'max stack size'
    end
  end

  describe '#stack_size' do
    include_context 'tokenizer'

    shared_examples_for 'stack size' do
      it 'returns the size of the internal stack' do
        expect(subject.stack_size).to eq(expected_size)
      end
    end

    context 'size 0' do
      let(:input) { '2 2 2 2 pop pop pop pop' }
      let(:expected_size) { 0 }
      include_examples 'stack size'
    end

    context 'size 2' do
      let(:input) { '2 2' }
      let(:expected_size) { 2 }
      include_examples 'stack size'
    end

    context 'size 3' do
      let(:input) { '2 2 dup ' }
      let(:expected_size) { 3 }
      include_examples 'stack size'
    end

    context 'size 4' do
      let(:input) { '2 2 2 2' }
      let(:expected_size) { 4 }
      include_examples 'stack size'
    end
  end

  describe 'stack_top' do
    let(:top) { 3 }

    it 'returns the top value of the stack' do
      [1, 2, top].each { |i| subject.push(i) }
      expect(subject.stack_top).to eq(top)
    end
  end

  describe '#push' do
    shared_examples_for 'an operation' do
      it 'performs the operation' do
        expect(subject.stack_top).to eq(result)
      end
    end

    describe 'a number' do
      it 'is pushed to the top of the stack' do
        subject.push(666)
        expect(subject.stack_top).to eq(666)
      end

      it 'converts it to float' do
        subject.push('666')
        expect(subject.stack_top).to eq(666)
      end
    end

    describe 'an operation' do
      include_context 'tokenizer'

      context 'sum' do
        let(:input) { '2 2 +' }
        let(:result) { 4.0 }
        include_examples 'an operation'
      end

      context 'multiplication' do
        let(:input) {  '2 4 *'  }
        let(:result) { 8 }
        include_examples 'an operation'
      end

      context 'division' do
        let(:input) {  '2 2 /'  }
        let(:result) { 1 }
        include_examples 'an operation'
      end

      context 'subtraction' do
        let(:input) {  '2 2 /'  }
        let(:result) { 1 }
        include_examples 'an operation'
      end
    end
  end
end
