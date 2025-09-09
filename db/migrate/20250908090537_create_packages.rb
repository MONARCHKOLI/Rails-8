class CreatePackages < ActiveRecord::Migration[8.0]
  def change
    create_table :packages do |t|
      t.references :order, null: false, foreign_key: true
      t.string :tracking_number
      t.integer :status
      t.date :expected_delivery

      t.timestamps
    end
  end
end
