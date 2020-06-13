class InquiriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @inquiry = current_user.inquiries.build
  end

  def create
    @inquiry = current_user.inquiries.build(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      flash[:success] = 'お問い合わせメッセージを送信しました。'
      redirect_to root_url
    else
      flash[:danger] = 'お問い合わせメッセージの送信に失敗しました。お手数ですがもう一度お試しください。'
      render 'new'
    end
  end

  private

    def inquiry_params 
      params.require(:inquiry).permit(:message)
    end
end