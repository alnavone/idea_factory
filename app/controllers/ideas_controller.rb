class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :review_params, only: [:show, :edit, :update, :destroy]
  # before_action  @reviews = Review.find(params[:id]
  before_action :authenticate_user!, except: [:index, :show]

  # before_action :find_question, only: [:show, :edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      flash[:notice] = 'Idea created'
      redirect_to idea_path(@idea)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
    @review = Review.new
  end

  def index
    @ideas = Idea.all
  end

  def edit
    unless can? :edit, @idea
      flash[:notice] = 'You cannot edit something that is not yours'
      redirect_to @idea
    end
  end

  def update
    if !(can? :update, @idea)
      head :unauthorized
    elsif @idea.update(idea_params)
      # if you have a `redirect_to` and you'd like to specify a flash message
      # then you can just pass in the `flash` or `alert` as options to the
      # `redirect_to` instead of having a separate line. Please note that this
      # does not work with `render`
      redirect_to idea_path(@idea), notice: 'Idea updated'
    else
      render :edit
    end
  end

  def destroy
    if can? :destroy, @idea
      @idea.destroy
      redirect_to ideas_path, notice: 'Idea deleted'
    else
      head :unauthorized
    end
  end

  private

  def idea_params
    params.require(:idea).permit([:title, :body])
  end


  def find_idea
    @idea = Idea.find params[:id]
  end

  def review_params
    @reviews = Review.find params[:id]
  end
end
