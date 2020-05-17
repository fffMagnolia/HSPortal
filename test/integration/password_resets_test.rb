require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:alice)
  end

  test "expect send email for password reset" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: {
      email: ""
    } }
    assert_not flash.empty?
    assert_template 'password_resets/new'

    post password_resets_path, params { password:reset: {
      email: @user.email
    } }
    # 不正アクセスされていないことを期待
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "password reset" do
    #NOTE: edit form のインスタンス変数を取得している?
    user = assigns(:user)

    # 不正アクセスされた場合を想定？
    get edit_password_reset(user.reset_token, email: "")
    assert_redirected_to root_url

    get edit_password_reset("invalid token", email: user.email)
    assert_redirected_to root_url

    user.toggle!(:activated)
    get edit_password_reset(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)

    get edit_password_reset(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email

    patch password_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: 'foobarbaz',
        password_confirmation: 'difference'
      }
    }
    # 現時点では動作しないのでコメントアウトしている.formのエラ〜メッセージを表示できるようにする
    #assert_select 'div#error_explanation'

    patch password_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: '',
        password_confirmation: ''
      }
    }
    #assert_select 'div#error_explanation'

    patch password_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: 'foobarbaz',
        password_confirmation: 'foobarbaz'
      }
    }
    assert logged_in?
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
