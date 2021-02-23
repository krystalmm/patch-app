class ApplicationController < ActionController::Base
  include SessionsHelper

  helper_method :current_cart

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to login_url
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless current_user?(@user)
  end

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
