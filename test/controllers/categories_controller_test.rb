require "test_helper"

describe CategoriesController do

  let(:category){
    Category.create!(
        category_name: 'Drinks'
    )
  }

  let(:category_hash){
    {
        category: {
            category_name: 'Drinks',
        }
    }
  }

  describe "new" do
    before do
      perform_login
    end

    it "can get the new category page" do

      # Act
      get new_category_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'Create' do
    before do
      perform_login
    end

    it 'can create a new category' do

      expect{
        post categories_path, params: category_hash
      }.must_change "Category.count", 1

      new_category = Category.find_by(category_name: category_hash[:category][:category_name])

      must_respond_with :redirect
      must_redirect_to category_path(new_category.id)
    end
  end
end