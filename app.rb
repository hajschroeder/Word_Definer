#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
require './lib/definer'
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
  "this will show the word based on its ID. Value will be #{params[:id]}"
end

post '/words' do
  name = params[:word_name]
  word = Word.new(name, nil)
  word.save()
  @user_words = Word.all()
  erb(:words)
end

get '/words/:id/edit' do
  "this will take us to a form to updating the ID. #{params[:id]}"
end

patch '/words/:id' do
  "this will update the word, we may not need this here but rather for the definitions"
end

delete '/words/:id' do
  "this will delete a word"
end

get '/custom_route' do
  "what it sounds like. Again, we may not need this, but it's important to remember we have that available to us"
end
