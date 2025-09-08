class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :integer, default: 2
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :otp_secret, :string
    add_column :users, :backup_codes, :text
  end
end
