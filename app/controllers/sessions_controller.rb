class SessionsController < ApplicationController

  # access
  def new
  end

  # login
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # when success 
    else
      flash.now[:danger] = "Email or Password Invalid."
      render 'new'
    end
  end

  # logout
  def destroy
  end
end
