require "test_helper"

describe Merchant do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #
  describe "validations" do
    it "merchant must have a username" do
      # Arrange
      merchant = Merchant.where(username: 'Jello Porcini')
      merchant.username = nil
      # Assert
      expect(merchant.valid?).must_equal false
      expect(merchant.errors.messages).must_include :username
      expect(merchant.errors.messages[:username]).must_equal ["can't be blank"]
    end
    it "must have an email" do
      # Arrange
      merchant = Merchant.where(username: 'Dexter Excaliber')
      merchant.description = nil

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
