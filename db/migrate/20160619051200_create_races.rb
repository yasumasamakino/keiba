class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :racecd
      t.string :name
      t.date :kaisaibi
      t.string :bashocd
      t.integer :babashurui
      t.integer :babajoutai
      t.integer :tenkou
      t.time :hassoujikoku
      t.integer :kyori
      t.integer :mawari

      t.timestamps null: false
    end
  end
end
