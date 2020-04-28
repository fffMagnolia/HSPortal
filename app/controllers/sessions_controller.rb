class SessionsController < ApplicationController

  # access
  def new
  end

  # login
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # sessions helper method "log_in"
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = "Email or Password Invalid."
      render 'new'
    end
  end

  # logout
  def destroy
  end
end
