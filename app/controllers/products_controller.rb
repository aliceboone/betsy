class ProductsController < ApplicationController

  before_action :find_product, only: [:destroy, :update, :edit, :show ]
  # before_action :require_login, only: [:new, :create, :update, :edit, :destroy]

  # Helper Methods
  def not_found_notice
    flash[:notice] = "This product does not exist."
  end

  def not_saved_notice
    flash.now[:notice] = "A problem occurred: Could not create #{@product.category}"
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

  #############################################################################################

  def index
    @category1 = Product.category1
    @category2 = Product.category2
    @category3 = Product.category2
    @category4 = Product.category4
  end

  def show
    if @product.nil?
      not_found_notice
      return
    end
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
    if @product.nil?
      not_found_notice
      return
    elsif
    @product.update(prduct_params)
      update_notice
      redirect_to product_path
      return
    else
      not_saved_notice
      render :edit
      return
    end
  end

  def destroy
    if @product.nil?
      not_found_notice
      return
    else
      @product.destroy
      destroyed_notice
      redirect_to products_path
      return
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :inventory, :price, :category, :photo, :rating)
  end

  def find_product
    @product = Product.find_by_id(params[:id])
  end
end
