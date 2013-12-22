module Martlet
  class Transcript
    def initialize(agent)
      @agent = agent
      @html  = fetch_transcript_html
    end
    
    def fetch_grades
      records = fetch_records
      records.inject({}) do |hash, record|
        hash[record.number] = record.grade
        hash
      end
    end
    
    def fetch_records
      parser = TranscriptParser.new(@html)
      parser.parse_records
    end
    
    private
    
    def transcript_url
      'https://horizon.mcgill.ca/pban1/bzsktran.P_Display_Form?user_type=S&tran_type=V'
    end
    
    def fetch_transcript_html
      page = @agent.get(transcript_url)
      page.body
    end
  end
end