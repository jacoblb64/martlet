module Martlet
  class Course
    attr_accessor :name, :number, :term, :crn, :instructor, :credits, :level, :campus, :meetings

    def initialize(args)
      @name        = args[:name] || ''
      @number      = args[:number]
      @term        = args[:term]
      @crn         = args[:crn]
      @instructor  = args[:instructor]
      @credits     = args[:credits]
      @level       = args[:level]
      @campus      = args[:campus]
      @meetings    = args[:meetings]

      @name.gsub! /\.$/, ''
    end

    def location
      meetings.first.location
    end
  end
end
