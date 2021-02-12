class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

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
      flash.now[:danger] = 'このメールアドレスは登録されておりません'
      render 'new'
    end
  end

  def edit
  end


  private

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
end
