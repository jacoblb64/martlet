require 'mechanize'

module Martlet
  class Client
    attr_reader :email
    
    def initialize(email, password)
      @agent = Mechanize.new
      @email = email
      
      authenticator = Authenticator.new(@agent)
      authenticator.authenticate(email, password)
    end
  end
end