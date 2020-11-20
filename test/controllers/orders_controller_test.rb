require "test_helper"

describe OrdersController do

  describe 'Index' do
    it 'should get index' do
      get orders_path
      must_respond_with :success
    end
  end

  
end
