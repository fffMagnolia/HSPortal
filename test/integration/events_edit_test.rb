require 'test_helper'

class EventsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
  end

  test "expect fail update" do
    log_in(@user)
    event = @user.events.first
    patch event_path(event), params: { event: {
      content: "",
      start_date: "",
      end_date: "",
      title: ""
    } }
    assert_template 'events/edit'
  end

  test "expect success update when content and title nil" do
    log_in(@user)
    event = @user.events.first
    #update_date = Time.zone.now.strftime("%Y-%m-%d %H:%M")
    update_date = Time.zone.now
    patch event_path(event), params: { event: {
      content: event.content,
      start_date: 1.hours.ago,
      end_date: update_date,
      title: event.title
    } }
    assert_not flash.empty?
    assert_redirected_to events_url
    event.reload
    #assert_equal event.end_date, update_date
    assert_in_delta event.end_date, update_date, 1.second
  end
end