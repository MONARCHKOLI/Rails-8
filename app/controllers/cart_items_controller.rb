class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:product)
  end

  def create
    @product = Product.find(params[:product_id])
    @cart_item = current_user.cart_items.find_or_create_by(product: @product)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path }
    end
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @product = @cart_item.product
    @cart_item.destroy

    @cart_items = current_user.cart_items.includes(:product)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path }
    end
  end

  def update
    @cart_item = current_user.cart_items.find(params[:id])
    if @cart_item.product.stock >= params[:quantity].to_i
      redirect_to cart_items_path, notice: "Cart item updated." if @cart_item.update(quantity: params[:quantity])
    else
      redirect_to cart_items_path, alert: "Failed to update cart item."
    end
  end
end
