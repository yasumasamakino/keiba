class CreateRacePays < ActiveRecord::Migration
  def change
    create_table :race_pays do |t|
      t.string :racecd
      t.integer :no
      t.integer :bakenKbn
      t.string :umaban
      t.integer :ninki

      t.timestamps null: false
    end
  end
end
