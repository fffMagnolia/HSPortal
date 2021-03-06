require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
  end

  test "expect fail update" do
    log_in(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path, params: { user: {
      name: '',
      email: 'invalid@example.com',
      password: 'foo',
      password_confirmation: 'bar'
    } }
    assert_template 'users/edit'
  end

  test "expect success update with friendly forwarding" do
    get edit_user_path(@user)
    log_in(@user)
    assert_redirected_to edit_user_url(@user)
    patch user_path(@user), params: { user: {
      name: 'Foo Bar',
      email: 'foo@bar.com',
      # passwordは更新しないことを想定
      password: '',
      password_confirmation: ''
    } }
    # フラッシュメッセージが表示されることを期待
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal 'Foo Bar', @user.name
    assert_equal 'foo@bar.com', @user.email
  end
end
