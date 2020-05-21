class EventsController < ApplicationController

  before_action :logged_in_user, only: [:create, :edit]

  def show
    @event = Event.find(params[:id])
  end

  def create
  end

  def edit
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
  end

end
