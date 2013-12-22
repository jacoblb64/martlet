module Martlet
  class AuthenticationError < StandardError; end
  
  class Authenticator
    def initialize(agent)
      @agent = agent
    end
    
    def authenticate(email, password)
      # Go to login page
      login_page = @agent.get(login_url)
      
      # Find and fill login form
      form = login_form(login_page)
      form['sid'] = email
      form['PIN'] = password
      
      submit_login_form(form)
    end
    
    private
    
    def login_url
      'https://horizon.mcgill.ca/pban1/twbkwbis.P_WWWLogin'
    end
    
    def login_form(page)
      if form = page.form('loginform1')
        form
      else
        raise AuthenticationError.new('Login form not found')
      end
    end
    
    def submit_login_form(form)
      page = form.submit
      body = page.body
      
      unless body.match(/Welcome,\+(.*),\+to\+Minerva/)
        if body.include?('Authorization Failure')
          raise AuthenticationError.new('Invalid email or password')
        else
          raise AuthenticationError.new('Authentication failed')
        end
      end
    end
  end
end