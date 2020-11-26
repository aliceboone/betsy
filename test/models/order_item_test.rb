require "test_helper"

describe OrderItem do
  describe 'relations' do
    #has && belongs to product_id & order_id
    before do
      @order = Order.create!(status: "Test Order Status", email: 'order_item@test.test')
      @product = products(:product_two)
    end

    it "can set the order, using a Order" do
      @order
      order_item = OrderItem.new(quantity: 8)
      order_item.order = @order

      expect(order_item.order_id).must_equal @order.id

      @order.order_items.each do |order_item|
        expect(order_item).must_be_kind_of Order
      end
      expect(@order.order_items).wont_be_nil
    end

    it 'has a product' do
      @product
      order_item = OrderItem.new(quantity: 2)
      order_item.product = @product

      expect(order_item.product_id).must_equal @product.id
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

  describe 'single_item_total_cost' do
    it 'returns the correct cost of an order item with consideration of quantity' do
      product = products(:product_one)
      order_item = OrderItem.new(quantity: 8)
      order_item.product = product
      total_price = order_item.quantity * product.price

      expect(order_item).must_be_instance_of OrderItem
      expect(order_item.single_item_total_cost).must_equal total_price

    end
  end

  describe 'add_quantity' do
    before do
      @product = products(:product_one)
      @order_item = OrderItem.new(quantity: 9)
      @order_item.product = @product
    end

    it 'adds one additional product to the order' do
      @order_item.add_quantity
      expect(@order_item.quantity).must_equal 10
    end

    it 'will not add product if there is no enough inventory for that product' do
      @order_item.add_quantity
      expect(@order_item.quantity).must_equal 10
    end
  end

  describe 'reduce_quantity' do
    before do
      @product = products(:product_one)
      @order_item = OrderItem.new(quantity: 2)
      @order_item.product = @product
    end

    it 'reduce one product from the order' do
      @order_item.reduce_quantity
      expect(@order_item.quantity).must_equal 1
    end
  end
end
