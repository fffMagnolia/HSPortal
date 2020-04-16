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

  test "expect name max-length 50 char" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test "expect email max-length 255 char" do
    @user.email = "a"*244 + "@example.com"
    assert_not @user.valid?
  end

  test "expect email format valid" do
    valid_addr = [ 'user123@456example.com', 'USER@EXAMPLE.com', 'user+_-@example.com', 'user@example-foo.bar.com' ]
    valid_addr.each do |addr|
      @user.email = addr
      assert @user.valid?, "#{addr} should be valid!"
    end
  end

  test "expect email format invalid" do
    invalid_addr = [ 'user @email.com', 'user@ email.com' ]
    invalid_addr.each do |addr|
      @user.email = addr
      assert_not @user.valid?, "#{addr} should be invalid!"
    end
  end

  test "expect email is unique and BIG CHAR the same normal char" do
    dup_user = @user.dup
    @user.save
    dup_user.email.upcase
    assert_not dup_user.valid?
  end
end
