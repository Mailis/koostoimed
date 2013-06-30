# encoding: utf-8
class Omadused < ActiveRecord::Base 

 validates :atc,  :presence => true
 validates :spc, :uniqueness => true
  attr_accessible :KOOSTIS, :MYYGILOA_HOIDJA, :MYYGILOA_KUUPAEV, :MYYGILOA_NUMBER, :RAVIMPREPARAADI_NIMETUS, :RAVIMVORM, :TEKSTI_LABIVAATAMISE_KUUPAEV, :abiained, :annustamine, :atc, :farmakodynaamilised, :farmakokineetilised, :havitamine, :hoiatused, :kolblikkusaeg, :koostoimed, :korvaltoimed, :naidustused, :pakendi_iseloomustus, :prekliinilised, :rasedus, :reaktsioonikiirus, :sailitamine, :sobimatus, :spc, :toimeaine, :vastunaidustused, :yleannustamine
 TITLES = {:toimeaine  =>  'Toimeaine' ,
:atc  =>  'ATC kood' ,
:spc  =>  'SPC' ,
:RAVIMPREPARAADI_NIMETUS  =>  '1. RAVIMPREPARAADI NIMETUS' ,
:KOOSTIS  =>  '2. KVALITATIIVNE JA KVANTITATIIVNE KOOSTIS' ,
:RAVIMVORM  =>  '3. RAVIMVORM' ,
:naidustused  =>  '4.1 Näidustused (4. KLIINILISED ANDMED)' ,
:annustamine  =>  '4.2 Annustamine ja manustamisviis (4. KLIINILISED ANDMED)' ,
:vastunaidustused  =>  '4.3 Vastunäidustused (4. KLIINILISED ANDMED)' ,
:hoiatused  =>  '4.4 Hoiatused ja ettevaatusabinõud kasutamisel (4. KLIINILISED ANDMED)' ,
:koostoimed  =>  '4.5 Koostoimed teiste ravimitega ja muud koostoimed (4. KLIINILISED ANDMED)' ,
:rasedus  =>  '4.6 Rasedus ja imetamine (4. KLIINILISED ANDMED)' ,
:reaktsioonikiirus  =>  '4.7 Toime reaktsioonikiirusele (4. KLIINILISED ANDMED)' ,
:korvaltoimed  =>  '4.8 Kõrvaltoimed (4. KLIINILISED ANDMED)' ,
:yleannustamine  =>  '4.9 Üleannustamine (4. KLIINILISED ANDMED)' ,
:farmakodynaamilised  =>  '5.1 Farmakodünaamilised omadused (5. FARMAKOLOOGILISED OMADUSED)' ,
:farmakokineetilised  =>  '5.2 Farmakokineetilised omadused (5. FARMAKOLOOGILISED OMADUSED)' ,
:prekliinilised  =>  '5.3 Prekliinilised ohutusandmed (5. FARMAKOLOOGILISED OMADUSED)' ,
:abiained  =>  '6.1 Abiainete loetelu (6. FARMATSEUTILISED ANDMED)' ,
:sobimatus  =>  '6.2 Sobimatus (6. FARMATSEUTILISED ANDMED)' ,
:kolblikkusaeg  =>  '6.3 Kõlblikkusaeg (6. FARMATSEUTILISED ANDMED)' ,
:sailitamine  =>  '6.4 Säilitamise eritingimused (6. FARMATSEUTILISED ANDMED)' ,
:pakendi_iseloomustus  =>  '6.5 Pakendi iseloomustus ja sisu (6. FARMATSEUTILISED ANDMED)' ,
:havitamine  =>  '6.6 Erinõuded hävitamiseks (6. FARMATSEUTILISED ANDMED)' ,
:MYYGILOA_HOIDJA  =>  '7. MÜÜGILOA HOIDJA' ,
:MYYGILOA_NUMBER  =>  '8. MÜÜGILOA NUMBER' ,
:MYYGILOA_KUUPAEV  =>  '9. ESMASE MÜÜGILOA VÄLJASTAMISE / MÜÜGILOA UUENDAMISE KUUPÄEV' ,
:TEKSTI_LABIVAATAMISE_KUUPAEV  =>  '10. TEKSTI LÄBIVAATAMISE KUUPÄEV'
        }
        
  def title(key)#seda kasutab kuva.html
    TITLES[key].to_s
  end  
  
  def self.fetch(atc)
    rendertext = ""
    # Siit alustatakse sama teed, mis täna homecontroller #kuva meetodis.
    # Kui vastava koodiga Omadust ei leita tagastame nil'i, 
    # vastasel kujul Omadus klassi instantsi, millel on kõik viewdes kasutatav andmestik kaasas.
     @atc = atc
     @toimeaine_info_baasist = []
     if pole_olemas?
       rendertext = atc + ": sellist toimeainet ei ole!"
     else
       #url, millele tuleb lisada atc
       @basicurl = "http://193.40.10.165/register/register.php?otsi=J&keel=est&atc="
       #url, millega kysitakse pdf-e ravimiameti veebilehelt
       @queryurl = @basicurl + atc
       #veebist ja pdf-ist lugemise requirements:
       veebistlugemise_requirements 
       anna_urli_tabeli_read#siin tekib @finalrows ehk url-ist leitud tabeliread(toimeaine, atc ja spc link)
       if @finalrows.empty?#kui veebi-tulemus on tyhi
         rendertext = "Toimeaine \"" + @atc + "\" omadusi pole saadaval või on vaja täpsemat ATC koodi."
       else
         #selle toimeaine kohta k2ivad read andmebaasist
         @toimeaine_info_baasist = Omadused.where("atc like ?", @atc.concat("%"))
         toimeaine_info_veebist = anna_pdf_info_veebist
         
         # spc lingid baasist (v6rdlemiseks)
         spc_links_baasist = []
         @toimeaine_info_baasist.each do |baasilink|
           spc_links_baasist.push baasilink.spc
         end
         
         kasM6ndaRidaUuendati = 0
         
         toimeaine_info_veebist.each do |veebitem|
           spc_link_veebist = veebitem[:spc]           
           
           #kui baasis ei ole sellist spc-linki, siis lisada uus rida
           if !(spc_links_baasist.include? spc_link_veebist)
           begin
             Omadused.create(veebitem)
           rescue Exception=>e
              rendertext =  e
           end
             
             kasM6ndaRidaUuendati = 1
           else
             #sama link on baasis olemas, vaata kas kuupaev on uuenenud
             veebi_kuupaev = veebitem[:TEKSTI_LABIVAATAMISE_KUUPAEV]
             @toimeaine_info_baasist.each do |baasi_rida|
                if (baasi_rida.spc == spc_link_veebist)#kontrolli yhte kindlat rida
                  if ( veebi_kuupaev != baasi_rida.TEKSTI_LABIVAATAMISE_KUUPAEV)
                    #kuupaevad on erinevad, vaja update-da
                    baasi_rida.update_attributes(veebitem)
                    kasM6ndaRidaUuendati = 1
                  end
                end
             end
           end
         end
         
       end 
       if(kasM6ndaRidaUuendati == 1)
           #varskendatud info baasist
           @toimeaine_info_baasist = Omadused.where("atc like ?", @atc.concat("%") ).order(:atc)
       end
     end 
         {:toimea => @toimeaine_info_baasist, :tabeliRidadeArv => @toimeaine_info_baasist.length, :errror => rendertext}
  end
  
  
  
      
  def self.veebistlugemise_requirements
    require 'getTable.rb'
    require 'readPdf.rb'  
  end
 
  #kas selline atc kood eksisteerib?
  def self.pole_olemas?
    olu = Atc.where("code = ?", @atc).first
    @atc.empty? || olu.nil?
  end 
  

  
  def self.anna_urli_tabeli_read
    gl = GetTable.new (@queryurl)
    gl.get_table  
    #iga tabelirea kohta tekib yks pdf dokument;
    # igast pdf dokumendist tekib massiiv, mille elemendid on 
    # hash-id, kus v6ti on pealkiri ja vaartus on pealkirja-alune sisu
    @finalrows=gl.finalrows#read veebilehe tabelist, kus on SPC-lingid, igal real on ATC, toimeaine lad. keeles ja SPC-link PDF-dokumendile
  end
    

  
  def self.anna_pdf_info_veebist
    @pdf_arr_vordlemiseks = [] 
    @finalrows.each do |rowhash|
      @pdf_arr_vordlemiseks.push (ReadPdf.new(rowhash).data) #pedef.hash_array #iga pdf kohta tekib hash(pealkiri => sisu)
    end 
    @pdf_arr_vordlemiseks
  end


#TEXT PROCESSING METHODS
  def process(text)
    textarray = text.split('. ') 
    
    result_array = []    
    textarray.each do |str|
      result_array.push (str + ". ") if str != ""
    end
    result_array
  end
  
  def processCapital(text)
    textarray = text.split(/([A-Z]{1}+)|(Õ+)|(Ä+)|(Ö+)|(Ü+)/)
    
    result_array = []
    if(textarray[0] == "")
      textarray.each_with_index {|item, index|
      
         if (index.odd?)
           next_element = textarray[index+1]
           result_array.push (item + next_element)
         end
      }
 
    else
      textarray.each_with_index {|item, index|
         if (index.even?)
            if (index+1 < textarray.length)
              next_element = textarray[index+1]
              result_array.push (item + next_element)
            end
         end
      }
    end
    result_array
  end
  
  def processsulud(text)
    textarray = text.split(/(\s[a-z]{1}\))/)    
    result_array = []   
    
      textarray.each_with_index {|item, index|  
         next_element = textarray[index+1]    
         if (item.length < 4)
             result_array.push (item + next_element + textarray[index+1])
         else
           result_array.push item if index == 0
         end
      }
    result_array
  end
  
    
  def processKriipsTaht(text)
    textarray = text.split("-")  
    result_array = []    
    textarray.each do |str|
      result_array.push "-" + str if str != ""
    end
    result_array
  end

  
end
