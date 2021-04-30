class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :favorites]
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
    if @user.update(user_params)
      flash[:success] = '会員情報が変更されました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def favorites; end

  private

  def user_params
    params.require(:user).permit(
      :name, :name_kana, :email, :password, :password_confirmation, :postcode, :prefecture_code, :prefecture_name,
      :address_city, :address_street, :address_building
    )
  end
end
