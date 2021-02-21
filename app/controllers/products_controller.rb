class ProductsController < ApplicationController
  def index
    if params[:option] == "hp"
      @products = Product.page(params[:page]).per(9).order(price: "DESC")
    elsif params[:option] == "cp"
      @products = Product.page(params[:page]).per(9).order(price: "ASC")
    else
      @products = Product.page(params[:page]).per(9).order(:id)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
