class ATChum
  attr_accessor :atc_hum, :filename
  
  def initialize filename
    @filename = filename
    @atc_hum = []
    makeAtcHash
  end
  
  def makeAtcHash
    File.open(@filename, 'r') do |f1|  
      while line = f1.gets  
        newline = line.split("\t")
        humATC_hash = Hash.new
        humATC_hash[:code] = newline[0]
        humATC_hash[:nimetus_est] = newline[1]
        humATC_hash[:nimetus_eng] = newline[2]
        @atc_hum.push humATC_hash
      end  
    end 
  end
  
end
