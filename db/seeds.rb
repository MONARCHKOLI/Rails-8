# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Product.create([
  { name: "Laptop", description: "High performance laptop", price: 1200.50, stock: 10 },
  { name: "Headphones", description: "Noise-cancelling headphones", price: 200.99, stock: 25 },
  { name: "Smartphone", description: "Latest model smartphone", price: 999.99, stock: 15 }
])
