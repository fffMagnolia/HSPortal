class PasswordResetsController < ApplicationController
  # NOTE: new/edit actionはview表示のためだけに必要

  def new
  end

  def  create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.sent_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました。ご確認ください。"
      # ログインフォームの方が使い勝手がいいかもしれない
      redirect_to root_url
    else
      flash[:danger] = "メールアドレスが登録されていません。"
      render 'new'
    end
  end

  def edit
  end
end
