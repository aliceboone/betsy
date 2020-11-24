class Order < ApplicationRecord

  has_many :order_items
  
  def add_product(product, quantity)
    order_item = self.order_items.where(product_id: product.id).first

    if order_item
      order_item.quantity += quantity
    else
      order_item = OrderItem.new(order: self, product: product, quantity: quantity)
    end

    order_item.save
  end



  def self.make_cart
    Order.new(status: 'pending')
  end

  def checkout
    if self.status != 'pending'
      errors.add(:base, :invalid_order , message:'The order is not valid' )
      return false
    end

    order_items.each do |order_item|
      if order_item.quantity > order_item.product.inventory
        errors.add(:base, :invalid_order, message:'The quantity of a purchased order should not be more than product stock')
        return false
      end
    end

    order_items.each do |order_item|
      order_item.product.decrease_inventory(order_item.quantity)
      order_item.product.save # might fail when two persons are checking out in the same time
    end
    self.status = 'paid'
    self.save
  end

  def self.total_orders
      sum = 0
      self.order_item.each do |order_item|
        sum += (order_items.product.price * order_item.quantity)
      end
      return sum
  end

end
