module EventsHelper
  def set_default_capacity(event)
    event.capacity = 30
  end

  def capacity_over?(event)
    event.capacity <= event.entries.count
  end

  def time_over?(event)
    entry_limit = event.start_date - 1.hours
    entry_limit < Time.zone.now
    # 現在時刻が期限前であることを表すときはこっち
    #Time.zone.now < entry_limit
  end
end
