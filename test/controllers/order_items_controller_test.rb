require "test_helper"

describe OrderItemsController do

  let(:order) {
    Order.create!(
        email: 'someone@something.com',
        address: 'some address',
        credit_name: 'Someone',
        credit_expire: '11/22',
        security_code: 'secret code',
        zip: 111111,
        credit_card_name: "1234"
    )
  }

  let(:order_item){
    OrderItem.create!(
        quantity: 3,
        product_id: product.id,
        order_id: order.id,
        shipped: false
    )
  }
  let (:order_item_hash) {
    {
        order_item: {
            quantity: 3
        }
    }
  }

  describe "Create" do

    it "redirect when there is inavlid product ID" do
      post product_order_items_path(-1)
      expect(flash[:error]).must_equal "Invalid product"
      must_respond_with :redirect
      must_redirect_to root_path

    end

    it "can add product to the shopping cart and redirect" do
      # skip
      post product_order_items_path(products(:product_one)), params: order_item_hash
      must_respond_with :redirect
      must_redirect_to cart_path
    end

  end

  describe "Destroy" do # to do later after finish

    it "delete a product from the shopping cart and redirect" do
      # skip
      post product_order_items_path(products(:product_one)), params: order_item_hash
      @cart = Order.find_by(id: session[:cart_id])
      expect {
        delete order_item_path(@cart.order_items.first)}.must_change 'OrderItem.count', -1
    end
  end

  describe "Add Quantity" do
    it "add quantity of a product in a shopping cart" do
    end
  end

  describe "reduce Quantity" do
    it "reduce quantity of a product in a shopping cart" do
    end
  end

end
