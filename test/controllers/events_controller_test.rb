require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
    @event = events(:most_recent)
  end

  test "expect redirect when not logged in user posted" do
    assert_no_difference 'Event.count' do
      post events_path, params: { event: {
        content: "invalid event",
        start_date: 1.hours.ago,
        end_date: Time.zone.now,
        title: "Invalid Title"
      } }
      assert_redirected_to login_url
    end
  end

  test "expect redirect when not logged in user new access" do
    get new_event_path
    assert_redirected_to login_url
  end

  test "expect invalid" do
    log_in(@user)
    get new_event_path
    assert_no_difference 'Event.count' do
      post events_path, params: { event: {
        content: "",
        start_date: Time.zone.now,
        end_date: Time.zone.now,
        title: ""
      } }
    end
    assert_template 'events/new'
  end

end
