class InfosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :destroy]
  before_action :owner,          only: [:new, :create, :destroy]

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @info = @event.infos.build(info_params)
    if @info.save
      flash[:success] = "メッセージ[#{@info.title}]を送信しました。"
      redirect_to event_url(@event)
    else
      render 'new'
    end
  end

  def show
    @info = Info.find(params[:id])
  end

  def destroy
    @info = Info.find(params[:id])
    @info_title = @info.title
    @info.destroy
    flash[:success] = "お知らせ#{@info_title}を削除しました。"
    redirect_to root_url
  end

  private

    def info_params
      params.require(:info).permit(:title, :message)
    end

    def owner
      @event = Event.find(params[:id])
      redirect_to root_url if @event.owner_id != current_user.id
    end
end
