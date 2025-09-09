class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :two_factor_authenticatable,
         :omniauthable, omniauth_providers: [ :saml ]

  has_many :orders
  has_many :messages
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items



  def admin?
    role == 0
  end

  def customer?
    role == 2
  end
end
