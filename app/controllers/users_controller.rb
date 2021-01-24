class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end


  private

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :postcode,
        :prefecture_name,
        :address_city,
        :address_street,
        :address_building
      )
    end
end
