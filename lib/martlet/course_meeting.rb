module Martlet
  class CourseMeeting
    attr_reader :start_time, :end_time, :start_date, :end_date, :days, :location

    def initialize(args)
      @start_time = args[:start_time]
      @end_time   = args[:end_time]
      @start_date = args[:start_date]
      @end_date   = args[:end_date]
      @days       = args[:days]
      @location   = args[:location]
    end
  end
end
