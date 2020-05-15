class SessionsController < ApplicationController

  # access
  def new
  end

  # login
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # sessions helper method "log_in"
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or root_url
      else
        flash[:warning] = "アカウントが有効化されていません。送信されたメールアドレスのリンクをクリックしてアカウントを有効化してください。"
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Email or Password Invalid."
      render 'new'
    end
  end

  # logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
