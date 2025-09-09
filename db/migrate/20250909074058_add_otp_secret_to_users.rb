class AddOtpSecretToUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :encrypted_otp_secret, if_exists: true

    # Add encrypted string column — Rails handles encryption automatically
    add_column :users, :otp_secret, :string
  end
end
