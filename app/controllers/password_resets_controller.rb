class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

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

  def update
    if params[:user][:password].empty?
      # modelではvalidationを通すためこちらで対処
      @user.errors.add(:password, :blank) 
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = "パスワードの再設定が完了しました。"
      redirect_to root_url
    else
      # NOTE: どんな場合にここを通るのかがよくわからない
      render 'edit'
    end
  end

  private

    def user_params
      params(:user).permit(:password, :password_confirmation)
    end

    def get_user
      # hidden保持しているのでparams[:email]で取得する
      @user = User.find_by(email: params[:email])
    end

    def correct_user
      if !(@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        flash[:danger] = "ユーザ認証に失敗しました。"
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_expired?
        flash[:danger] = "リンクの有効期限が切れています。"
        redirect_to root_url
      end
    end
end
