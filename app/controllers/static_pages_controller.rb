class StaticPagesController < ApplicationController
  def home
    # ログインユーザのみ作成。infoに必要
    if logged_in?
      @entries = current_user.entries
    end
    # 作成者表示に用いる
    @producer = User.find(1)
  end

  def help
  end

  def contact
  end

  def policy
  end
end
