class CreatePastRaceUmaShisuus < ActiveRecord::Migration
  def change
    create_table :past_race_uma_shisuus do |t|
      t.string :racecd
      t.integer :chakujun
      t.float :shisuu

      t.timestamps null: false
    end
  end
end
