# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"

Bookmark.destroy_all
Category.destroy_all
Recipe.destroy_all


category_url = "https://www.themealdb.com/api/json/v1/1/categories.php"
category_uri = URI.parse(category_url).read
categories_array = JSON.parse(category_uri)["categories"]

categories_array.each do |category|
  # create the new category with the name and the category_url
  search_str = category["strCategory"]
  new_category = Category.create(name: search_str, category_url: category["strCategoryThumb"])
  p "#{search_str} category created"
  # use the category recipes api to get meals information
  main_path = "http://www.themealdb.com/api/json/v1/1/filter.php?c="
  full_url = main_path + search_str
  uri = URI.parse(full_url).read
  meals = JSON.parse(uri)["meals"]
  # iterate the meal to create recipe data: name,
  meals.each do |meal|
    new_meal = Recipe.new(name: meal["strMeal"], image_url: meal["strMealThumb"])
    meal_path = "http://www.themealdb.com/api/json/v1/1/lookup.php?i=#{meal["idMeal"]}"
    meal_uri = URI.parse(meal_path).read
    meal_content = JSON.parse(meal_uri)["meals"][0]
    new_meal.description = meal_content["strInstructions"]
    new_meal.rating = rand(1..10)
    new_meal.save
    p "#{new_meal.name} meal created"
    new_bookmark = Bookmark.new(comment: "a dish that is categorised in #{new_category.name}")
    new_bookmark.recipe = new_meal
    new_bookmark.category = new_category
    p new_bookmark
    p new_bookmark.valid?
    p new_bookmark.errors.full_messages
    new_bookmark.save
    p "bookmark created"
  end
end

# url = "www.themealdb.com/api/json/v1/1/categories.php"
# category_upi = URI.parse(url)
# p category_upi
# str = category_upi.read
# p str
# p JSON.parse(str)["categories"]


# url1 = "https://takethemameal.com/files_images_v2/stam.jpg"
# Recipe.create(name: "chicken wings", rating: 7.2,
# description: "cooked in in the oven for 15 minutes. Make sure they are well seasoned", image_url: url1)

# Recipe.create(name: "pancake", description: "delicious breakfast that can couple with peanut butter, fruits and berries", rating: 8, image_url: "https://www.allrecipes.com/thmb/WqWggh6NwG-r8PoeA3OfW908FUY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/21014-Good-old-Fashioned-Pancakes-mfs_001-1fa26bcdedc345f182537d95b6cf92d8.jpg")
# Recipe.create(name: "steak", description: "sirloin or ribeye are perfect option for cooking a steak. It is best to eat with roasted vegetables and chips", rating: 9.2, image_url: "https://www.seriouseats.com/thmb/-KA2hwMofR2okTRndfsKtapFG4Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2015__05__Anova-Steak-Guide-Sous-Vide-Photos15-beauty-159b7038c56a4e7685b57f478ca3e4c8.jpg")
# Recipe.create(name: "pumpkin soup", description: "steam the pumpkin, onion, carrot and leek until they are cooked, put them in some hot water then blend it", rating: 6.7, image_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-879453_11-5257860.jpg?quality=90&webp=true&resize=440,400")

require "faker"
# Category.create(name: "Indian")
#               Category.create(name: "Fusion")
#               Category.create(name: "Italian")
#               Category.create(name: "French")
# 50.times do
#   Recipe.create(
#     name: Faker::Food.dish,
#     description: Faker::Food.description,
#     image_url: Faker::LoremFlickr.image,
#     rating: rand(0..10).to_f + [ 0, 0.5 ].sample,
#   )
# end
{ "idCategory"=>"1", "strCategory"=>"Beef", "strCategoryThumb"=>"https://www.themealdb.com/images/category/beef.png", "strCategoryDescription"=>"Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]" }
