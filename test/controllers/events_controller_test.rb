require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
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
end
