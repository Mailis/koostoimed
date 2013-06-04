# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130523120139) do

  create_table "atcs", :force => true do |t|
    t.string   "code"
    t.string   "nimetus_est"
    t.string   "nimetus_eng"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "omaduseds", :force => true do |t|
    t.string   "toimeaine"
    t.string   "atc"
    t.string   "spc"
    t.text     "RAVIMPREPARAADI_NIMETUS"
    t.text     "KOOSTIS"
    t.text     "RAVIMVORM"
    t.text     "naidustused"
    t.text     "annustamine"
    t.text     "vastunaidustused"
    t.text     "hoiatused"
    t.text     "koostoimed"
    t.text     "rasedus"
    t.text     "reaktsioonikiirus"
    t.text     "korvaltoimed"
    t.text     "yleannustamine"
    t.text     "farmakodynaamilised"
    t.text     "farmakokineetilised"
    t.text     "prekliinilised"
    t.text     "abiained"
    t.text     "sobimatus"
    t.text     "kolblikkusaeg"
    t.text     "sailitamine"
    t.text     "pakendi_iseloomustus"
    t.text     "havitamine"
    t.text     "MYYGILOA_HOIDJA"
    t.text     "MYYGILOA_NUMBER"
    t.text     "MYYGILOA_KUUPAEV"
    t.text     "TEKSTI_LABIVAATAMISE_KUUPAEV"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

end
