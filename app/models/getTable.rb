require 'getTable.rb'
class GetTable
  attr_accessor :url, :baseUrl, :finalrows
  
  def initialize url 
    @url = url
    @baseUrl = "http://193.40.10.165"
    @finalrows = []  
  end    


  def get_table
    page = Nokogiri::HTML(open(@url))
    links = page.css("a")
    links.each do |link|
      if link["href"].include? "SPC"
        @tabel = link.ancestors('table').first
        get_rows
        break
      end
    end 
  end
  
  def get_rows 
    brows = @tabel.children 
    rows = []
    #tabeliridade elementide vahel on palju tyhje text-node, eemaldada
    brows.each do |x|
      cleanrow = x.children.select{|z| z.type() == 1} 
      rows.push cleanrow
    end
    
    headers = rows[0]
    rows = rows.drop(1) #viska headersite rida minema
    if rows.count > 0
      vajalikudIndeksid = []
      headers.each do |th|
        col = th.inner_html().downcase
        if ((col.include? 'toime') || (col.include? 'atc') || (col =='spc'))
           vajalikudIndeksid.push headers.index(th)
        end
      end

      rows.each do |rida|
        vajalikRida = Hash.new
        vajalikudIndeksid.each do |i|       
          voti = headers[i].inner_html()
          if voti.downcase ==  'spc'
            l = rida[i].css("a").first
            vajalikRida[voti] = @baseUrl + l["href"][2..-1]
          else
            clean = (rida[i].inner_html()).split(/[[:space:]]$/) #&nbsp; l6pust ära
            vajalikRida[voti] = clean[0]
          end
        end
        @finalrows.push vajalikRida
      end
      
    end
  end
 
  
end