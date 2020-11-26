require "test_helper"

describe Merchant do

  describe 'relations' do
    it 'can have many products' do

      merchant = merchants(:merch_one)
      expect(merchant).must_respond_to :products
      merchant.products.each do |product|
        expect(product).must_be_kind_of Product
      end
      expect(merchant.products.count).must_equal 3
    end

    it 'can have no products' do
      merchant = merchants(:merch_five)
      expect(merchant).must_respond_to :products
      merchant.products.each do |product|
        expect(product).must_be_kind_of Product
      end
      expect(merchant.products.count).must_equal 0
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

  describe 'custom models' do
    it 'determines total revenue' do

    end
  end
end
