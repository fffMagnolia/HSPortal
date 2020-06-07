class UsersController < ApplicationController

  # need permission action
  before_action :logged_in_user, only: [ :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update, :destroy ]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # 主宰したイベントを5件ごとに表示
    @events = @user.events.paginate(page: params[:page], per_page: 5)

    # 参加したイベントを5件ごとに表示
    @entries = @user.entries.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = '登録されたメールアドレスにメールを送信しました。ご確認ください。 '
      redirect_to root_url
    else
      render 'new'
    end
  end

  # users/id/editアクセス時の処理
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新が完了しました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    log_out
    flash[:success] = "退会手続きが完了しました。"
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :message)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) if @user != current_user
    end
end