class CreateRaceResultRaws < ActiveRecord::Migration
  def change
    create_table :race_result_raws do |t|
      t.string :racecd
      t.integer :chakujun
      t.integer :wakuban
      t.integer :umaban
      t.text :umaurl
      t.text :bamei
      t.text :seirei
      t.integer :kinryou
      t.text :kishu
      t.text :kishuurl
      t.text :time
      t.text :chakusa
      t.text :tsuuka
      t.text :agari
      t.text :tanshou
      t.integer :ninki
      t.text :bataijuu
      t.text :choukyoushi
      t.text :choukyoushiurl
      t.text :banushi
      t.text :banushiurl
      t.timestamps null: false
    end
  end
end
