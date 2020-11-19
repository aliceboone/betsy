class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to merchants_path
    else
      render :new
    end
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
    if @merchant.nil?
      redirect_to merchants_path
      return
    end

    @merchant.destroy
    redirect_to merchants_path
  end

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email, :mailing_address, :credit_last_four, :credit_expire)
  end

  def find_merchant
    @merchant = Merchant.find_by_id(params[:id])
  end

end
