require "test_helper"

describe Product do

  describe 'relations' do
    it 'can access correlating merchant' do
      merchant = merchants(:merch_two)
      product = products(:product_three)

      expect(product.merchant_id).must_equal merchant.id
    end
  end

  describe 'quantity & inventory' do
    it 'can determine 0 inventory' do
      # arrange
      product = products(:inventory_zero_test_product)
      #act & #assert
      expect(product.out_of_stock).must_equal true
    end

    it 'can decrease inventory' do
      # arrange
      product = products(:inventory_decrease_test_product)
      # act
      decrease = product.decrease_inventory(1)
      # assert
      expect(decrease).must_equal 2
    end

    it 'can produce an average rating' do
      # product = products(:product_three)
      # review_one = Review.new
      # review_one[:rating] = 4
      # review_one.product = product
      #
      # review_two = Review.new
      # review_two[:rating] = 1
      # review_two.product = product
      # arrange
      # review_1 = reviews(:test_review_1)
      # review_2 = reviews(:test_review_2)
      product = products(:review_test_product)
      average = product.average_rating
      expect(average).must_equal 3

    end
  end

  describe "validations" do
    it "product must have a name" do
      # Arrange
      product = Product.find_by(name: "desk lamp")
      product.name = nil
      # Assert
      expect(product.valid?).must_equal false
      expect(product.errors.messages).must_include :name
      expect(product.errors.messages[:name]).must_equal ["can't be blank"]
    end
    it "product must have an price" do
      # Arrange
      product = Product.first
      product.price = nil
      # Assert
      expect(product.valid?).must_equal false
      expect(product.errors.messages).must_include :price
      expect(product.errors.messages[:price]).include? "can't be blank"
    end
    it "product name must be unique" do
      # Arrange
      product = Product.find_by(name: 'logitech mouse')
      product.name = 'nalgene'
      # Assert
      expect(product.valid?).must_equal false
      expect(product.errors.messages).must_include :name
      expect(product.errors.messages[:name]).must_equal ["has already been taken"]
    end
    it "product price must be a number" do
      # Arrange
      product = Product.first
      product.price = 'five dollars'
      # Assert
      expect(product.valid?).must_equal false
      expect(product.errors.messages).must_include :price
      expect(product.errors.messages[:price]).must_equal ["is not a number"]
    end
    it "product price must be more than 0" do
      #Arrange
      product = Product.first
      product.price = -5
      #Assert
      expect(product.valid?).must_equal false
      expect(product.errors.messages).must_include :price
      expect(product.errors.messages[:price]).must_equal ["must be greater than 0"]
    end
    it "must belong to a merchant" do
      #Arrange
      product = Product.first
      product.merchant = nil
      #Assert
      expect(product.valid?).must_equal false
      expect(product.errors.messages).must_include :merchant
      expect(product.errors.messages[:merchant]).must_equal ["must exist", "can't be blank"]
    end
  end
end
