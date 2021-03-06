require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:alice)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title('Profile')
    assert_match @user.events.count.to_s, response.body
    assert_select 'div.pagination'
    @user.events.paginate(page: 1).each do |event|
      assert_select 'tr>td>a'
    end
  end
end
