module EventsHelper
  def set_default_capacity(event)
    event.capacity = 30
  end

  # 定員に到達していないことを期待
  def capacity_over?(event)
    event.capacity < event.entries.count
  end

  # 開始時刻1時間前以前であることを期待
  def time_over?(event)
    entry_limit = event.start_date - 1.hours
    entry_limit < Time.zone.now
    # 現在時刻が期限前であることを表すときはこっち
    #Time.zone.now < entry_limit
  end
end
