class CartsController < ApplicationController
  before_action :set_line_item, only: [:add_item, :update_item, :delete_item]

  def show
    @line_items = current_cart.line_items
  end

  def add_item
    @line_item = current_cart.line_items.build(product_id: params[:product_id]) if @line_item.blank?

    @line_item.quantity += params[:quantity].to_i
    if params[:quantity].to_i > 0
      @line_item.save
      flash[:success] = 'カートに商品が追加されました'
      redirect_to current_cart
    else
      flash[:danger] = '商品の在庫がありません <br> 再入荷するまで少々お待ち下さい'
      redirect_to current_cart
    end
  end

  def update_item
    if params[:quantity].to_i <= @line_item.product.stock_quantity
      @line_item.update(quantity: params[:quantity].to_i)
      flash[:success] = 'カート内商品の数量が変更されました'
      redirect_to current_cart
    else
      flash[:danger] = '商品の在庫数をご確認ください'
      redirect_to product_path(@line_item.product)
    end
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
