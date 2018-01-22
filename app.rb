require_relative 'cookbook'    # You need to create this file!
require_relative 'view'

# require_relative 'controller'  # You need to create this file!
# require_relative 'router'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
view = View.new
# controller = Controller.new(cookbook)

require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @all = cookbook.all
  erb :index
end

# get '/about' do
#   erb :about
# end

get '/:index' do
  #puts params[:recipe_index]
  @recipe = cookbook.find(params[:index].to_i)
  "#{@recipe.name.upcase}: #{@recipe.description}"
end
