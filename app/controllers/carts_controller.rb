class CartsController < ApplicationController

  before_action :set_line_item, only: [:add_item, :update_item, :delete_item]

  def show
    @line_items = current_cart.line_items
  end

  def add_item
    if @line_item.blank?
      @line_item = current_cart.line_items.build(product_id: params[:product_id])
    end

    @line_item.quantity += params[:quantity].to_i
    @line_item.save
    flash[:success] = 'カートに商品が追加されました'
    redirect_to current_cart
  end

  def update_item
    @line_item.update(quantity: params[:quantity].to_i)
    flash[:success] = 'カート内商品の数量が変更されました'
    redirect_to current_cart
  end

  def delete_item
    @line_item.destroy
    flash[:info] = 'カートの商品が削除されました'
    redirect_to current_cart
  end

  private

  def set_line_item
    @line_item = current_cart.line_items.find_by(product_id: params[:product_id])
  end

end
