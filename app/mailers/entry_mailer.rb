class EntryMailer < ApplicationMailer
  def entry_mail(user, event)
    @user = user
    @event = event
    mail to: @user.email, subject: "#{@event.title}参加予約のお知らせ" 
  end
end
