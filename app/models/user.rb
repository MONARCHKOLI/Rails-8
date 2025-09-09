class User < ApplicationRecord
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable,
         :two_factor_authenticatable,
         :two_factor_backupable,
         :omniauthable, omniauth_providers: [ :saml ]

  has_many :orders
  has_many :messages
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  encrypts :otp_secret



  def admin?
    role == 0
  end

  def customer?
    role == 2
  end

  def otp_verified?(cookie_timestamp)
    return false if cookie_timestamp.blank?
    Time.at(cookie_timestamp.to_i) > Time.current
  end
end
