require 'thor'
require 'yaml'
require 'io/console'

module Martlet
  class CLI < Thor
    default_task :grades

    desc "grades", "Lists all your grades"
    def grades
      puts 'Fetching grades...'
      grades = client.grades

      grades.each do |number, grade|
        puts "#{number}: #{grade}"
      end
    end

    private

    def credentials
      email = nil
      password = nil
      
      if File.exist?(config_path)
        # Get credentials from config file
        config = YAML.load_file config_path
        email = config['email']
        password = config['password']
      else
        # Get credentials from stdin
        print 'Minerva email: '
        email = gets.chomp
      
        print 'Password: '
        password = STDIN.noecho(&:gets).chomp
        puts
      end
      
      return email, password
    end

    def client
      @client ||= begin
        puts 'Authenticating...'
        Martlet.new(*credentials)
      end
    end

    def config_path
      "#{ENV['HOME']}/.martlet"
    end
  end
end
