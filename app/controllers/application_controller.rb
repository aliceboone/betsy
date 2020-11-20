class ApplicationController < ActionController::Base
  before_action :ensure_cart

  def set_categories
    @categories = Category.all
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

end
