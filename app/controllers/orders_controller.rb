class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy, :fulfill]
  before_action :require_cart, only: [:cart]
  before_action :require_login, only: [:fulfill]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def cart
    @order = @cart
    @order_items = @order.order_items
  end

  def show
    if @order.nil?
      redirect_to orders_path
      return
    end
  end

  def edit
    if @order.nil?
      redirect_to orders_path
      return
    end
  end

  def update
    if @order.update(order_params) && @order.checkout
      clear_cart
      redirect_to order_path(@order)
    else
      flash[:error] = @order.errors.messages[:base]&.first
      render :edit
      return
    end
  end

  def destroy
    if @order.destroy
    redirect_to orders_path
    end
  end

  def checkout
    if checkout
    else
      flash[:error] = @cart.errors.messages[:base]&.first # if base isn't set then it will return nil ortherwise it will return the first value
    end
  end

  def fulfill
    @order_items = @order.order_items.joins(:product).where(products: {merchant_id: @current_user.id})
  end

  private

  def order_params
    params.require(:order).permit(:email, :address, :credit_name, :credit_expire, :security_code, :zip)
  end

  def find_order
    @order = Order.find_by_id(params[:id])
    if @order.nil?
      flash[:error] = "invalid order id"
      redirect_to root_path
    end
  end
end

