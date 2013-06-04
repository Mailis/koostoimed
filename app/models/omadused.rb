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
    # Siit alustatakse sama teed, mis täna homecontroller #kuva meetodis.
    # Kui vastava koodiga Omadust ei leita tagastame nil'i, 
    # vastasel kujul Omadus klassi instantsi, millel on kõik viewdes kasutatav andmestik kaasas.
     @atc = atc
     rendertext =""
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
         @toimeaine_info = Omadused.where("atc like ?", @atc.concat("%"))
       
         if @toimeaine_info.empty?
           #kui andmebaasis ei ole, siis vota pdf-st ja salvesta ka baasi
           lisa_uus_omadus
         else
           #kui andmebaasis on, siis peab v6rdlema
           vordle_db_tabeli_kuupaevaga
         end
       end 
         @toimeaine_info = Omadused.where("atc like ?", @atc.concat("%") )
     end 
         @test = {:toimea => @toimeaine_info, :tabeliRidadeArv => @finalrows.length, :errror => rendertext}
  end
  
  
  
      
  def self.veebistlugemise_requirements
    require 'getTable.rb'
    require 'readPdf.rb'  
  end
  #lisa ravimite omaduste tabelisse uued andmed
  def self.lisa_uus_omadus    
    @finalrows.each do |rowhash|
      Omadused.create(ReadPdf.new(rowhash).data)#sulgudes tekib pdf-failist hash(, millest tekitatakse uus omadus)
    end 
  end

  #kas selline atc kood eksisteerib?
  def self.pole_olemas?
    olu = Atc.where("code = ?", @atc).first
    @atc.empty? || olu.nil?
  end 
  
  
   def self.vordle_db_tabeli_kuupaevaga
      #kui andmebaasi tabelivastus ei ole tühi, on vaja v6rrelda kuupaevi
      #kuupaev andmebaasi tabelist
      #tabelirea id ja kuupaev
      #võrdlemiseks on vaja *toimeaine atc koodi, *toimeaine nimetust, *ravimpreparaadi nimetust, *spc linki
      anna_pdf_info_veebist#siin tekib massiiv @pdf_arr_vordlemiseks, kus on veebist leitud padf-ide hashid(key=pealk, value=sisu)
      #v6rdle @pdf_arr_vordlemiseks ja @toimeaine_info (andmebaasist)      
      #PLAAN
      #leia vordsed
      #vordle nende kuupaevi
       # kui erinevad, siis update
      #vordle vordseid pdf-arrayga(seal v6ib olla uusi pdf-dokumente)
       # kui leidub uusi, siis lisa baasi
      kuupaeva_vordlemiseks_vordseid = []
      @pdf_arr_vordlemiseks = @pdf_arr_vordlemiseks.to_a
      if (@pdf_arr_vordlemiseks.count > 0)
        @toimeaine_info.each do |item_baasist|
           @item_baasist = item_baasist
           @pdf_arr_vordlemiseks.each do |item_veebist|
             if vrdl? item_veebist
               kuupaeva_vordlemiseks_vordseid.push item_veebist
             end
           end#@pdf_arr items
        end#@toimeaine_arr items
       
        #vordle kuupaevi: kui on erinevad, update
        if(!kuupaeva_vordlemiseks_vordseid.empty?)
          @toimeaine_info.each do |item_baasist|
            @item_baasist = item_baasist
            kuupaeva_vordlemiseks_vordseid.each do |vordle|
              if vrdl?  vordle
                if item_baasist[:TEKSTI_LABIVAATAMISE_KUUPAEV] != vordle[:TEKSTI_LABIVAATAMISE_KUUPAEV]
                  item_baasist.update_attributes(vordle)
                end
              end
            end
          end
        end
           
        #vordle pdf-array-ga: seal võib olla uusi
        @uued = []
        if(kuupaeva_vordlemiseks_vordseid.count != @pdf_arr_vordlemiseks.count)
           @uued = @pdf_arr_vordlemiseks.select{|s| !kuupaeva_vordlemiseks_vordseid.include? s}
        end
        
        if @uued.count > 0
          @uued.each do |uus|
            Omadused.create(uus)
          end
        end
           
      end#if not empty
        #render :text => testresp + kuupaeva_vordlemiseks_vordseid.count.to_s + " uued: " + @uued.count.to_s 
  end
  
  
  
  def self.anna_urli_tabeli_read
    gl = GetTable.new (@queryurl)
    gl.get_table  
    #iga tabelirea kohta tekib yks pdf dokument;
    # igast pdf dokumendist tekib massiiv, mille elemendid on 
    # hash-id, kus v6ti on pealkiri ja vaartus on pealkirja-alune sisu
    @finalrows=gl.finalrows#read veebilehe tabelist, kus on SPC-lingid, igal real on ATC, toimeaine lad. keeles ja SPC-link PDF-dokumendile
  end
    
 
  
  def self.vrdl? item_veebist
       (@item_baasist[:atc]==item_veebist[:atc]) && 
       (@item_baasist[:toimeaine]==item_veebist[:toimeaine])  &&
       (@item_baasist[:spc]==item_veebist[:spc])
  end

  
  def self.anna_pdf_info_veebist
    @pdf_arr_vordlemiseks = [] 
    @finalrows.each do |rowhash|
      @pdf_arr_vordlemiseks.push (ReadPdf.new(rowhash).data) #pedef.hash_array #iga pdf kohta tekib hash(pealkiri => sisu)
    end 
    @pdf_arr_vordlemiseks
  end
  
  
end
