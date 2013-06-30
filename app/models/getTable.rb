require 'getTable.rb'
class GetTable
  attr_accessor :url, :baseUrl, :finalrows
  
  def initialize url 
    @url = url
    @baseUrl = "http://193.40.10.165"
    @finalrows = []  
  end    


  def get_table
    page = Nokogiri::HTML(open(url))
    links = page.css("a")
    @spc_item = nil
    links.each do |item|
      if item.inner_html.downcase == "spc"
        @spc_item = item
        break
      end
    end
    
    if (!@spc_item.nil?)#kui leidus lingiga rida
      tabel = @spc_item.ancestors('table').first
      rows_with_spaces = tabel.children 
      rows = []
      #tabeliridade elementide vahel on palju tyhje text-node, eemaldada
      rows_with_spaces.each do |x|
        cleanrow = x.children.select{|z| z.type() == 1} 
        rows.push cleanrow
      end
    
      if rows.count > 1#esimene rida on 'table headers', kui rohkem ridu pole, ongi ainult 1 rida
        #kysi ainult neid reaelemente(veerge), kus on toimeaine nimetus, atc ja pdf asukoht
        @finalrows = get_only_needed_columns (rows)
      end
    end
  end
  
  
  def get_only_needed_columns (rows)
    headers = rows[0] #tabeli veergude pealkirjad
    rows = rows.drop(1) #viska headersite rida minema
    #spc indexit on vaja siis, kui on vaja kontrolida, kas tabeli m6nes reas pole SPC-link puudu
    spcIndex = 6
    # leia ridadest vajalike elementide (veergude) indeksid
    vajalikudIndeksid = []      
    headers.each do |th|
        col = th.inner_html.downcase
        if ((col.include? 'toime') || (col.include? 'atc') || (col =='spc'))
           vajalikudIndeksid.push headers.index(th)
           spcIndex = headers.index(th) if col =='spc'
        end
    end # headers.each
    #eemalda mittevajalikud veerud
    rows_with_needed_columns = []
    
    rows.each do |rida|
       # vaja kontrolida, kas tabeli m6nes reas pole SPC-link puudu
       if(rida[spcIndex].inner_html.include? "<a")
         needed_row_elements = {}
         
         rida.each do |column|
          index_of_column = rida.index(column)
            if (vajalikudIndeksid.include? index_of_column)
              #col_header on key (toimeine, atc v6i spc)
              col_header = headers[index_of_column].inner_html.split(/[[:space:]]$/)[0]
              if col_header.downcase == 'spc'
                needed_row_elements[col_header] = process_spc_link (rida[index_of_column])
              else
                #&nbsp; l6pust ära
                value_without_space_at_end = (column.inner_html).split(/[[:space:]]$/)[0]
                needed_row_elements[col_header] = value_without_space_at_end
              end
           end#if (vajalikudIndeksid...
         end#rida.each do ...
         
         rows_with_needed_columns.push needed_row_elements
       end#if(rida[spcIndex].inner_html.include? "<a")
    end#rows.each do |rida|
    #tagasta vajalike veergudega read    
    rows_with_needed_columns
  end
  
  
  def process_spc_link (spc_link_element)
      spc_link = (spc_link_element.css("a").first)["href"]
      if spc_link.include? "../"
        pdf_address = @baseUrl + spc_link[2..-1]
      else
        pdf_address = spc_link
      end
  end
  
  
end 
  
