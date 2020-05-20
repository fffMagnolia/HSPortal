require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = events(:most_recent)
  end

  test "expect redirect when not logged in user" do
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
end
