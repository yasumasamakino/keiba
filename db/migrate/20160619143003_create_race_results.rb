class CreateRaceResults < ActiveRecord::Migration
  def change
    create_table :race_results do |t|
      t.string :racecd
      t.integer :chakujun
      t.integer :wakuban
      t.integer :umaban
      t.string :umaCd
      t.integer :sei
      t.integer :rei
      t.float :kinryou
      t.string :kishuCd
      t.string :time
      t.string :chakusa
      t.float :agari
      t.float :tanshou
      t.integer :ninki
      t.integer :bataijuu
      t.integer :zougen
      t.string :choukyoushiCd
      t.string :banushiCd
      t.string :tsuuka

      t.timestamps null: false
    end
  end
end
