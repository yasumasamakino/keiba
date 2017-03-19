class CreateHorseHensaAgariValues < ActiveRecord::Migration
  def change
    create_table :horse_hensa_agari_values do |t|
      t.string :umaCd
      t.string :racecd
      t.integer :kyori
      t.string :babashurui
      t.float :speed

      t.timestamps null: false
    end
  end
end
