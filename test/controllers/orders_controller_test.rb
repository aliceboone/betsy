require "test_helper"

  describe OrdersController do
    let(:merchant){
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
    let(:order) {
      Order.create!(
          email: 'someone@something.com',
          address: 'some address',
          credit_name: 'Someone',
          credit_expire: '11/22',
          security_code: 'secret code',
          zip: 111111
      )
    }

    let(:order_hash) {
    {
        order: {
            email: 'happy@strong.com',
            address: 'many places',
            credit_name: 'happy',
            credit_expire: '11/22',
            security_code: 'enjoy the moment',
            zip: 111111
        }
    }
  }

    let(:order_item){
      OrderItem.create!(
          quantity: 3,
          product_id: product.id,
          order_id: order.id
      )
    }

  describe 'Index' do
    it 'should get index' do
      order

      get orders_path
      must_respond_with :success
    end
  end

  describe 'Show' do
    it 'can get a valid order' do
      # skip
      order

      get order_path(order.id)
      must_respond_with :success
    end

    it 'will redirect for an invalid order' do

      get order_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'Edit' do
    it 'can edit an existing order' do

      order

      order_id = order.id

      get edit_order_path(order_id)
      must_respond_with :success
    end
  end

  describe 'Update' do
    before do
      perform_login
    end

    it 'can update an existing order' do
      new_order = order

      expect{
        patch order_path(new_order.id), params: order_hash
      }.wont_change 'Order.count'

      new_order.reload

      expect(new_order.email).must_equal order_hash[:order][:email]
      expect(new_order.address).must_equal order_hash[:order][:address]
      expect(new_order.credit_name).must_equal order_hash[:order][:credit_name]
      expect(new_order.credit_expire).must_equal order_hash[:order][:credit_expire]
      expect(new_order.security_code).must_equal order_hash[:order][:security_code]
      expect(new_order.zip).must_equal order_hash[:order][:zip]

      must_respond_with :success
    end

    it 'will redirect for an invalid order' do
      skip
      expect{
        patch order_path(-1), params: order_hash
      }.wont_change 'Order.count'

      must_respond_with :success
    end
  end
end
