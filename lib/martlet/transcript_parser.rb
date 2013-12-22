module Martlet
  class TranscriptParser
    def initialize(html)
      @html = html
    end
    
    def parse_records
      records = []
      document = Nokogiri::HTML(@html)
      rows = document.search("table[@class='dataentrytable'] tr")
      
      rows.each do |row|
        row_data = row.search('td')
        next unless record_data_row?(row_data) && grade_present?(row_data)
        
        record_data = {
          number:  extract_record_data_for(row_data, :number),
          name:    extract_record_data_for(row_data, :name),
          section: extract_record_data_for(row_data, :section),
          credits: extract_record_data_for(row_data, :credits),
          grade:   extract_record_data_for(row_data, :grade),
          average: extract_record_data_for(row_data, :average)
        }
        
        records << Record.new(record_data)
        
      end
      
      records
    end
    
    private
    
    def index_for(name)
      case name
      when :number  then 1
      when :section then 2
      when :name    then 3
      when :credits then 4
      when :grade   then 6
      when :average then 10
      end
    end
    
    def extract_record_data_for(data, name)
      index = index_for(name)
      
      if data && data[index]
        span = data[index].search('span')
        
        if span
          span.text
        else
          ''
        end
      end
    end
    
    def record_data_row?(row_data)
      row_data.length == 11
    end
    
    def grade_present?(row_data)
      grade = extract_record_data_for(row_data, :grade)
      grade && !grade.empty?
    end
  end
end