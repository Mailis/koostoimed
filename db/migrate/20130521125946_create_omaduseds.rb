class CreateOmaduseds < ActiveRecord::Migration
  def change
    create_table :omaduseds do |t|
      t.string :toimeaine
      t.string :atc
      t.string :spc
      t.text :RAVIMPREPARAADI_NIMETUS
      t.text :KOOSTIS
      t.text :RAVIMVORM
      t.text :naidustused
      t.text :annustamine
      t.text :vastunaidustused
      t.text :hoiatused
      t.text :koostoimed
      t.text :rasedus
      t.text :reaktsioonikiirus
      t.text :korvaltoimed
      t.text :yleannustamine
      t.text :farmakodynaamilised
      t.text :farmakokineetilised
      t.text :prekliinilised
      t.text :abiained
      t.text :sobimatus
      t.text :kolblikkusaeg
      t.text :sailitamine
      t.text :pakendi_iseloomustus
      t.text :havitamine
      t.text :MYYGILOA_HOIDJA
      t.text :MYYGILOA_NUMBER
      t.text :MYYGILOA_KUUPAEV
      t.text :TEKSTI_LABIVAATAMISE_KUUPAEV

      t.timestamps
    end
  end
end
