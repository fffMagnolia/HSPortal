class EventsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "イベント[#{@event.title}]を作成しました。"
      redirect_to events_url
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
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
