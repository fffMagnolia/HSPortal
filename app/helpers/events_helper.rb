module EventsHelper
  def set_default_capacity(event)
    event.capacity = 30
  end

  # 定員に到達していないことを期待
  def capacity_over?(event)
    event.entries.count < event.capacity
  end

  # 開始時刻1時間前以前であることを期待
  def time_over?(event)
    entry_limit = event.start_date - 1.hours
    entry_limit > Time.zone.now
  end
end
