class SessionsController < ApplicationController
  def new
    # new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードの入力に誤りがあるか登録されていません'
      render 'new'
    end
  end

  def destroy
    # destroy
  end
end
