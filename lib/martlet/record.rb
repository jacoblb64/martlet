module Martlet
  class Record
    attr_accessor :number, :name, :section, :credits, :grade, :average
    
    def initialize(args)
      @number  = args[:number]
      @name    = args[:name]
      @section = args[:section]
      @credits = args[:credits].to_i
      @grade   = args[:grade]
      @average = args[:average]
    end
    
    def gpa
      grade_to_gpa(grade)
    end
    
    def average_gpa
      grade_to_gpa(average)
    end
    
    private
    
    def grade_to_gpa(grade)
      case grade
      when 'A'  then 4.0
      when 'A-' then 3.7
      when 'B+' then 3.3
      when 'B'  then 3.0
      when 'B-' then 2.7
      when 'C+' then 2.3
      when 'C'  then 2.0
      when 'D'  then 1.0
      when 'F'  then 0.0
      else nil
      end
    end
  end
end