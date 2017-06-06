class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]



  def create
    @review = Review.new(review_params)
    @user = User.new(user_params)
    @review.idea = @idea
    @review.user = current_user
    if cannot? :create, @review
      flash[:alert] = "Access Denied. You cannot review your own product"

    elsif @review.save
      flash[:notice] = "Review Created"
      redirect_to idea_path(@idea), notice: 'Thank you for submitting a review!'
    else
      flash[:alert] = "Problem creating review"
      render 'ideas/show'
    end
  end



  def destroy
    @review = Review.find params[:id]
    @idea = @review.idea

    if can? :destroy, @review
    @review.destroy
    redirect_to idea_path(@idea), alert: 'Review removed'
  else
    flash[:alert] = "Access Denied. You cannot delete that review"
    redirect_to @review.idea
  end
    # render json: params
  end

  def hide
    @review = Review.find params[:id]
    @idea = @review.idea
    # @review.hidden = true
    @review.save

    redirect_to idea_path(@idea), alert: 'Review hidden'


  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end



end
