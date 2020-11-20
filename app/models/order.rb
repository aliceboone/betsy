class Order < ApplicationRecord

  has_many :order_items
  
  def add_product(product)
    @order_item = self.order_items.where(product_id: product.id).first

    if @order_item
      @order_item.quantity += 1
    else
      @order_item = OrderItem.new(order: self, product: product, quantity: 1)
    end

    @order_item.save
  end
  
end
