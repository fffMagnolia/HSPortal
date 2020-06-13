require 'test_helper'

class EntryMailerTest < ActionMailer::TestCase
  def setup
    @alice = users(:alice)
    @marchhere = users(:marchhere)
    @alice_event = events(:alice_event)
    @marchhere.members.create!(event_id: @alice_event.id)
  end

  # 最低限の内容チェックのみ
  test "send_entry_email" do
    mail = EntryMailer.entry_mail(@marchhere, @alice_event)

    assert_equal "#{@alice_event.title}参加予約のお知らせ", mail.subject
    assert_equal [@marchhere.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match @marchhere.name, mail.text_part.body.decoded.encode('UTF-8')
    assert_match @alice_event.title, mail.text_part.body.decoded.encode('UTF-8')
  end
end
