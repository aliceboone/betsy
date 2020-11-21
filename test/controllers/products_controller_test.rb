require "test_helper"

describe ProductsController do
  let (:category){
    Category.create!(
        id: 1,
        category_name: 'Drinks')
  }

  let (:merchant){
    Merchant.create!(
        id: 1,
        username: 'Jane Do',
        email: 'jdo@somewhere.com',
        mailing_address: '1111 3rd Ave NE Seattle WA 98000',
        credit_last_four: 1111,
        credit_expire: '12/23' )
  }

  let(:product){
    Product.create!(
        name: 'Aloe Juice',
        description: 'Aloe Vera multi symptom relief juice',
        inventory: 5,
        price: 7.00,
        category_ids: [],
        photo: 'www.allaboutaloe.com/aloe_juice.png',
        merchant_id: merchant.id
    )
  }

  let (:product_hash) {
    {
        product: {
            name: 'Aloe face cream',
            description: 'Aloe Vera multi symptom relief juice',
            inventory: 10,
            price: 20.00,
            category_ids: [],
            photo: 'www.allaboutaloe.com/aloe_face_cream.png',
            merchant_id: merchant.id
        }
    }
  }

  describe 'Index' do
    it 'should get index' do
      product

      get products_path
      must_respond_with :success
    end

    it "responds with success when there are no products saved" do

      # Act
      get products_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'Show' do

    it 'can get a valid product' do

      product

      get product_path(product.id)
      must_respond_with :success
    end

    it 'will redirect for an invalid product' do
      product.save

      get product_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'Create' do
    it 'can create a new product' do

      expect{
        post products_path, params: product_hash
      }.must_change "Product.count", 1

      new_product = Product.find_by(name: product_hash[:product][:name])
      expect(new_product.description).must_equal product_hash[:product][:description]
      expect(new_product.price).must_equal product_hash[:product][:price]

      must_respond_with :redirect
      must_redirect_to product_path(new_product.id)
    end

    it 'cannot create a new product if the form data violates the validations for product' do
      # this can be checked after making the validations
      product_hash[:product][:name] = nil

      expect{
        post products_path, params: product_hash
      }.wont_change 'Product.count'

    end
  end

  describe 'Edit' do
    it 'responds with success when getting the edit page for an existing, valid product' do

      product

      product_id = product.id
      get edit_product_path(product_id)
      must_respond_with :success
    end
  end

  describe 'Update' do

    it 'can updates an existing product with valid data accurately and redirect' do
      # Arrange
      new_product = product

      # Act
      expect {
        patch product_path(new_product.id), params: product_hash
      }.wont_change 'Product.count'

      # Assert
      new_product.reload

      expect(new_product.name).must_equal product_hash[:product][:name]
      expect(new_product.description).must_equal product_hash[:product][:description]
      expect(new_product.inventory).must_equal product_hash[:product][:inventory]
      expect(new_product.price).must_equal product_hash[:product][:price]
      expect(new_product.category_ids).must_equal product_hash[:product][:category.id]

      must_respond_with :redirect
      must_redirect_to product_path(new_product.id)
    end

    it 'does not update any product if given an invalid id and redirect to products path' do
      # Act
      #
      expect {
        patch product_path(-1), params: product_hash
      }.wont_change 'Product.count'

      # Assert
      must_respond_with :redirect
    end
  end
end

