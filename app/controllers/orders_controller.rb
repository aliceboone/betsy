class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_path
    else
      render :new
    end
  end

  def show
    if @order.nil?
      redirect_to orders_path
      return
    end
  end

  def edit;
    if @order.nil?
      redirect_to orders_path
      return
    end
  end

  def update
    if @order.update(order_params)
      redirect_to orders_path
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
    redirect_to orders_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :email, :address, :credit_name, :credit_expire, :security_code, :zip)
  end


  def find_order
    @order = Order.find_by_id(params[:id])
  end
  
end
