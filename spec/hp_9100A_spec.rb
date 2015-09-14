require 'rspec'
require_relative '../hp9100a.rb'

describe HP9100A do
  subject { HP9100A.new(input) }

  describe '#max_stack_size' do
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
    let(:input) { '1 2 3' }

    it 'returns the top value of the stack' do
      expect(subject.stack_top).to eq(top)
    end
  end

end
