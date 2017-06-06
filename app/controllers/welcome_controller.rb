class WelcomeController < ApplicationController

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def show

  end

  def submit

  end

  private

  def find_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:ideas).permit(:title, :body)
  end
end
