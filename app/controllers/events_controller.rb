class EventsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "イベント[#{@event.title}]を作成しました。"
      redirect_to events_url
    else
      render 'new'
    end
  end

  def edit
    @event = current_user.events.find_by(id: params[:id])
  end

  def update
    @event = current_user.events.find_by(id: params[:id])
    if @event.update(event_params)
      flash[:success] = "イベント[#{@event.title}]を更新しました。"
      redirect_to events_url
    else
      render 'edit'
    end
  end

  def index
    @events = Event.all
  end

  private

    # user_idを弄れないようにしている
    def event_params
      params.require(:event).permit(:title, :content, :start_date, :end_date)
    end

end
