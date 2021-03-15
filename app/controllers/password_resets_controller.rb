class PasswordResetsController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  before_action :not_dismissed_user, only: [:create]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:primary] = 'パスワードの再設定について数分以内にメールでご連絡致します'
      redirect_to root_url
    else
      flash.now[:danger] = 'このメールアドレスは登録されておりません <br> ご登録のメールアドレスを正しく入力してください'
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = 'パスワードが再設定されました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    redirect_to root_url unless @user && @user.is_valid? && @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = 'パスワード再設定の有効期限切れです <br> もう一度初めからやり直してください'
    redirect_to new_password_reset_url
  end

  def not_dismissed_user
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    return unless @user && !@user.is_valid

    flash[:danger] = '退会済みです'
    redirect_to signup_path
  end
end
