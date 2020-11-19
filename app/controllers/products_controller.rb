class ProductsController < ApplicationController

  before_action :find_product, only: [:destroy, :update, :edit, :show ]
  # before_action :require_login, only: [:new, :create, :update, :edit, :destroy]

  # Helper Methods
  def not_found_notice
    flash[:notice] = "This product does not exist."
    redirect_to products_path
  end

  def not_saved_notice
    flash.now[:notice] = "Could not create #{@product.category}"
  end

  def saved_notice
    flash[:success] = "Successfully created #{@product.category} with ID #{@product.id}"
  end

  def update_notice
    flash[:success] = "Successfully updated #{@product.category}"
  end

  def destroyed_notice
    flash[:success] = "Successfully destroyed #{@product.category}"
  end

  def not_sell
    flash[:error] = " You don't sell this product"
  end

  def not_in_stock
  flash[:success] = " #{@product.name} out of stock! "
  end

  #############################################################################################

  def index
    if params[:category_name]
      @products = Category.find_by(category_name: params[:category_name]).products
      @all_categories = params[:category_name]
    elsif params[:username]
      @products = Merchant.find_by(username: params[:username]).products
      @all_categories = 'Products by #params[:username]'
    else
      @products = Product.all
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
    # # if @product.merchant != @current_user
    #   not_sell
    #   redirect_to root_path
    #   return
    # end
  end

  def destroy
    if @product.destroy
      destroyed_notice
      redirect_to products_path
      return
    end
  end

  def out_of_stock
    if @product.Merchant != current_user
      not_sell
      redirect_to root_path
    else
      @product.out_of_stock!
      not_in_stock
      redirect_to root_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :inventory, :price, :photo, :merchant_id, :category)
  end

  def find_product
    @product = Product.find_by_id(params[:id])
    if @product.nil?
      not_found_notice
      return
    end
  end
end