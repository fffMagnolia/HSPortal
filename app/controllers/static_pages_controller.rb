class StaticPagesController < ApplicationController
  def home
    # ログインユーザのみ作成。infoに必要
    if logged_in?
      @entries = current_user.entries
    end
  end

  def help
  end

  def contact
  end

  def policy
  end
end
