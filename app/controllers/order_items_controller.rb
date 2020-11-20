class OrderItemsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @order_item = OrderItem.new(order_item_params)
    @order_item.quantity = 1
  end

  def create
    chosen_product = Product.find(params[:product_id])
    current_order = @order

    if current_order.products.include?(chosen_product)
      @order_item = current_order.order_items.find_by(:product_id => chosen_product)
      @order_item.quantity += 1
    else
      @order_item = OrderItem.new
      @order_item.order = current_order
      @order_item.product = chosen_product
    end

    @order_item.save
    redirect_to order_path(current_order)
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to order_path(@order)
  end

  def add_quantity
    @order_item = OrderItem.find(params[:id])
    @order_item.quantity += 1
    @order_item.save
    redirect_to order_path(@order)
  end

  def reduce_quantity
    @order_item = OrderItem.find(params[:id])
    if @order_item.quantity > 1
      @order_item.quantity -= 1
    end
    @order_item.save
    redirect_to order_path(@order)
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity,:product_id, :order_id)
  end
  
end
