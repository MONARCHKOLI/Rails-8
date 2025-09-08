class AddDetailsToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :image_url, :string
    add_column :products, :rating_rate, :decimal
    add_column :products, :rating_count, :integer
    add_column :products, :category, :string
  end
end
