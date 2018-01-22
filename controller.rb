require_relative 'recipe'
require_relative 'view'
require_relative 'scrape_marmiton_service'


class Controller
  def initialize(cookbook)
    @view = View.new
    @cookbook = cookbook
  end

  def create
    name = @view.ask_user_stuff("name of the new recipe ?")
    description = @view.ask_user_stuff("description of the recipe ?")
    cooking_time = @view.ask_user_stuff("cooking time of the recipe ?")
    difficulty = @view.ask_user_stuff("difficulty of the recipe ?")
    recipe = Recipe.new(name: name, description: description, cooking_time: cooking_time, difficulty: difficulty)
    @cookbook.add_recipe(recipe)
  end

  def list
    @view.display_recipes(@cookbook.recipes)
  end

  def destroy
    list
    index = @view.ask_user_stuff("index you want to remove ?").to_i - 1
    @cookbook.remove_recipe(index)
  end

  def mark_a_recipe
    list
    index = @view.ask_user_stuff("index you want to mark as done ?").to_i - 1
    recipe = @cookbook.find(index)
    recipe.mark_as_done!
    @cookbook.save
  end

  def import_recipes
    # Ask a user for a keyword to search
    ingredient = @view.ask_user_stuff("ingredient you want to search on marmitton ?").downcase
    # Make an HTTP request to the recipe's website with our keyword
    scraper = ScrapeMarmitonService.new(ingredient)
    recipes_array = scraper.call
    # Display a list of recipes found to the user
    @view.display_imported_recipes(ingredient, recipes_array)
    # Ask the user which number recipe they want to import
    index = @view.ask_user_stuff("recipe do you want to import?").to_i - 1
    # Add the chosen recipe to the Cookbook
    recipe = Recipe.new(recipes_array[index])
    @cookbook.add_recipe(recipe)
  end
end
