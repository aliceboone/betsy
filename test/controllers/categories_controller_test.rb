require "test_helper"

describe CategoriesController do

  let(:category){
    Category.create!(
        category_name: 'Drinks'
    )
  }

  let(:category_hash){
    {
        product: {
            category_name: 'Drinks',
        }
    }
  }

  describe "new" do
    it "succeeds" do
      get new_category_path

      must_respond_with :success
    end
  end

  describe 'Create' do
    it 'can create a new category' do

      expect{
        post categories_path, params: category_hash
      }.must_change "Category.count", 1

      new_category = Category.find_by(category_name: category_hash[:category][:category_name])

      must_respond_with :redirect
      must_redirect_to product_path(new_category.id)
    end
  end

end
