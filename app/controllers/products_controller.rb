class ProductsController < ApplicationController
  before_action :authenticate_user!

  before_action :authorize_admin!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Product created successfully."
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product deleted successfully."
  end


   private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end

  def authorize_admin!
    redirect_to products_path, alert: "Access denied." unless current_user.admin?
  end
end
