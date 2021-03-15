class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:unsubscribe, :withdraw]
  before_action :correct_user, only: [:unsubscribe, :withdraw]

  def home
    @products = Product.order(:id).limit(4)
  end

  def support; end

  def contact; end

  def about; end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    flash[:primary] = 'ありがとうございました <br> またのご利用を心よりお待ちしております'
    redirect_to root_path
  end
end
