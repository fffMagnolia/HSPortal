class EntriesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    current_user.entry(event)
    flash[:success] = "イベント[#{event.title}]に参加登録しました。"

    redirect_to event
  end
end
