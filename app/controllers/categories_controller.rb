class CategoriesController < ApplicationController

   # before_action :require_login, only: [:new]
   before_action :load_category, only: [:show, :edit]

  def saved_notice
    flash[:success] = "Successfully created the #{@category.category_name}"
  end

  def not_saved_notice
    flash.now[:notice] = "A problem occurred: Could not create category."
  end

  def not_found_notice
    flash[:notice] = "This product does not exist."
    redirect_to categories_path
  end

  #############################################################################################

  def new
    @category = Category.new
  end

  def show

  end

  def edit

  end

  def create
    @category = Category.create(category_params)
    if @category.save
      saved_notice
      redirect_to merchant_path(session)[:merchant_id]
      # redirect_to category_path(@category.id)
    else
      not_saved_notice
    end
  end


  private

  def category_params
    params.require(:category).permit(:category_name)
  end

   def load_category
     @category = Category.find_by(id: params[:id])
     if @category.nil?
       not_found_notice
       return
     end
   end
end
