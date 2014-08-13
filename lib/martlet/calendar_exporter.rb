module Martlet
  class CalendarExporter
    include CalendarHelpers

    def initialize(schedule)
      @schedule = schedule
      @filename = "#{schedule.semester}_#{schedule.year}.ics"
    end

    def export
      courses = @schedule.fetch_courses

      f = File.new(@filename, 'w')
      f.write("BEGIN:VCALENDAR\r\n")

      courses.each do |course|
        course.meetings.each do |meeting|
          if meeting.start_time.nil?
            puts "Warning: schedule information unavailable for #{course.number}"
          else
            f.write(calendar_vevent(course, meeting))
          end
        end
      end

      f.write("END:VCALENDAR\r\n")
      f.close
    end

    private

    def calendar_dtstart(meeting)
      event_date = calendar_date(meeting.start_date)
      start_time = calendar_time(meeting.start_time)
      "#{event_date}T#{start_time}"
    end

    def calendar_dtend(meeting)
      event_date = calendar_date(meeting.start_date)
      end_time   = calendar_time(meeting.end_time)
      "#{event_date}T#{end_time}"
    end

    def calendar_rrule(meeting)
      end_date    = calendar_date(meeting.end_date)
      repeat_days = calendar_days(meeting.days)
      "FREQ=WEEKLY;INTERVAL=1;UNTIL=#{end_date}T235959;BYDAY=#{repeat_days}"
    end

    def calendar_vevent(course, meeting)
      begin_vevent = "BEGIN:VEVENT\r\n"
      summary      = "SUMMARY:#{course.number} - #{course.name}\r\n"
      location     = "LOCATION:#{meeting.location}\r\n"
      dtstart      = "DTSTART:#{calendar_dtstart(meeting)}\r\n"
      dtend        = "DTEND:#{calendar_dtend(meeting)}\r\n"
      rrule        = "RRULE:#{calendar_rrule(meeting)}\r\n"
      end_vevent   = "END:VEVENT\r\n"

      if exclude_first_day?(meeting)
        exdate = "EXDATE:#{calendar_dtstart(meeting)}\r\n"
        [begin_vevent, summary, location, dtstart, dtend, rrule, exdate, end_vevent].join('')
      else
        [begin_vevent, summary, location, dtstart, dtend, rrule, end_vevent].join('')
      end
    end
  end
end
