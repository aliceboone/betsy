require "test_helper"

describe OrderItem do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #
  # validates :quantity, presence: true, numericality: {greater_than: 0}
  describe "validations" do
    it "order item must have a quantity" do
      # Arrange
      order_item = OrderItem.first
      order_item.quantity = nil
      # Assert
      expect(order_item.valid?).must_equal false
      expect(order_item.errors.messages).must_include :quantity
      expect(order_item.errors.messages[:quantity]).must_equal ["can't be blank", "is not a number"]
    end
    it "order item quantity must be an integer" do
      #Arrange
      order_item = OrderItem.first
      order_item.quantity = 'five'
      #Assert
      expect(order_item.valid?).must_equal false
      expect(order_item.errors.messages).must_include :quantity
      expect(order_item.errors.messages[:quantity]).must_equal ["is not a number"]
    end
    it "order item quantity must be greater than 0" do
      #Arrange
      order_item = OrderItem.first
      order_item.quantity = -5
      #Assert
      expect(order_item.valid?).must_equal false
      expect(order_item.errors.messages).must_include :quantity
      expect(order_item.errors.messages[:quantity]).must_equal ["must be greater than 0"]
    end
  end

end
