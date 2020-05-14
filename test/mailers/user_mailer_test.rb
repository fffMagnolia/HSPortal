require 'test_helper'
require 'base64'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:alice)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)

    assert_equal "アカウントの有効化", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name, mail.text_part.body.decoded.encode('UTF-8')
    assert_match user.activation_token, mail.text_part.body.decoded.encode('UTF-8')
    assert_match CGI.escape(user.email), mail.text_part.body.decoded.encode('UTF-8')
  end

=begin
  test "password_reset" do
    mail = UserMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
=end
end
