class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  before_action :not_dismissed_user, only: [:create, :edit, :update]

  def new
  end

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

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
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

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = 'パスワード再設定の有効期限切れです <br> もう一度初めからやり直してください'
        redirect_to new_password_reset_url
      end
    end

    # 退会済みのユーザーはパスワード再発行できない
    def not_dismissed_user
      @user = User.find_by(email: params[:password_reset][:email].downcase)
      if @user
        if !@user.is_valid
          flash[:danger] = '退会済みです'
          redirect_to signup_path
        end
      end
    end
end
