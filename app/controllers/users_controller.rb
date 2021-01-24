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
      # 保存の成功
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation, :postcode, :prefecture_name, :address_city,
      :address_street, :address_building
    )
  end
end
