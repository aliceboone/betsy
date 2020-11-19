require "test_helper"

describe ProductsController do

  let (:product) {
    Product.create name: 'Aloe Juice',
                   description: 'Aloe Vera multi symptom relief juice',
                   inventory: 5,
                   price: 7.00,
                   category:'Drinks'
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

  let (:product_hash) {
    {
    Product:{
        name: 'Aloe Juice',
        description: 'Aloe Vera multi symptom relief juice',
        inventory: 5,
        price: 7.00,
        category:'Drinks'
      }
    }
  }

  let (:invalid_product_hash) {
    {
        Product:{
            name: nil,
            description: 'Aloe Vera multi symptom relief juice',
            inventory: 5,
            price: nil,
            category:'Drinks'
        }
    }
  }

  describe 'Index' do
    it 'should get index' do
      get '/products'
      must_respond_with :success
    end
  end


  describe 'show' do
    it 'responds with success when showing an existing valid product' do
      # Arrange
      product

      # Act
      get product_path(product.id)

      # Assert
      must_respond_with :success
    end

    it 'will redirect when passed an invalid product id' do

      # Act
      get product_path(-1)
      # Assert
      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'responds with success' do
      get new_product_path
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new product with valid information accurately, and redirect' do
      # Act-Assert
      expect {
        post products_path_, params: product_hash
      }.must_change 'Product.count', 1

      # Assert
      new_product = Product.find_by(name: product_hash[:product][:name])
      expect(new_product.description).must_equal product_hash[:product][:description]
      expect(new_product.inventory).must_equal product_hash[:product][:inventory]
      expect(new_product.price).must_equal product_hash[:product][:price]
      expect(new_product.category).must_equal product_hash[:product][:category]

      must_respond_with :redirect
      must_redirect_to product_path(new_product.id)
    end

    it 'does not create a product if the form data violates product validations' do
      # Arrange
      product

      # Act-Assert
      expect {
        post products_path, params: invalid_product_hash
      }.wont_change 'Product.count'
    end
  end

  describe 'edit' do
    it 'responds with success when getting the edit page for an existing, valid product' do
      # #Act
      get edit_product_path(product.id)

      # Assert
      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant product' do
      # Act
      get edit_product_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe 'update' do
    it 'can update an existing product with valid information accurately, and redirect' do
      # Arrange
      product = Product.first

      # Act
      expect {
        patch product_path(product.id), params: product_hash
      }.wont_change 'Product.count'

      # Assert
      product.reload

      expect(product.name).must_equal product[:product][:name]
      expect(product.description).must_equal product[:product][:description]
      expect(product.price).must_equal product[:product][:price]
      expect(new_product.price).must_equal product_hash[:product][:price]
      expect(new_product.category).must_equal product_hash[:product][:category]

      must_respond_with :redirect
      must_redirect_to product_path(product.id)
    end

    it 'does not update any product if given an invalid id and redirects' do
      # Act
      expect {
        patch product_path(-1), params: product_hash
      }.wont_change 'product.count'

      # Assert
      must_respond_with :redirect
    end

    it "does not patch a product if the form data violates product validations" do
      # Arrange
      original_name = product.name
      original_vin = product.vin
      original_available = product.available

      # Act-Assert
      expect {
        patch product_path(product.id), params: invalid_product_hash
      }.wont_change "Product.count"

      product.reload

      expect(product.name).must_equal original_name
      expect(product.vin).must_equal original_vin
      expect(product.available).must_equal original_available
    end
  end

  describe 'destroy' do
    it 'destroys the product instance in db when product exists, then redirects' do
      # Arrange
      product

      # Act-Assert
      expect {
        delete product_path(product.id)
      }.must_change 'Product.count', -1

      # Assert
      must_respond_with :redirect
    end

    it 'does not change the db when the product does not exist, then redirects' do
      # Act-Assert
      expect {
        delete product_path(-1)
      }.wont_change 'Product.count'

      # Assert
      must_respond_with :redirect
    end
  end
end
