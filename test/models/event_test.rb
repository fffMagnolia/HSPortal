require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:alice)
    @event = @user.events.build(content: "New Event For HSP", user_id: @user.id, start_date: Time.zone.now, end_date: (Time.zone.now + 1.hours), title: "New Event Now On Start!")
  end

  test "expect event valid" do
    assert @event.valid?
  end

  test "expect user_id present" do
    @event.user_id = nil
    assert_not @event.valid?
  end

  test "expect content present" do
    @event.content = " "
    assert_not @event.valid?
  end

  test "expect start_date present" do
    @event.start_date = nil
    assert_not @event.valid?
  end

  test "expect end_date present" do
    @event.end_date = nil
    assert_not @event.valid?
  end

  test "expect title present" do
    @event.title = nil
    assert_not @event.valid?
  end
  
  test "expect content max char 500" do
    @event.content = "a"*501
    assert_not @event.valid?
  end

  test "expect title max char 50" do
    @event.title = "a"*51
    assert_not @event.valid?
  end

  # 最新のものから表示するよう設計
  test "expect order recent first" do
    assert_equal events(:most_recent), Event.first
  end
end
