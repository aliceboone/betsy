class MerchantsController < ApplicationController

  before_action :find_merchant, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :update, :edit, :destroy]


  def authentication_notice
    flash[:notice] = "Please log in to perform this action"
  end

  def log_out
    flash[:success] = "Successfully logged out"
  end

  def must_be_logged
    flash[:error] = "A problem occurred: You must log in to do that"
  end

  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    auth_hash = request.env["omniauth.auth"]
    merchant = Merchant.find_by(uid: auth_hash[:uid], provider: "github")
    if merchant
      flash[:success] = "Logged in as returning aloe enthusiast #{merchant.username}"
    else
      merchant = Merchant.build_from_github(auth_hash)
      if merchant.save
        flash[:success] = "Logged in as new aloe enthusiast #{merchant.username}"
      else
        flash[:error] = "Could NOT create new aloe enthusiast account: #{merchant.errors.messages}"
        return redirect_to root_path
      end
    end
    session[:merchant_id] = merchant.id
    redirect_to root_path
  end

  def show
    if @merchant.nil?
      redirect_to merchants_path
      return
    end
  end

  def edit
    if @merchant.nil?
      redirect_to merchants_path
      return
      end
  end

  def update
    if @merchant.update(merchant_params)
      redirect_to merchants_path
    else
      render :edit
    end
  end

  def destroy
    session[:merchant_id] = nil
    flash[:success] = "Successfully logged out!"

    redirect_to root_path
  end

  def logout
    if session[:merchant_id]
      merchant_params
      unless merchant.nil?
        session[:merchant_id] = nil
        log_out
      else
        session[:merchant_id] = nil
      end
    else
      authentication_notice
    end
    redirect_to root_path
  end

  def profile
    @merchant = @current_user
  end

  def dashboard
    @merchant = @current_user
    @orders = Order.merchant_orders(@merchant)
    @orders_paid = @orders.where(status: 'paid')
    @orders_complete = @orders.where(status: 'complete')
    @orders_cancelled = @orders.where(status: 'cancelled')
  end

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email, :mailing_address, :credit_last_four, :credit_expire, :uid, :provider)
  end

  def find_merchant
    @merchant = Merchant.find_by_id(params[:id])
  end
end
