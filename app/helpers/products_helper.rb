module ProductsHelper
  def change_consumption_tax(price)
    tax = 1.1
    price = ((price * tax).round(2)).ceil
  end

  def all_products_count
    Product.count
  end
end
