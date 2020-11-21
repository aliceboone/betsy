require "test_helper"

describe ReviewsController do

  let(:product){
    Product.create!(
        name: 'Aloe face cream',
        description: 'Aloe Vera multi symptom relief juice',
        inventory: 10,
        price: 20.00,
        category_ids: [],
        photo: 'www.allaboutaloe.com/aloe_juice.png',

    )
  }
  let(:review){
    Review.create!(
        content: 'It is a nice product, I will buy it again',
        rating: 5,
        product_id: product.id
    )
  }

  let(:review_hash){
    {
        review: {
            content: 'It is a nice product, I will buy it again',
            rating: 5,
            product_id: product.id
        }
    }
  }

    describe "new" do
      it "can successfully retrieve new review page for valid product id" do
        get new_review_path(product_id:product.id)
        assert_response :success
      end
    end

  describe "create" do

    describe 'Create' do
      it 'can create a new review' do

        expect{
          post reviews_path, params: review_hash
        }.must_change "Review.count", 1

        new_review = Review.find_by(rating: review_hash[:review][:rating])

        must_respond_with :redirect
        must_redirect_to product_review_path(new_review.id)
      end

      it 'cannot create a new review if the form data violates the validations for review' do
        # this can be checked after making the validations
        review_hash[:review][:rating] = nil

        expect{
          post reviews_path, params: review_hash
        }.wont_change 'Review.count'
      end
    end
  end
end

