require "test_helper"

describe OrderItemsController do

  describe "Create" do
    it "redirect when there is inavlid product ID" do
      post product_order_items_path(-1)
      expect(flash[:error]).must_equal "Invalid product"
      must_respond_with :redirect
      must_redirect_to root_path

    end

    it "can add product to the shopping cart and redirect" do
      post product_order_items_path(products(:product_one))
      must_respond_with :redirect
      must_redirect_to cart_path
    end

  end

  describe "Destroy" do # to do later after finish

    it "delete a product from the shopping cart and redirect" do
      skip
      post product_order_items_path(products(:product_one))
      id = Product.find_by_id(products(:product_one).id)
      expect {
        delete product_order_item_path(id)}.must_change 'OrderItem.count', -1
    end
  end

  describe "Add Quantity" do
    it "add quantity of a product in a shopping cart" do
      skip
    end
  end

  describe "reduce Quantity" do
    it "reduce quantity of a product in a shopping cart" do
      skip
    end
  end

end
