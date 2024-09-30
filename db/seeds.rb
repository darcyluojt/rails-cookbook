# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Bookmark.destroy_all
Category.destroy_all
Recipe.destroy_all
url1 = "https://takethemameal.com/files_images_v2/stam.jpg"
Recipe.create(name: "chicken wings", rating: 7.2,
description: "cooked in in the oven for 15 minutes. Make sure they are well seasoned", image_url: url1)

Recipe.create(name: "pancake", description: "delicious breakfast that can couple with peanut butter, fruits and berries", rating: 8, image_url: "https://www.allrecipes.com/thmb/WqWggh6NwG-r8PoeA3OfW908FUY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/21014-Good-old-Fashioned-Pancakes-mfs_001-1fa26bcdedc345f182537d95b6cf92d8.jpg")
Recipe.create(name: "steak", description: "sirloin or ribeye are perfect option for cooking a steak. It is best to eat with roasted vegetables and chips", rating: 9.2, image_url: "https://www.seriouseats.com/thmb/-KA2hwMofR2okTRndfsKtapFG4Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2015__05__Anova-Steak-Guide-Sous-Vide-Photos15-beauty-159b7038c56a4e7685b57f478ca3e4c8.jpg")
Recipe.create(name: "pumpkin soup", description: "steam the pumpkin, onion, carrot and leek until they are cooked, put them in some hot water then blend it", rating: 6.7, image_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-879453_11-5257860.jpg?quality=90&webp=true&resize=440,400")
