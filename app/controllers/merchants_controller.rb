class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update, :destroy]

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
        flash[:success] = "Could not create new aloe enthusiast account: #{merchant.errors.messages}"
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

  def edit;
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

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email, :mailing_address, :credit_last_four, :credit_expire, :uid, :provider)
  end

  private

  def find_merchant
    @merchant = Merchant.find_by_id(params[:id])
  end

  # def current
  #   @current_user = Merchant.find_by(id: session[:merchant_id])
  #   unless @current_user
  #     flash[:error] = "You must be logged in to see this page"
  #     redirect_to root_path
  #     return
  #   end
  # end



end
