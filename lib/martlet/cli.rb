require 'thor'
require 'yaml'
require 'io/console'

module Martlet
  class CLI < Thor
    default_task :grades

    desc "grades", "Lists all your grades"
    method_option :order_by, aliases: 'o', enum: ['course', 'grade']
    def grades
      puts 'Fetching grades...'
      grades = client.grades

      grades = case options.order_by
      when 'course' then grades.sort_by { |k,v| k }
      when 'grade'  then grades.sort_by { |k,v| Grade.new v }
      else grades
      end

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
