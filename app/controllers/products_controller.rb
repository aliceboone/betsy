class ProductsController < ApplicationController

  before_action :find_product, only: [:destroy, :update, :edit, :show ]
  before_action :require_login, only: [:new, :create, :update, :edit, :destroy]

  def not_in_stock
    flash[:success] = " #{@product.name} out of stock! "
  end

  def not_saved_notice
    flash.now[:notice] = "Could not create product!"
  end

  def discontinued_notice
    flash[:success] = " #{@product.name} is discontinued! "
  end


  def index
    if params[:category_name]
      @products = Category.find_by(category_name: params[:category_name]).products.available
      @all_categories = params[:category_name]
    elsif params[:username]
      @products = Merchant.find_by(username: params[:username]).products.available
      @all_categories = 'Products by #params[:username]'
    else
      @products = Product.available
      @all_categories = 'all products'
    end
  end

  def show

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      saved_notice
      redirect_to product_path(@product.id)
      return
    else
      not_saved_notice
      render :new
      return
    end
  end

  def update
    if @product.update(product_params)
      update_notice
      redirect_to product_path
      return
    else
      not_saved_notice
      render :edit
      return
    end
  end

  def edit

  end

  def destroy
    if @product.update_attributes(discontinued: true)
      discontinued_notice
      redirect_to products_path
      return
    end
  end

  def out_of_stock
    @product.out_of_stock!
    not_in_stock
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :inventory, :price, :photo, :merchant_id, category_ids: [])
  end

  def find_product
    @product = Product.find_by_id(params[:id])
    if @product.nil?
      not_found_notice
      return
    end
  end
end