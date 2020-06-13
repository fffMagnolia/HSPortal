require 'test_helper'

class InquiryTest < ActiveSupport::TestCase
  def setup
    @user = users(:alice)
    @inquiry = @user.inquiries.build(message: 'イベントの削除ができないのですがどうしたらいいのでしょうか？')
  end

  test "expect valid inquiry" do
    assert @inquiry.valid?
  end

  test "expect invalid when user_id nil" do
    @inquiry.user_id = nil
    assert_not @inquiry.valid?
  end

  test "expect invalid when message nil" do
    @inquiry.message = ''
    assert_not @inquiry.valid?
  end

  test "expect message max-length is 500" do
    @inquiry.message = "a" * 501
    assert_not @inquiry.valid?
  end
end
