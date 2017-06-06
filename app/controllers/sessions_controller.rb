class SessionsController < ApplicationController

  def new
  end

  def create

    user = User.find_by(email: params[:email])

    user.password  = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.save

    session[:user_id] = user.id
    if user&.authenticate(params[:password])
      redirect_to home_path, notice: 'Thanks for signing in!'
    else
      # flash.now makes the flasth message available to the current request as opposed to next request with just 'flash'
      flash.now[:alert] = "Wrong credentials, thief!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: 'Signed Out!'
  end



end
