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
    get root_url
    # フラッシュが消えていることを期待
    assert flash.empty?
  end

  test "except login then logout" do
    get login_path
    post login_path, params: { session: {
      email: @user.email,
      password: "password"
    } }
    # test_helperのメソッドが呼び出されている
    assert logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    # 切り替え表示後に非表示になっていることを期待
    assert_select "a[href=?]", login_path, count: 0 
    # 切り替え表示後に表示されていることを期待
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    # === logout section ===
    delete logout_path
    # test_helperのメソッドが呼び出されている
    assert_not logged_in?
    assert_redirected_to root_url
    follow_redirect!
    # 切り替え表示後に表示されていることを期待
    assert_select "a[href=?]", login_path
    # 切り替え表示後に非表示になっていることを期待
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    # === multi tab open pettern simulate ===
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
