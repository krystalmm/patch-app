class StaticPagesController < ApplicationController

  before_action :logged_in_user, only: [:unsubscribe, :withdraw]
  before_action :correct_user, only: [:unsubscribe, :withdraw]

  def home
    # home
  end

  def support
    # support
  end

  def contact
    # contact
  end

  def about
    # about
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    flash[:primary] = 'またのご利用を心よりお待ちしております'
    redirect_to root_path
  end



  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインしてください'
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(user_path(current_user)) unless current_user?(@user)
    end
end
