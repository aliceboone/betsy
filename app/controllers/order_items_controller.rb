class OrderItemsController < ApplicationController
  before_action :require_cart, only: [:create]

  def index
  end

  def show
  end

  def new
    @order_item = OrderItem.new(order_item_params)
    @order_item.quantity = 1
  end

  def create
    chosen_product = Product.find_by_id(params[:product_id])
    if chosen_product.nil?
      flash[:error] = "Invalid product"
      redirect_to root_path
      return
    end

    quantity = order_item_params[:quantity].to_i
    if @cart.add_product(chosen_product, quantity)
      redirect_to cart_path
    else
      flash[:error] = "Product failed to be added to the order"
      redirect_to root_path
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to cart_path
  end

  def update_quantity
    @order_item.update_attribute(:quantity)
  end

  def add_quantity
    @order_item = OrderItem.find(params[:id])
    unless @order_item.add_quantity
      flash[:error] = "#{@order_item.product.name} Quantity is more than the inventory"
    end
    redirect_to cart_path
  end

  def reduce_quantity
    @order_item = OrderItem.find(params[:id])
    unless @order_item.reduce_quantity
      flash[:error] = "#{@order_item.product.name} Quantity was modified according to the product inventory"
    end
    redirect_to cart_path
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id)
  end

end