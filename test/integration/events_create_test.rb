require 'test_helper'

class EventsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
  end

  test "expect invalid create" do
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

  test "expect create success" do
    log_in(@user)
    get new_event_path
    assert_difference 'Event.count', 1 do
      post events_path, params: { event: {
        content: "now on open!",
        start_date: 1.hours.ago,
        end_date: Time.zone.now,
        title: "New Event"
      } }
    end
    assert_not flash.empty?
    assert_redirected_to events_url
  end
end
