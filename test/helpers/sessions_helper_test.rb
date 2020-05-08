require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:alice)
    remember(@user)
  end

  test "except true and session is nil" do
    assert_equal @user, current_user
    # session_helperのメソッドを呼んでいる?
    assert logged_in?
  end

  test "except current_user is nil and remember_digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end