require 'test_helper'

class InfosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @owner = users(:alice)
    @non_owner = users(:marchhere)
    @alice_event = events(:alice_event)
    @info = infos(:one)
  end

  test "expect redirect when neither owner nor member access info" do
    log_in @non_owner
    # do not show
    get event_info_path(@alice_event, @info)
    assert_redirected_to root_url
    # do not new
    get new_event_info_path(@alice_event)
    assert_redirected_to root_url
  end

  test "expect fail when non owner destroyed info" do
    log_in @non_owner
    assert_no_difference "@alice_event.infos.count" do
      delete event_info_path(@alice_event, @info)
    end
    assert_redirected_to root_url
  end

  test "expect success when owner destroyed info" do
    log_in @owner
    assert_equal @alice_event.user_id, session[:user_id]
    assert_difference "@alice_event.infos.count", -1 do
      delete event_info_path(@alice_event, @info)
    end
    assert_redirected_to root_url
  end
end