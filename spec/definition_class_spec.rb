require 'rspec'
require 'word_class'
require 'definition_class'
require 'pry'

describe '#Definition' do
  before(:each) do
    Word.clear()
    Definition.clear()
    @word = Word.new("foobar", nil)
    @word.save()
  end

  describe('@==') do 
    it("is the same definition is it has the same attributes as another word") do
      definition = Definition.new("a quick brown fox", @word.id, nil)
      definition_two = Definition.new("a quick brown fox", @word.id, nil)
      expect(definition).to eq(definition_two)
    end
  end

  describe('#save') do 
    it("saves a definition") do 
      definition = Definition.new("A quick brown fox", @word.id, nil)
      definition.save()
      expect(Definition.all).to eq([definition])
    end
  end

  describe('.find') do 
    it("finds a definition by ID") do
      definition = Definition.new("A quick brown fox", @word.id, nil)
      definition.save()
      definition_two = Definition.new("The act of jumping over a lazy dog", @word.id, nil)
      definition_two.save()
      expect(Definition.find(definition.id)).to eq(definition)
      expect(Definition.find(definition_two.id)).to eq(definition_two)
    end
  end

  describe('#update') do 
    it("updates a definition by ID") do
      definition = Definition.new("A quick brown fox", @word.id, nil)
      definition.save()
      definition.update("The act of jumping over a lazy dog", @word.id, nil)
      expect(definition.name).to eq("The act of jumping over a lazy dog")
    end
  end
  
  describe('#delete') do 
    it("deletes a definition by ID") do 
      definition = Definition.new("A quick brown fox", @word.id, nil)
      definition.save()
      definition_two = Definition.new("The act of jumping over a lazy dog", @word.id, nil)
      definition_two.save()
      definition.delete()
      expect(Definition.all).to eq([definition_two])
    end
  end

  describe('.find_by_word') do 
    it ("finds definitions for a word") do 
      word_two = Word.new("foobarbaz", nil)
      word_two.save
      definition = Definition.new("A quick brown fox", @word.id, nil)
      definition.save
      definition_two = Definition.new("The act of jumping over a lazy dog", word_two.id, nil)
      definition_two.save
      expect(Definition.find_by_word(word_two.id)).to eq([definition_two])
    end
  end
end