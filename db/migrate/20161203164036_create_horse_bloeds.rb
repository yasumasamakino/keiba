class CreateHorseBloeds < ActiveRecord::Migration
  def change
    create_table :horse_bloeds do |t|
      t.string :umaCd
      t.integer :sedai
      t.integer :parentKbn
      t.string :bloedUmaCd

      t.timestamps null: false
    end
  end
end
