# encoding: utf-8
require 'pdf-reader'
require 'nokogiri'   
require 'open-uri' 
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ATC KOODID JA NENDE EESTI_ JA INGLISEKEELSED NIMETUSED BAASI (tehtud)
# require 'read_atc_txt.rb' 
# Atc.delete_all
# filename = "atc_hum.txt"
# a = ATChum.new filename 
# a.atc_hum.each do |rida|
#   Atc.create(rida)
# end 

Omadused.delete_all
# tegelikud vigadeta pealkirjad
Omadused.create(
:toimeaine  =>  'Toimeaine' ,
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
)












