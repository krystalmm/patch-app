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
end
