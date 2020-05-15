require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "should fail signup" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: {
        user: {
          name: "",
          email: "invalid@com",
          password: "",
          password_confirmation: ""
        } }
    end
    assert_template 'users/new'

    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  test "should success signup with account activation" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: {
        user: {
          name: "test user",
          email: "testuser@example.com",
          password: "testuser",
          password_confirmation: "testuser"
        } }
    end
    # メールの送信先が追加されていることを期待
    assert_equal 1, ActionMailer::Base.deliveries.size
    # === not activated pattern ====
    # assigns: 対応するアクションのインスタンス変数を取得する。今回はuser_controllerのcreateアクション？
    user = assigns(:user)

    assert_not user.activated?
    log_in(user)
    assert_not logged_in?
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not logged_in?
    get edit_account_activation_path(user.activation_token, email: "wrong mail")
    assert_not logged_in?
    #=== success pattern ===
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    assert_redirected_to root_url
    follow_redirect!
    # logged_in?はtest_helperのを呼び出している
    assert logged_in?
    # フラッシュメッセージが表示されていることを期待
    assert_not flash.empty?
  end
end
