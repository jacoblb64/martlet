module Martlet
  module DayConversions
    def day_from_letter(letter)
      case letter.upcase
      when 'M' then 'Monday'
      when 'T' then 'Tuesday'
      when 'W' then 'Wednesday'
      when 'R' then 'Thursday'
      when 'F' then 'Friday'
      else letter
      end
    end

    def short_day_name(day)
      case day.capitalize
      when 'M', 'Monday'    then 'Mon'
      when 'T', 'Tuesday'   then 'Tue'
      when 'W', 'Wednesday' then 'Wed'
      when 'R', 'Thursday'  then 'Thu'
      when 'F', 'Friday'    then 'Fri'
      else day
      end
    end

    def number_from_day(day)
      case day.capitalize
      when 'M', 'Monday'    then 1
      when 'T', 'Tuesday'   then 2
      when 'W', 'Wednesday' then 3
      when 'R', 'Thursday'  then 4
      when 'F', 'Friday'    then 5
      end
    end
  end
end