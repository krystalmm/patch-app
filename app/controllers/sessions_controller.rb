class SessionsController < ApplicationController
  def new
    # new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      flash[:success] = 'ログインしました'
      redirect_to user
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
end
