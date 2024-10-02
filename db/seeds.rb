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
# categories_array.reverse.each do |category|
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
    new_meal.rating = rand(1.0..5.0).round(1)
    new_meal.save
    p "#{new_meal.name} meal created"
    new_bookmark = Bookmark.new(comment: "#{new_meal.name.truncate(5)} in #{new_category.name}")
    new_bookmark.recipe = new_meal
    new_bookmark.category = new_category
    p new_bookmark
    p new_bookmark.valid?
    p new_bookmark.errors.full_messages
    new_bookmark.save
    p "bookmark created"
  end
end
