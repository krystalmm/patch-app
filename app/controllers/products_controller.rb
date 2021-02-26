class ProductsController < ApplicationController
  def index
    @products = case params[:option]
                when 'hp'
                  Product.page(params[:page]).per(9).order(price: 'DESC')
                when 'cp'
                  Product.page(params[:page]).per(9).order(price: 'ASC')
                else
                  Product.page(params[:page]).per(9).order(:id)
                end
  end

  def show
    @product = Product.find(params[:id])
  end
end
