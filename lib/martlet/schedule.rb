module Martlet
  class Schedule
    def initialize(agent, semester, year)
      @agent    = agent
      @semester = semester
      @year     = year
      @html     = fetch_schedule_html
    end

    def fetch_courses
      parser = ScheduleParser.new(@html)
      parser.parse_courses
    end

    private

    def schedule_url
      'https://horizon.mcgill.ca/pban1/bwskfshd.P_CrseSchdDetl'
    end

    def number_from_semester(semester)
      case semester.to_s.downcase
      when 'winter' then '01'
      when 'summer' then '05'
      when 'fall'   then '09'
      end
    end

    def schedule_params
      { 'term_in' => "#{@year}#{number_from_semester(@semester)}" }
    end

    def fetch_schedule_html
      page = @agent.post(schedule_url, schedule_params)
      page.body
    end
  end
end