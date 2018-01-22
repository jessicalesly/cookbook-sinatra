require 'csv'

class Cookbook
  attr_reader :recipes

  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save
  end

  def find(index)
    @recipes[index]
  end

  def save
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.cooking_time, recipe.done, recipe.difficulty]
      end
    end
  end

  private

  def load_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[3] == "true" ? completed = true : completed = false
      row_hash = { name: row[0], description: row[1], cooking_time: row[2], done: completed, difficulty: row[4] }
      @recipes << Recipe.new(row_hash)
    end
  end
end

# cookbook = Cookbook.new("recipes.csv")
# cookbook.add_recipe(cookbook.recipes[0])
# cookbook.remove_recipe(1)
# p cookbook
