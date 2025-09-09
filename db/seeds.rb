# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'open-uri'
require 'json'

url = 'https://fakestoreapi.com/products'
products = JSON.parse(URI.open(url).read)

products.each do |product|
  Product.create!(
    name: product['title'],
    price: product['price'],
    description: product['description'],
    stock: rand(10..100),
    category: product['category'],
    image_url: product['image'],
    rating_rate: product['rating']['rate'],
    rating_count: product['rating']['count']
  )
end
