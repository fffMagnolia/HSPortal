require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end
