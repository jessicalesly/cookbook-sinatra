require 'open-uri'
require 'nokogiri'

class ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
    @url = "http://www.marmiton.org"
    @recipes_array = []
  end

  def call
    # TODO: return a list of `Recipes` built from scraping the web.
    # Parse the HTML document to extract the useful recipe info
    open_url("#{@url}/recettes/recherche.aspx?aqt=#{@keyword}").search('.recipe-card').each do |element|
      recipe_hash = {
        name: extract(element, '.recipe-card__title'),
        description: extract(element, '.recipe-card__description'),
        cooking_time: extract(element, '.recipe-card__duration__value'),
        difficulty: extract(open_url("#{@url}#{element.attribute('href').value}"), '.recipe-infos__level span')
      }
      @recipes_array << recipe_hash
    end
    return @recipes_array
  end

  def extract(elt, css_class)
    elt.search(css_class).first.text.strip
  end

  def open_url(url)
    html_file = open(url).read
    Nokogiri::HTML(html_file)
  end
end
