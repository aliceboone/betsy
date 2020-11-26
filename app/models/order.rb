class Order < ApplicationRecord

  has_many :order_items
  
  def add_product(product, quantity)
    order_item = self.order_items.where(product_id: product.id).first
    inventory = product.inventory
    if order_item
      quantity += order_item.quantity
    end

    if quantity >= inventory
      quantity = inventory
    end

    if order_item
      order_item.quantity = quantity
    else
      order_item = OrderItem.new(order: self, product: product, quantity: quantity)
    end

    order_item.save
  end

  #before updating, compare soon to be quantity with the existing inventory
  # at the least return false - add to errors message (self.errors = gives you message)
  #check the stock to inventory

  def self.make_cart
    Order.new(status: 'pending')
  end

  def checkout
    if self.status != 'pending'
      errors.add(:base, :invalid_order, message: 'The order is not valid')
      return false
    end
    # :base - in the errors collection key: error message (base = key)
    order_items.each do |order_item|
      if order_item.quantity > order_item.product.inventory
        errors.add(:base, :invalid_order, message: 'The quantity of a purchased order should not be more than product stock')
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

  def total_orders
    return order_items.sum do |order_item|
        order_item.product.price.to_f * order_item.quantity
      end
  end

  def self.merchant_orders(merchant)
    products = merchant.products
    order_items = OrderItem.where(product: products)
    orders = Order.where(order_items: order_items)

    return orders.where.not(status: 'pending')
  end

  def maybe_complete!
    return unless self.order_items.where(shipped: false).empty?

    self.update!(status: "complete")
  end
end
