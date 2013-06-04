class CreateAtcs < ActiveRecord::Migration
  def change
    create_table :atcs do |t|
      t.string :code
      t.string :nimetus_est
      t.string :nimetus_eng

      t.timestamps
    end
  end
end
