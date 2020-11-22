class ApplicationController < ActionController::Base

  before_action :ensure_cart, :set_categories, :set_merchants
  before_action :current_user

  # Helper Methods
  def not_found_notice
    flash[:notice] = "This product does not exist."
    redirect_to products_path
  end

  def not_saved_notice
    flash.now[:notice] = "Could not create"
  end

  def saved_notice
    flash[:success] = "Successfully created"
  end

  def update_notice
    flash[:success] = "Successfully updated"
  end

  def destroyed_notice
    flash[:success] = "Successfully destroyed"
  end

  def not_sell
    flash[:error] = " You don't sell this product"
  end

  def set_categories
    @categories = Category.all
  end

  def set_merchants
    @merchants = Merchant.all
  end

  def ensure_cart
    @cart = Order.find_by(id: session[:cart_id])
    if @cart.nil?
      @cart = Order.new
      if @cart.save
        session[:cart_id] = @cart.id
      else
        @cart = nil
      end
    end
  end

  def require_cart
    if @cart.nil?
      flash[:error] = 'Failed to create cart'
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= Merchant.find_by(id: session[:merchant_id])
    # unless @current_merchant
    #   must_be_logged
    #   redirect_to root_path
    # end
  end
  helper_method :current_user

  def require_login
    if current_user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: root_path)
    end
  end
end
