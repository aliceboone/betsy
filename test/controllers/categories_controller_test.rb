require "test_helper"

describe CategoriesController do

  before do
    Merchant.create!( id: 1,
                      username: 'Jane Do',
                      email: 'jdo@somewhere.com',
                      mailing_address: '1111 3rd Ave NE Seattle WA 98000',
                      credit_last_four: 1111,
                      credit_expire: '12/23')

  end

  describe "new" do
    it "responds with success" do
      get new_category_path
      must_respond_with :success
    end
  end

  describe 'Create' do
    it 'can create a new category' do

      expect{
        post categories_path, params: {category: {category_name:"Face"}}
      }.must_change 'Category.count', 1

      new_category = Category.last

      must_respond_with :redirect
      must_redirect_to category_path(new_category.id)
    end
  end
end
