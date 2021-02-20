class ProductsController < ApplicationController
  def index
    if params[:option] == "hp"
      @products = Product.all.order(price: "DESC")
    elsif params[:option] == "cp"
      @products = Product.all.order(price: "ASC")
    else
      @products = Product.all.order(:id)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
