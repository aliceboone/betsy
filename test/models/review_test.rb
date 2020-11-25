require "test_helper"

describe Review do
<<<<<<< HEAD
=======

>>>>>>> master
  describe "validations" do
    it "review rating must be a number" do
      # Arrange
      review = Review.first
      review.rating = 'five dollars'
      # Assert
      expect(review.valid?).must_equal false
      expect(review.errors.messages).must_include :rating
      expect(review.errors.messages[:rating]).must_equal ["is not a number"]
    end
    it "review rating must be equal or greater that 1" do
      #Arrange
      review_one = Review.last
      review_one.rating = 0
      #Assert
      expect(review_one.valid?).must_equal false
      expect(review_one.errors.messages).must_include :rating
      expect(review_one.errors.messages[:rating]).must_equal ["must be greater than or equal to 1"]
    end
    it "review rating must be equal or less than 5" do
      review_two = Review.first
      review_two.rating = 6

      expect(review_two.valid?).must_equal false
      expect(review_two.errors.messages).must_include :rating
      expect(review_two.errors.messages[:rating]).must_equal ["must be less than or equal to 5"]
    end
  end
end

