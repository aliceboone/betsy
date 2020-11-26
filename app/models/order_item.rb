class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: {greater_than: 0}

  def single_item_total_cost
    sum = self.product.price.to_f * self.quantity
    return sum
  end

  def add_quantity
    inventory = self.product.inventory
    if inventory <= self.quantity
      self.quantity = inventory
      self.save
      return false
    end
    self.quantity += 1
    self.save
  end

  def reduce_quantity
    inventory = self.product.inventory
    if inventory < self.quantity
      self.quantity = inventory
      self.save
      return false
    end
    if self.quantity <= 1
      return self.destroy
    end
    self.quantity -= 1
    self.save
  end

  def mark_shipped!
    self.update!(shipped: true)
    self.order.maybe_complete!
  end
end