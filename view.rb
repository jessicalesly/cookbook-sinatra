# require_relative 'recipe'

class View
  def ask_user_stuff(stuff)
    puts "What is the #{stuff}"
    print "> "
    gets.chomp
  end

  def display_recipes(recipes)
    puts "-------------RECIPES---------------"
    recipes.each_with_index do |recipe, index|
      recipe.done? ? status = "[x]" : status = "[]"
      puts "#{status} #{index + 1}- #{recipe.name}: #{recipe.description}, #{recipe.cooking_time}, #{recipe.difficulty}"
    end
    puts "----------------------------"
  end

  def display_imported_recipes(ingredient, array_of_hashes)
    puts "Looking for '#{ingredient}' on Marmitton..."
    puts "#{array_of_hashes.length} results found!"
    array_of_hashes.each_with_index do |recipe_hash, index|
      puts "#{index + 1}. #{recipe_hash[:name]}"
    end
  end
end

# recipe1 = Recipe.new("Cheesecake", "pojfowsgmoqmofi")
# recipe2 = Recipe.new("yaourt", "blabla")
# recipe3 = Recipe.new("fromage", "ooooooo")

# view = View.new
# view.display_recipes([recipe1, recipe2, recipe3])


