require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  def setup
    @entry = Entry.new(
      user_id:  users(:alice).id,
      event_id: events(:most_recent).id
    )
  end

  test "expect valid" do
    assert @entry.valid?
  end

  test "expect present user_id" do
    @entry.user_id = nil
    assert_not @entry.valid?
  end

  test "expect present event_id" do
    @entry.event_id = nil
    assert_not @entry.valid?
  end
end
