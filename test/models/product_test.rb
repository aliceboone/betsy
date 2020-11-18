require "test_helper"

describe Product do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "validations" do
      it "product must have a name" do
        # Arrange
        product = Product.where(name: 'desk lamp')
        product.name = nil
        # Assert
        expect(product.valid?).must_equal false
        expect(product.errors.messages).must_include :name
        expect(product.errors.messages[:name]).must_equal ["can't be blank"]
      end
      it "product must have an price" do
        # Arrange
        product = Product.where(name: 'desk lamp')
        product.price = nil
        # Assert
        expect(product.valid?).must_equal false
        expect(product.errors.messages).must_include :price
        expect(product.errors.messages[:price]).must_equal ["can't be blank"]
      end
      it "product name must be unique" do
        # Arrange
        product = Merchant.new
        product.username = 'desk lamp'
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
        expect(product.errors.messages[:merchant]).must_equal ["can't be blank"]
      end
    end
end
