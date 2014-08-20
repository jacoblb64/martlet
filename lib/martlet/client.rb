require 'mechanize'

module Martlet
  class Client
    attr_reader :email
    
    def initialize(email, password)
      @agent = Mechanize.new
      @email = email.include?('@') ? email : "#{email}@mail.mcgill.ca"
      
      authenticator = Authenticator.new(@agent)
      authenticator.authenticate(@email, password)
    end
    
    def grades
      transcript = Transcript.new(@agent)
      transcript.fetch_grades
    end

    def schedule(semester, year)
      Schedule.new(@agent, semester, year)
    end

    def courses(semester, year)
      schedule(semester, year).fetch_courses
    end

    def export(schedule)
      exporter = CalendarExporter.new(schedule)
      exporter.export
    end
  end
end
