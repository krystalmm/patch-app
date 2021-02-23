class CartsController < ApplicationController

  before_action :set_line_item, only: [:add_item, :update_item, :delete_item]

  def show
    @line_items = current_cart.line_items
  end

  def add_item
    if @line_item.blank?
      @line_item = current_cart.line_items.build(product_id: params[:product_id])
    end

    @line_item.quantity = 1
    @line_item.save
    redirect_to current_cart
  end

  def update_item
    
  end

  def destroy
    @cart.destroy
    redirect_to current_cart
  end

  private

  def set_line_item
    @line_item = current_cart.line_items.find_by(product_id: params[:product_id])
  end

end
