require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:alice)
  end

  test "except login error flash only login view" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {
      email: "",
      password: ""
    } }
    assert_template 'sessions/new'
    # フラッシュが表示されていることを期待
    assert_not flash.empty?
    get root_path
    # フラッシュが消えていることを期待
    assert flash.empty?
  end

  test "except login" do
    get login_path
    post login_path, params: { session: {
      email: @user.email,
      password: "password"
    } }
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path, count: 0 
    # 切り替え表示後に表示されていることを期待
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end
