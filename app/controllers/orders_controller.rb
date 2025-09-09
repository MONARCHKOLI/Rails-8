class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items, :products)
  end

  def new
    @products = Product.where("stock > 0")
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.new(status: :pending, total: 0)
    current_user.cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    @order.total = @order.order_items.sum { |oi| oi.price * oi.quantity }

    if @order.save
      current_user.cart_items.destroy_all
      # TODO: Notify admin here
      redirect_to orders_path, notice: "Order placed successfully"
    else
      redirect_to cart_items_path, alert: "Failed to place order"
    end
  end
end
