require "test_helper"

describe Product do
  describe 'relations' do
    # has merchant_id
    describe 'merchants' do
      it "can set the merchant, using a Merchant" do
        merchant = Merchant.new(name: "Test Product", email: 'test@test.test')
        # (name: "Test Product", email: 'test@test.test')
        product = Product.new(name: "Test Username")

        product.merchant = merchant

        expect(product.merchant_id).must_equal merchant.id
      end
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
