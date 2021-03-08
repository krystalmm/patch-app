class CommentsController < ApplicationController
  before_action :set_product

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.product_id = @product.id
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js { render :errors }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find_by(product_id: @product.id)
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
