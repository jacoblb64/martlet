module Martlet
  class Course
    include DayConversions

    attr_accessor :name, :number, :term, :crn, :instructor, :credits, :level, :campus,
                  :time, :days, :location, :date_range, :type, :instructors

    def initialize(args)
      @name        = args[:name] || ''
      @number      = args[:number]
      @term        = args[:term]
      @crn         = args[:crn]
      @instructor  = args[:instructor]
      @credits     = args[:credits]
      @level       = args[:level]
      @campus      = args[:campus]
      @time        = args[:time]
      @days        = args[:days] || ''
      @location    = args[:location]
      @date_range  = args[:date_range]
      @type        = args[:type]
      @instructors = args[:instructors]

      @name.gsub! /\.$/, ''
      @days = @days.split('').map { |letter| day_from_letter(letter) }
    end
  end
end