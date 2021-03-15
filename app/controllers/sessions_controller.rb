class SessionsController < ApplicationController
  before_action :reject_inactive_user, only: [:create]
  before_action :admin_user_logged_in, only: [:create]

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました'
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードの入力に誤りがあるか登録されていません'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  private

  def reject_inactive_user
    @user = User.find_by(email: params[:session][:email].downcase)
    return unless @user && @user.authenticate(params[:session][:password]) && !@user.is_valid

    flash[:danger] = '退会済みです'
    redirect_to signup_path
  end

  def admin_user_logged_in
    user = User.find_by(email: params[:session][:email].downcase)
    return unless user && user.authenticate(params[:session][:password]) && AdminUser.exists?(email: user.email)

    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_to rails_admin_path
  end
end
