class RenameTwoFactorColumns < ActiveRecord::Migration[7.0]
  def change
    # rename existing columns to gem's expected names
    rename_column :users, :otp_secret, :encrypted_otp_secret
    rename_column :users, :backup_codes, :otp_backup_codes

    # add missing fields
    add_column :users, :encrypted_otp_secret_iv, :string
    add_column :users, :encrypted_otp_secret_salt, :string
  end
end
