# Requires #input to be defined
# Subject must respond to #push

shared_context 'tokenizer' do
  # Tokenize #input and stack it into the subject
  before do
    input.split(' ').each { |i| subject.push(i) }
  end
end
