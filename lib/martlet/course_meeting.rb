module Martlet
  class CourseMeeting
    include DayConversions

    attr_reader :start_time, :end_time, :start_date, :end_date, :days, :location

    def initialize(args)
      @start_time, @end_time = parse_time_range(args[:time])
      @start_date, @end_date = parse_date_range(args[:date_range])
      @days     = parse_days(args[:days])
      @location = args[:location]
    end

    private

    def parse_time_range(time_range)
      times = time_range.scan(/\d+:\d+\s[AP]M/)
      times.map { |time| Time.parse(time) }
    end

    def parse_date_range(date_range)
      dates = date_range.scan(/\w+\s\d+,\s\d+/)
      dates.map { |date| Date.parse(date) }
    end

    def parse_days(days)
      days.split('').map { |letter| day_from_letter(letter) }
    end
  end
end
