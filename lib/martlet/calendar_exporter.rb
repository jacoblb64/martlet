module Martlet
  class CalendarExporter
    def initialize(schedule)
      @schedule = schedule
      @filename = "#{schedule.semester}_#{schedule.year}.ics"
    end

    def export
      courses = @schedule.fetch_courses
    end
  end
end
