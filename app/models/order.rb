class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  enum status: { pending: 0, processing: 1, shipped: 2, delivered: 3, cancelled: 4 }
end
