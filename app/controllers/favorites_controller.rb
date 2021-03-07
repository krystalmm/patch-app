class FavoritesController < ApplicationController
  before_action :set_product

  def create
    favorite = current_user.favorites.new(product_id: @product.id)
    favorite.save
  end

  def destroy
    favorite = current_user.favorites.find_by(product_id: @product.id)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
