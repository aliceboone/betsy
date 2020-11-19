class ApplicationController < ActionController::Base

  def set_categories
    @categories = Category.all
  end

end
