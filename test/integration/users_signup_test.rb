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
    follow_redirect!
    assert_template 'static_pages/home'
  end
end
