require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Len Kiryu", email: "user@example.com", password: 'foobarbaz', password_confirmation: 'foobarbaz')
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
    invalid_addr = [ ' ', 'user_email.com' ]
    invalid_addr.each do |addr|
      @user.email = addr
      assert_not @user.valid?, "#{addr} should be invalid!"
    end
  end

  test "expect email is unique and BIG CHAR the same normal char" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "expect email able to triming" do
    @user.email = 'user @ example.com'
    @user.save
    assert_equal 'user@example.com', @user.reload.email
  end

  test "expect email able to downcase" do
    mixed_email = 'User@Example.Com'
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end

  # NOTE: this password policy is not enougth
  test "expect password min-length is 8 char" do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end

  test "expect false when remember_digest was nil" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "expect destroy user with associated events" do
    @user.save
    @user.events.create!(content: "An Event", start_date: Time.zone.now, end_date: Time.zone.now, title: "An Event Now On Start!")
    assert_difference 'Event.count', -1 do
      @user.destroy
    end
  end
end
