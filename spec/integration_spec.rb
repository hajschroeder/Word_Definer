require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a word path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    visit('/')
    click_on('Add a new word')
    fill_in('word_name', :with => 'Ophelia')
    click_on('Lets Go!')
    expect(page).to have_content('Ophelia')
  end
end

describe('create an edit word path', {:type => :feature}) do
  it('goes to the edit word page and allows the edit') do
    word = Word.new("Ophelia", nil)
    word.save
    visit("/words/#{word.id}/edit")
    fill_in('name', :with => 'Ophelia Thee Stallion')
    click_on('Update')
    expect(page).to have_content('Ophelia Thee Stallion')
  end
end

describe('create a delete word path', {:type => :feature}) do
  it('goes to the edit word page and allows a user to delete') do
    Word.clear()
    word = Word.new("Ophelia", nil)
    word.save
    word2 = Word.new("Books",nil)
    word2.save
    visit("/words/#{word.id}/edit")
    click_on('Delete')
    expect(page).to have_no_content('Ophelia')
  end
end

describe('create a definition path', {:type => :feature}) do
  it('creates a definition') do
    word = Word.new("Ophelia", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('definition_name', :with => 'The best cat!')
    click_on('Add definition')
    expect(page).to have_content('The best cat!')
  end
end

describe('create a edit definition path', {:type => :feature}) do
  it('goes to the edit word page and allows a user to edit the definition') do
    Word.clear()
    word = Word.new("Ophelia", nil)
    word.save()
    definition= Definition.new("The best cat", word.id, nil)
    definition.save()
    visit("/words/#{word.id}/definitions/#{definition.id}")
    fill_in("name", :with => 'The best cat EVER')
    click_on('Update definition')
    expect(page).to have_content('The best cat EVER')
  end
end

describe('create a delete definition path', {:type => :feature}) do
  it('goes to the edit definition page and and then allows a user to delete the definition') do
    Word.clear()
    word = Word.new("Ophelia", nil)
    word.save()
    definition= Definition.new("The best cat", word.id, nil)
    definition.save()
    visit("/words/#{word.id}/definitions/#{definition.id}")
    click_on('Delete definition')
    expect(page).to have_no_content('big fish')
  end
end