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

get('/words/:id/definitions/:definition_id') do
  @definition = Definition.find(params[:definition_id].to_i())
  erb(:definition)
end

post('/words/:id/definitions') do
  @word_clicked = Word.find(params[:id].to_i())
  definition = Definition.new(params[:definition_name], @word_clicked.id, nil)
  definition.save()
  erb(:word)
end

patch('/words/:id/definitions/:definition_id') do
  @word_clicked = Word.find(params[:id].to_i())
  definition = Definition.find(params[:definition_id].to_i())
  definition.update(params[:name], @word_clicked.id, nil)
  erb(:word)
end

delete '/words/:id/definitions/:definition_id' do
  definition = Definition.find(params[:definition_id].to_i())
  definition.delete
  @word_clicked = Word.find(params[:id].to_i())
  erb(:word)
end

