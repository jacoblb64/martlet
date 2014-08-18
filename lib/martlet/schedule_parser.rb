module Martlet
  class ScheduleParser
    include DayConversions

    def initialize(html)
      @html = html
    end

    def parse_courses
      courses = []
      document = Nokogiri::HTML(@html)
      course_tables = document.search("br+table[@class='datadisplaytable']")
      course_times  = document.search("br+table[@class='datadisplaytable']+table tr")
      course_times  = split_course_times(course_times)

      course_tables.each_with_index do |table, index|
        course_name_info = table.search('caption').first
        course_name_info = course_name_info.text.split(' - ')
        course_name = course_name_info[0]
        course_number = course_name_info[1]

        course_data = table.search('tr td').map { |d| d.text.strip }
        course_time_info = course_times[index].map do |course_time|
          course_time.search('td').map { |d| d.text.strip }
        end

        meetings = course_time_info.map do |course_time|
          start_time, end_time = parse_time_range(course_time[0])
          start_date, end_date = parse_date_range(course_time[3])
          days = parse_days(course_time[1])

          CourseMeeting.new({
            start_time:  start_time,
            end_time:    end_time,
            start_date:  start_date,
            end_date:    end_date,
            days:        days,
            location:    course_time[2]
          })
        end

        courses << Course.new({
          name:        course_name,
          number:      course_number,
          term:        course_data[0],
          crn:         course_data[1],
          instructor:  course_data[3],
          credits:     course_data[5],
          level:       course_data[6],
          campus:      course_data[7],
          meetings:    meetings
        })
      end

      courses
    end

    private

    def split_course_times(course_times)
      split = []
      course_times.each do |info|
        if headers?(info)
          split << []
        else
          split.last << info
        end
      end
      split
    end

    def headers?(row)
      !row.search('th').empty?
    end

    def parse_time_range(time_range)
      times = time_range.scan(/\d+:\d+\s[AP]M/)
      times.map { |time| Time.parse(time) }
    end

    def parse_date_range(date_range)
      dates = date_range.scan(/\w+\s\d+,\s\d+/)
      dates.map { |date| Date.parse(date) }
    end

    def parse_days(days)
      days.split('').map { |letter| day_from_letter(letter) }
    end
  end
end
