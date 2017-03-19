class CreatePastRaceTekichuus < ActiveRecord::Migration
  def change
    create_table :past_race_tekichuus do |t|
      t.string :racecd

      t.timestamps null: false
    end
  end
end
