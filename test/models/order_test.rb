require "test_helper"

describe Order do
  # has_many :order_items
  describe 'relations' do
    describe 'order_items' do
      it 'can have many order_items' do
        # create order
        # count # order_items in the order
        order = orders(:add_product_test_with_one_item)
        expect(order.order_items.count).must_equal 1
        expect(order).must_respond_to :order_items
        order.order_items.each do |order_item|
          expect(order_item).must_respond_to :order
        end
      end
    end
  end

  describe 'Custom Methods' do
    describe 'add product' do
      it 'will increase cart quantity without existing order_items' do
        #arrange
        order = orders(:add_product_test_empty_order)
        product = products(:add_product_test_product)
        #act
        order.add_product(product, 2)
        #assert
        expect(order.order_items.count).must_equal 1

        item = order.order_items[0]
        expect(item.quantity).must_equal 2
        expect(item.product).must_equal product
      end

      it 'will increase cart quantity with existing order_items' do
        #arrange
        order = orders(:add_product_test_with_one_item)
        product = products(:add_product_test_product)
        #act
        order.add_product(product, 2)
        #assert
        expect(order.order_items.count).must_equal 1

        item = order.order_items[0]
        expect(item.quantity).must_equal 3
        expect(item.product).must_equal product
      end

    end
  end
end
