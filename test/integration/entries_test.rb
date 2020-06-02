require 'test_helper'

class EntriesTest < ActionDispatch::IntegrationTest
  def setup
    @alice = users(:alice)
    @marchhere = users(:marchhere)
    @duchess = users(:duchess)
    @alice_event = events(:four)
    @marchhere_event = events(:two)
  end

  test "expect user unable entry when invalid" do
    # === ユーザが主催者の場合 ===
    log_in @alice
    get event_path(@alice_event)
    # 主催者には「編集する」ボタンが表示されていることを期待
    assert_select "a[href=?]", edit_event_path(@alice_event)
    # その他のパターンの表示はないことを期待
    assert_select "form", false
    assert_select "p.text-info", false
    log_out(@alice)

    # === ユーザが既に参加登録している場合 ===
    log_in @marchhere
    get event_path(@alice_event)
    # 「参加する」ボタンが表示されていることを期待
    assert_match "参加する", @response.body
    # 参加
    @marchhere.entry(@alice_event)
    @marchhere.reload
    get event_path(@alice_event)
    # 「参加する」ボタンが表示されていないことを期待
    assert_no_match "参加する", @response.body
    log_out(@marchhere)

    # 前準備
    @marchhere_event.capacity = 1
    log_in(@duchess)
    @duchess.entry(@marchhere_event)
    log_out(@duchess)
    # === イベントが定員に到達している場合 ===
    log_in(@alice)
    get event_path(@marchhere_event)
    # 「参加する」ボタンが表示されていないことを期待
    assert_select "form", false
    assert_select "p.text-info"
    log_out(@alice)

    # 前準備
    @marchhere_event.capacity = 5
    @marchhere_event.start_date = Time.zone.now + 30.minutes
    # === エントリー期限を過ぎている場合 ===
    log_in(@alice)
    get event_path(@marchhere_event)
    # 「参加する」ボタンが表示されていないことを期待
    assert_select "form", false
    assert_select "p.text-info"
  end
end
