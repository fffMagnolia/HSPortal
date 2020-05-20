class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = 'この操作を行うにはログインが必要です。'
        redirect_to login_url
      end
    end
end
