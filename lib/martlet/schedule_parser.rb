module Martlet
  class ScheduleParser
    def initialize(html)
      @html = html
    end

    def parse_courses
      courses = []
      document = Nokogiri::HTML(@html)
      course_tables = document.search("br+table[@class='datadisplaytable']")
      course_times  = document.search("br+table[@class='datadisplaytable']+table tr+tr")

      course_tables.each_with_index do |table, index|
        course_name_info = table.search('caption').first
        course_name_info = course_name_info.text.split(' - ')
        course_name = course_name_info[0]
        course_number = course_name_info[1]

        course_time_info = course_times[index].search('td').map { |d| d.text.strip }

        course_data = table.search('tr td').map { |d| d.text.strip }
        args = {
          name:        course_name,
          number:      course_number,
          term:        course_data[0],
          crn:         course_data[1],
          instructor:  course_data[3],
          credits:     course_data[5],
          level:       course_data[6],
          campus:      course_data[7],
          time:        course_time_info[0],
          days:        course_time_info[1],
          location:    course_time_info[2],
          date_range:  course_time_info[3],
          type:        course_time_info[4],
          instructors: course_time_info[5]
        }

        courses << Course.new(args)
      end

      courses
    end
  end
end