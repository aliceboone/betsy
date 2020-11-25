
class ReviewsController < ApplicationController

  def not_able_to_review
    flash[:error] = "You can not review a product that you sell"
  end

  def new
    product_id = params[:product_id]
    product = Product.find_by(id: product_id)
    if product.nil?
      not_found_notice
      return
    end
    if @current_user && product.merchant_id == @current_user.id
      not_able_to_review
      redirect_to product_path(product)
      return
    end

    @review = Review.new(product: product)
  end

  def create
    @review = Review.new(review_params)
    product = Product.find_by(id: @review.product_id)
    if product.nil?
      not_found_notice
      return
    end
    if @current_user && product.merchant_id == @current_user.id
      not_able_to_review
      redirect_to product_path(product)
      return
    end

    if @review.save
      saved_notice
      redirect_to product_path(@review.product_id)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :product_id)
  end
end