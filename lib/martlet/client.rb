require 'mechanize'

module Martlet
  class Client
    attr_reader :email
    
    def initialize(email, password)
      @agent = Mechanize.new
      @email = format_email(email)
      
      authenticator = Authenticator.new(@agent)
      authenticator.authenticate(@email, password)
    end
    
    def grades
      transcript = Transcript.new(@agent)
      transcript.fetch_grades
    end
    
    private
    
    def format_email(email)
      if email.include?('@')
        email
      else
        "#{email}@mail.mcgill.ca"
      end
    end
  end
end