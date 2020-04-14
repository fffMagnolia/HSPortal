require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Len Kiryu", email: "user@example.com")
  end

  test "expect valid" do
    assert @user.valid?
  end

  test "expect name present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "expect email present" do
    @user.email = ""
    assert_not @user.valid?
  end
end
