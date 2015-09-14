require 'rspec'
require_relative 'support/tokenizer.rb'
require_relative '../hp9100a.rb'

describe 'Test cases' do
  include_context 'tokenizer'

  subject { HP9100A.new }

  shared_examples_for 'an operation' do
    it 'yields the right result' do
      expect(subject.stack_top).to eq(result)
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

  describe 'a composed input' do
    let(:input) { ' 1 2 3 + -' }
    let(:result) { 4.0 }
    include_examples 'an operation'
  end

  describe 'another composed input' do
    let(:input) { ' 2 3 + 1 -' }
    let(:result) { -4.0 }
    include_examples 'an operation'
  end

  describe 'a complicated composed input' do
    let(:input) { ' 1 2 3 4 5 + dup - 4 pop +' }
    let(:result) { 3 }
    include_examples 'an operation'
  end
end
