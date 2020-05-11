require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:alice)
    @other_user = users(:marchhere)
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign Up | HSPortal"
  end

  test "expect fail destroy and redirect login path not login" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "expect faild destroy when other user tried" do
    log_in(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "expect success destroy and redirect root" do
    log_in(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
