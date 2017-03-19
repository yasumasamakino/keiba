class CreateRaceTousuus < ActiveRecord::Migration
  def change
    create_table :race_tousuus do |t|
      t.string :racecd
      t.integer :tousuu

      t.timestamps null: false
    end
  end
end
