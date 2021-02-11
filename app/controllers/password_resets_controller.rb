class PasswordResetsController < ApplicationController

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
end
