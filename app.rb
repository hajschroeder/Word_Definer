#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
require './lib/word_class'
require './lib/definition_class'
require 'pry'
also_reload 'lib/**/*.rb'
puts "let's do this"

get '/' do
  @user_words = Word.all
  erb(:words)
end

get '/words' do
  @user_words = Word.all
  erb(:words)
end


get '/words/new' do 
  erb(:new_word)
end

get '/words/:id' do
  @word_clicked = Word.find(params[:id].to_i())
  erb(:word)
end

post '/words' do
  name = params[:word_name]
  word = Word.new(name, nil)
  word.save()
  @user_words = Word.all()
  erb(:words)
end

get '/words/:id/edit' do
  @word_clicked = Word.find(params[:id].to_i())
  erb(:edit_word)
end

patch '/words/:id' do
  @word_clicked = Word.find(params[:id].to_i())
  @word_clicked.update(params[:word])
  @user_words= Word.all
  erb(:words)
end

delete '/words/:id' do
  @word_clicked = Word.find(params[:id].to_i())
  @word_clicked.delete()
  @user_words = Word.all
  erb(:words)
end

get '/words/:id/definitions' do
  @definition = Definition.find(params[:id].to_i())
  erb(:definition)
end

post 'words/:id/definitions' do
  @word_clicked = Word.find(params[:id].to_i())
  definition = Defnition.new(params[:definition_name], @word.id, nil)
  definition.save()
  erb(:word)
end

patch '/words/:id/definitions/:definition_id' do
  @word_clicked = Word.find(params[:id].to_i())
  definition = Definition.find(params[:definition_id].to_i())
  definition.update(params[:name], @word.id)
  erb(:word)
end

delete '/words/:id/definitions/:definition_id' do
  definition = Definition.find(params[:definition_id].to_i())
  definition.delete
  @word_clicked = Word.find(params[:id].to_i())
  erb(:word)
end

get '/custom_route' do
  "what it sounds like. Again, we may not need this, but it's important to remember we have that available to us"
end
