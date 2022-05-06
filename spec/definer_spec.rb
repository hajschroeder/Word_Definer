require 'rspec'
require 'definer'

describe '#Word' do 

  describe '.all' do
    it("returns an empty array when there are no words") do 
      expect(Word.all).to eq([])
    end
  end

  describe '#save' do
    it("saves a word") do
      word = Word.new("foo", nil)
      word.save()
      word_two = Word.new("bar", nil)
      word_two.save()
      expect(Word.all).to eq([word, word_two])
    end
  end

  describe('#==') do 
    it("is the same word if it has the same attributes an another") do 
      word = Word.new("foobar", nil)
      word_two = Word.new("foobar", nil)
      expect(word).to eq(word_two)
    end
  end
end
