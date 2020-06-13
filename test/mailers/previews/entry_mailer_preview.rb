# Preview all emails at http://localhost:3000/rails/mailers/entry_mailer
class EntryMailerPreview < ActionMailer::Preview
  # Preview all emails at http://localhost:3000/rails/mailers/entry_mailer/entry_mail
  def entry_mail
    second_user = User.second
    event = second_user.entries.first
    EntryMailer.entry_mail(second_user, event)
  end
end
