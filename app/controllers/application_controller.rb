class ApplicationController < ActionController::Base
  include SessionsHelper

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
    current_cart = Cart.find_by(id: session[:cart_id])
    current_cart = Cart.create unless current_cart
    session[:cart_id] = current_cart.id
    current_cart
  end
end
