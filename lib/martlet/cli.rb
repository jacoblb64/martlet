require 'thor'
require 'yaml'
require 'io/console'

module Martlet
  class CLI < Thor
    default_task :grades

    desc "grades", "Lists all your grades"
    option :sort, aliases: 's', enum: ['course', 'grade']
    def grades
      puts 'Fetching grades...'
      grades = client.grades

      grades = case options['sort']
      when 'course' then grades.sort_by { |k,v| k }
      when 'grade'  then grades.sort_by { |k,v| Grade.new v }
      else grades
      end

      grades.each do |number, grade|
        puts "#{number}: #{grade}"
      end
    end

    desc "courses SEMESTER YEAR", "List current courses or courses for given semester and year"
    option :export, type: :boolean, default: false,
                    desc: "Export course schedule as an iCalendar (.ics) file in the current directory"
    def courses(semester = nil, year = nil)
      if semester.nil? || year.nil?
        semester, year = current_semester_and_year
      end

      puts 'Fetching courses...'
      schedule = client.schedule(semester, year)
      courses = schedule.fetch_courses
      course_name_size = courses.map { |c| c.name.length }.max

      puts "#{semester.capitalize} #{year} courses"

      courses.each do |course|
        course_row_format = "%-11s %-#{course_name_size}s @ %s\n"
        printf course_row_format, "#{course.number}", course.name, course.location
      end

      puts 'No courses found' if courses.empty?

      if options[:export] && !courses.empty?
        filename = "#{semester}_#{year}.ics"
        puts "Exporting courses to #{filename}..."
        client.export_calendar(filename, courses)
      end
    end

    def self.exit_on_failure?
      true
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
    rescue StandardError => e
      puts "Error: #{e.message}"
      exit 1
    end

    def config_path
      "#{ENV['HOME']}/.martlet"
    end

    def current_semester_and_year
      semester = case Time.now.month
      when 1..4  then 'winter'
      when 5..8  then 'summer'
      when 9..12 then 'fall'
      end

      return semester, Time.now.year
    end
  end
end
