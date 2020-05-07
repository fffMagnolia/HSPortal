require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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

  test "should success signup" do
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
    assert_redirected_to root_url
    follow_redirect!
    # logged_in?はtest_helperのを呼び出している
    assert logged_in?
    # フラッシュメッセージが表示されていることを期待
    assert_not flash.empty?
  end
end
