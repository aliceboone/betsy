class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update]

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

  def show; end

  def edit; end

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
  end

  private

  def merchant_params
    params.require(:merchant).permit(:title, :description, :isbn, :author_id)
  end

  def find_merchant
    @merchant = Merchant.find_by_id(params[:id])
  end

end
