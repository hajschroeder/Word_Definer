require 'rspec'
require 'definer'

describe '#Word' do 
  before(:each) do
    Word.clear()
  end

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

  describe '#==' do 
    it("is the same word if it has the same attributes an another") do 
      word = Word.new("foobar", nil)
      word_two = Word.new("foobar", nil)
      expect(word).to eq(word_two)
    end
  end

  describe '.clear' do 
    it("clears all words") do 
      word = Word.new("foo", nil) 
      word.save()
      word_two = Word.new("bar", nil)
      word_two.save()
      Word.clear()
      expect(Word.all).to eq([])
    end
  end

  describe '.find' do
    it("finds a word by ID") do
      word = Word.new("foo", nil)
      word.save()
      word_two = Word.new("bar", nil)
      word_two.save()
      expect(Word.find(word.id)).to eq(word)
    end
  end

  describe '#update' do
    it("updates a word by ID") do 
      word_one = Word.new("foobar", nil)
      word_one.save()
      word_one.update("foobarbaz")
      expect(word_one.word).to eq("foobarbaz")
    end
  end

  describe '#delete' do 
    it("deletes a word by ID") do 
      word_one = Word.new("foo", nil)
      word_one.save()
      word_two = Word.new("bar", nil)
      word_two.save()
      word_three = Word.new("baz", nil)
      word_three.save()
      word_one.delete()
      expect(Word.all).to eq([word_two, word_three])
    end
  end

  describe '.search' do 
    it("searches for a word") do
      word_one = Word.new("lorem", nil)
      word_one.save()
      word_two = Word.new("ipsum", nil)
      word_two.save()
      word_three = Word.new("foobar", nil)
      word_three.save()
      expect(Word.search("lorem")).to eq(word_one)
    end
  end
end
