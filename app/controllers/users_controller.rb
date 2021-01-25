class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '新規会員登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :name_kana, :email, :password, :password_confirmation, :postcode, :prefecture_code, :prefecture_name, :address_city,
      :address_street, :address_building
    )
  end
end
