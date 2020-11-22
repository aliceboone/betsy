require "test_helper"

describe OrdersController do
  let(:order) {
    Order.create email: 'someone@something.com',
                 address: 'some address',
                 credit_name: 'Someone',
                 credit_expire: '11/22',
                 security_code: 'secret code',
                 zip: 111111
  }

  describe 'Index' do
    it 'should get index' do
      get orders_path
      must_respond_with :success
    end
  end

  describe 'Show' do
    it 'can get a valid order' do
      get order_path(order.id)
      must_respond_with :success
    end

    it 'will redirect for an invalid order' do
      skip
      get order_path(-1)
      must_respond_with :redirect
    end

    describe 'Edit' do
      it 'can edit an existing order' do
        get edit_order_path(order.id)
        must_respond_with :success
      end
    end
    
    describe 'Update' do
      before do
        Order.create(email: 'someone@something.com',
                     address: 'some address',
                     credit_name: 'Someone',
                     credit_expire: '11/22',
                     security_code: 'secret code',
                     zip: 111111)
      end

      let (:edit_order_hash) do
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
      end
      
      it 'can update an existing order' do
        skip
        id = Order.first.id
        expect{
          patch order_path(order.id), params: edit_order_hash
        }.wont_change 'Order.count'

        must_respond_with :redirect

        order = Order.find_by(id: id)
        expect(order.email).must_equal edit_order_hash[:order][:email]
        expect(order.email).must_equal edit_order_hash[:order][:address]
        expect(order.email).must_equal edit_order_hash[:order][:credit_name]
        expect(order.email).must_equal edit_order_hash[:order][:credit_expire]
        expect(order.email).must_equal edit_order_hash[:order][:security_code]
        expect(order.email).must_equal edit_order_hash[:order][:zip]
      end

      it 'will redirect for an invalid order' do
        skip
        patch order_path(-1), params: edit_order_hash
      end
    end
  end

  describe 'Destroy' do
    before do
      Order.create(email: 'someone@something.com',
                   address: 'some address',
                   credit_name: 'Someone',
                   credit_expire: '11/22',
                   security_code: 'secret code',
                   zip: 111111)
    end

    it 'can destroy an order' do
      skip
      id = Order.first.id
      expect{
        delete order_path(id)
      }.must_change 'Order.count', -1

      must_respond_with :redirect
      must_redirect_to orders_path
    end
  end


end
