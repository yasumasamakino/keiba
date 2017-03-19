class CreateRaceResultAvgtimes < ActiveRecord::Migration
  def change
    create_table :race_result_avgtimes do |t|
      t.string :bashocd
      t.integer :kyori
      t.integer :raceRank
      t.string :babashurui
      t.string :raceCnt
      t.float :timeSecondAvg

      t.timestamps null: false
    end
  end
end
