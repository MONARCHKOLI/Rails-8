class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to products_path # assuming you have a products index route
    else
      redirect_to new_user_session_path # Devise login page
    end
  end
end
