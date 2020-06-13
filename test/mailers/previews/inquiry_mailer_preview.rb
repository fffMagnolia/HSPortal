# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  def send_mail
    user = User.first
    inquiry = user.inquiries.first
    InquiryMailer.send_mail(inquiry)
  end
end
