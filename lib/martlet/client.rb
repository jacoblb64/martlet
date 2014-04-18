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

    def courses(semester, year)
      schedule = Schedule.new(@agent, semester, year)
      schedule.fetch_courses
    end
  end
end
