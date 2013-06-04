# encoding: utf-8
class ReadPdf
  attr_reader :tablerow, :hash_array
 

   
TITLENUMBERS = ["1.", "2.", "3.", "4.", "4.1", "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9", "5.", "5.1", "5.2", "5.3", "6.", "6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "7.", "8.", "9.", "10."]
 
    #@toimeaine = tablerow["Toimeaine"]
    #@atc = tablerow["ATC kood"]
    #@spc = tablerow["SPC"]
  
  def initialize(tablerow) 
    @tablerow = tablerow
    
    @hash_array = {
      :toimeaine => tablerow["Toimeaine"],
      :atc => tablerow["ATC kood"],
      :spc => tablerow["SPC"]
    }
  end
  
  def data
    read_pdf_in
    hashimine
    @hash_array
  end
    
private
  def pdf_files
    @pdf_file ||= "" #kas muutuja sisu või tyhi string
  end
 
  def read_pdf_in
    io = open(tablerow["SPC"])
    reader = PDF::Reader.new(io)
 
    reader.pages.each do |page|
      pagetext = page.text.strip
      #eemalda lk numbrid, kui on
      if !(pagetext =~ /\d{4}$/) #kui lehekylje neli viimast karakterit on digitid, siis ei eemalda: see voib olla aastaarv
         pagetext = pagetext[0..-2]
      end      
      pdf_files.concat(pagetext + "\n\n")# +\n\n: uus lehekylg v6ib alata uue peatykiga, peatykke splititakse kahe reavahetuse jargi
    end#all pages in one text 
  end#method
  
  
  def hashimine 
    # iga eraldi rida läheb massiivi liikmeks
    myPDFarray = pdf_text_lines_into_array 
    #peaks andma ainult pealkirjad kõigist ridadest
    noFailHeaders = no_fail_headers(myPDFarray, TITLENUMBERS)
    #pane pealkirjad ja sisu hashi 
    key = ""
    myPDFarray.each do |line|
      if noFailHeaders.include? line
         if line.start_with?("1.")
             key = :RAVIMPREPARAADI_NIMETUS 
         elsif line.start_with?("2.")
             key = :KOOSTIS
         elsif line.start_with?("3.")
             key = :RAVIMVORM 
         elsif line.start_with?("4.1")
             key = :naidustused 
         elsif line.start_with?("4.2")
             key = :annustamine 
         elsif line.start_with?("4.3")
             key = :vastunaidustused 
         elsif line.start_with?("4.4")
             key = :hoiatused 
         elsif line.start_with?("4.5")
             key = :koostoimed 
         elsif line.start_with?("4.6")
             key = :rasedus 
         elsif line.start_with?("4.7")
             key = :reaktsioonikiirus 
         elsif line.start_with?("4.8")
             key = :korvaltoimed 
         elsif line.start_with?("4.9")
             key = :yleannustamine 
         elsif line.start_with?("5.1")
             key = :farmakodynaamilised 
         elsif line.start_with?("5.2")
             key = :farmakokineetilised 
         elsif line.start_with?("5.3")
             key = :prekliinilised 
         elsif line.start_with?("6.1")
             key = :abiained 
         elsif line.start_with?("6.2")
             key = :sobimatus 
         elsif line.start_with?("6.3")
             key = :kolblikkusaeg 
         elsif line.start_with?("6.4")
             key = :sailitamine 
         elsif line.start_with?("6.5")
             key = :pakendi_iseloomustus 
         elsif line.start_with?("6.6")
             key = :havitamine 
         elsif line.start_with?("7.")
             key = :MYYGILOA_HOIDJA 
         elsif line.start_with?("8.")
             key = :MYYGILOA_NUMBER 
         elsif line.start_with?("9.")
             key = :MYYGILOA_KUUPAEV 
         else
             key = :TEKSTI_LABIVAATAMISE_KUUPAEV  if line.start_with?("10.")
         end
        @hash_array[key] = ""
      else
        #if (!(line.start_with?("4. ")) && !(line.start_with?("5. ")) && !(line.start_with?("6. ") ) )
          @hash_array[key] += line.gsub(/\n/, " ") if !key.empty?
        #end
      end
    end 
  end
  
  def pdf_text_lines_into_array
    #split string into array, eliminate empty rows 
    myPDFarray = pdf_files.split("\n\n").reject {|s| s.empty? || s.length == 1}
    #tyhikud ära eest; ja jarele tyhik juurde, et reavahetusse ei tekiks kokkukirjutatud sonu
    myPDFarray = myPDFarray.map {|a| a.lstrip + " "} #4.5 on alles
  end
  
  def no_fail_headers(myPDFarray, pealkirjade_numbrid)
    #PEALKIRJADE TÖÖTLEMIE
    #nt pealkiri "4.5 Koostoimed teiste ravimitega ja muud koostoimed"
    headersFromPdf = myPDFarray.select {|a| looks_like_title?(a) } #4.5 on alles
    #ara vota pealkirjadeks ridu, kus rea hulgas on numbrite 
    # vahel kaldkriips(dd.mm.yyyy/dd.mm.yyyy) voi punktiga eraldatud kuupaev(dd.mm.yyyy)
    headersFromPdf.select {|s| !(s =~ /\d\/\d/) && !(s =~ /\d{2}\.\d{2}\.\d{4}/)} 
    #headersFromPdf.select {|s|   ( (pealkirjade_numbrid.any? { |w| s[0..4].include? w } )  &&  !(s =~ /\d\/\d/) )   } 
  end
  
  def looks_like_title?(str)
        str =~ /^\d{1,2}\.((\s|\w)|(\d{1,2}(\s|\w)))/
  end
   
end#class
