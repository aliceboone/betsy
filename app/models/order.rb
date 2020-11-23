class Order < ApplicationRecord

  has_many :order_items
  
  def add_product(product, quantity)
    @order_item = self.order_items.where(product_id: product.id).first

    if @order_item
      @order_item.quantity += quantity
    else
      @order_item = OrderItem.new(order: self, product: product, quantity: quantity)
    end

    @order_item.save
  end


  
end
