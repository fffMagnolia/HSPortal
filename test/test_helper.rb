ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def logged_in?
    !session[:user_id].nil?
  end

  # users_edit_testで使用されている？
  def log_in(user)
    session[:user_id] = user.id
  end
end

# 統合テスト用のヘルパーも一緒に書いておく
class ActionDispatch::IntegrationTest
  def log_in(user, password: 'password', remember_me: '1')
    post login_path, params: { session: {
      email: user.email,
      password: password,
      remember_me: remember_me
    } }
  end
end
