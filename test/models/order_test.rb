require "test_helper"

describe Order do
  # has_many :order_items
  describe 'relations' do
    describe 'order_items' do
      it 'can have many order_items' do
        # create order
        # count # order_items in the order
        order = orders(:order_one)
        expect(order).must_respond_to :order_items
        order.order_items.each do |order_item|
          expect(order_item).must_respond_to Order
        end
      end
    end
  end

  describe 'custom methods' do
  # custom method add_product(product)
  # describe 'add_product' do
  # end
  end
end
