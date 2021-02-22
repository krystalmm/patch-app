module ProductsHelper
  def change_consumption_tax(price)
    tax = 1.1
    price = ((price * tax).round(2)).ceil
  end

  def all_products_count
    Product.count
  end

  def stock_judg(product)
    product = Product.find(params[:id])
    if product.stock_quantity > 3
      judg_icon = '○'
      return judg_icon
    elsif product.stock_quantity < 4 && product.stock_quantity > 0
      judg_icon = '△'
      return judg_icon
    else
      judg_icon = '×'
      return judg_icon
    end
  end
end
