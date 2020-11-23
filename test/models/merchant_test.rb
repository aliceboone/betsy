require "test_helper"

describe Merchant do

  describe 'relations' do
    it 'can have many products' do
      # create a product with a merchant_id & corresponding merchant
      merchant = merchants(:merch_one)
      p merchant.products
      # product = Product.find_by(name: "used laptop")
      #  must_respond_to :products
      # expect(merchant.products).must_include name: "desk lamp"
      merchant.products.where(name: "desk lamp")
      # collections
      expect(merchant.products.count).must_equal 3
          # .must_respond_to product
      #       must_equal something
      #each product must be an instance of product
    end

    it 'can have no products' do
      skip
    end
  end

  describe "validations" do
    it "merchant must have a username" do
      # Arrange
      merchant = Merchant.find_by(username: 'Jello Porcini')
      merchant.username = nil
      # Assert
      expect(merchant.valid?).must_equal false
      expect(merchant.errors.messages).must_include :username
      expect(merchant.errors.messages[:username]).must_equal ["can't be blank"]
    end
    it "must have an email" do
      # Arrange
      merchant = Merchant.find_by(username: 'Dexter Excaliber')
      merchant.email = nil

      # Assert
      expect(merchant.valid?).must_equal false
      expect(merchant.errors.messages).must_include :email
      expect(merchant.errors.messages[:email]).must_equal ["can't be blank"]
    end
    it "merchant username must be unique" do
      # Arrange
      merchant = Merchant.new
      merchant.username = 'Jello Porcini'
      # Assert
      expect(merchant.valid?).must_equal false
      expect(merchant.errors.messages).must_include :username
      expect(merchant.errors.messages[:username]).must_equal ["has already been taken"]
    end
    it "merchant email must be unique" do
      # Arrange
      merchant = Merchant.new
      merchant.username = 'test-name'
      merchant.email = Merchant.first.email
      # Assert
      expect(merchant.valid?).must_equal false
      expect(merchant.errors.messages).must_include :email
      expect(merchant.errors.messages[:email]).must_equal ["has already been taken"]
    end
  end
end
