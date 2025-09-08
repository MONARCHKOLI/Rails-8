class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :two_factor_authenticatable,
         :omniauthable, omniauth_providers: [ :saml ]

  enum role: { admin: 0, distributor: 1, customer: 2 } if column_names.include?("role")

  has_many :orders
  has_many :messages
end
