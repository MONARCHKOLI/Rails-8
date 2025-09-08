module CartItemsHelper
  def cart_total_amount(cart_items)
    cart_items.sum { |i| i.product.price }
  end
end
