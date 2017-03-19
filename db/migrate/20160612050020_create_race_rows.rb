class CreateRaceRows < ActiveRecord::Migration
  def change
    create_table :race_rows do |t|
      t.string :racecd
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
