class UsersController < ApplicationController

  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規会員登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_update_params)
      flash[:success] = '会員情報が変更されました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :name, :name_kana, :email, :password, :password_confirmation, :postcode, :prefecture_code, :prefecture_name,
        :address_city, :address_street, :address_building
      )
    end

    def user_update_params
      params.require(:user).permit(
        :name, :name_kana, :email, :postcode, :prefecture_code, :prefecture_name,
        :address_city, :address_street, :address_building
      )
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = 'ログインしてください'
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(user_path(current_user)) unless @user == current_user
    end
end
