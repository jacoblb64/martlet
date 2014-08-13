module Martlet
  class CalendarExporter
    include CalendarHelpers

    def initialize(schedule)
      @schedule = schedule
      @filename = "#{schedule.semester}_#{schedule.year}.ics"
    end

    def export
      courses = @schedule.fetch_courses
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
  end
end
