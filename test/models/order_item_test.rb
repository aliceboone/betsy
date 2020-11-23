require "test_helper"

describe OrderItem do
  describe 'relations' do
    #has && belongs to product_id & order_id
    it "can set the order, using a Order" do
      order = Order.create!(status: "Test Order Status", email: 'order_item@test.test')
      # (name: "Test Product", email: 'test@test.test')
      order_item = OrderItem.new(quantity: 8)

      order_item.order = order

      expect(order_item.order_id).must_equal order.id
    end
    it "can set the product, using a Product" do
      skip
      #is this the right candidate for a fixture?? If so how do I access one?
      product = Product.create!(name: "Test Product", price: 22, merchant: "Fake?")
      # (name: "Test Product", email: 'test@test.test')
      order_item = OrderItem.new(quantity: 10)

      order_item.product = product

      expect(order_item.product_id).must_equal product.id
    end

    it 'has an order'do
      skip
    end
    it 'has a product' do
      skip
    end
  end

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
