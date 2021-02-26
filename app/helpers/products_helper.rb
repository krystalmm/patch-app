module ProductsHelper
  def change_consumption_tax(price)
    tax = 1.1
    (price * tax).round(2).ceil
  end

  def all_products_count
    Product.count
  end

  def stock_judg
    product = Product.find(params[:id])
    if product.stock_quantity > 3
      '○'

    elsif product.stock_quantity < 4 && product.stock_quantity.positive?
      '△'

    else
      '×'

    end
  end
end
