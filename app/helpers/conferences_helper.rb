module ConferencesHelper
  def human_date_with_time(date)
    date.strftime("%d.%m.%Y %H:%M") if date
  end

  def human_date(date)
    date.strftime("%d.%m.%Y") if date
  end

end
