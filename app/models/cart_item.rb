class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validate :default_quantity


  private

  def default_quantity
    self.quantity ||= 1
  end
end
