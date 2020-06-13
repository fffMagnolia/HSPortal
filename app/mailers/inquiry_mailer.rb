class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    @user = User.find(id: @inquiry.user_id)
    mail to: "inquiry@example.com", subject: "HSPortalお問い合わせ"
  end
end