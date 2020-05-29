require 'test_helper'

class InfoTest < ActiveSupport::TestCase
  def setup
    @event = events(:one)
    @info = @event.infos.build(message: 
      '当イベントにご参加くださりありがとうございます。当日は開始5分前までに下記のURLにアクセスして入室をお願いします。
      オンラインでの開催ではありますが、みなさまとお会いできますことを楽しみにしています。

      https://example.com'
    )
  end

  test "expect info valid" do
    assert @info.valid?
  end

  test "expect info message valid" do
    @info.message = ''
    assert_not @info.valid?
  end

  test "expect info event_id valid" do
    @info.event_id = nil
    assert_not @info.valid?
  end

  test "expect info message max char 1000" do
    @info.message = "a"*1001
    assert_not @info.valid?
  end
end
