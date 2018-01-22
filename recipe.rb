class Recipe
  attr_reader :name, :description, :cooking_time, :done, :difficulty
  def initialize(attributes = {})
    @name = attributes[:name] || ""
    @description = attributes[:description] || ""
    @cooking_time = attributes[:cooking_time] || ""
    @done = attributes[:done] || false
    @difficulty = attributes[:difficulty] || ""
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
