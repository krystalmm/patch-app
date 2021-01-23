class UsersController < ApplicationController
  def new
    #new
  end

  def show
    @user = User.find(params[:id])
  end
end
