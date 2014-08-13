module Martlet
  module CalendarHelpers
    include DayConversions

    def calendar_time(time)
      format("%02d%02d00", time.hour, time.min)
    end

    def calendar_date(date)
      format("%04d%02d%02d", date.year, date.month, date.day)
    end

    def calendar_day(day)
      case day.capitalize
      when 'Sunday'    then 'SU'
      when 'Monday'    then 'MO'
      when 'Tuesday'   then 'TU'
      when 'Wednesday' then 'WE'
      when 'Thursday'  then 'TH'
      when 'Friday'    then 'FR'
      when 'Saturday'  then 'SA'
      end
    end

    def calendar_days(days)
      repeat_days = days.map { |day| calendar_day(day) }
      repeat_days.join(',')
    end

    def in_days?(date, days)
      wday  = date.wday
      wdays = days.map { |day| number_from_day(day) }
      wdays.include?(wday)
    end

    def exclude_first_day?(meeting)
      !in_days?(meeting.start_date, meeting.days)
    end
  end
end
