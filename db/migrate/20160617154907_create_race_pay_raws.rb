class CreateRacePayRaws < ActiveRecord::Migration
  def change
    create_table :race_pay_raws do |t|
      t.string :racecd
      t.string :bakenName
      t.string :umaban
      t.string :pay
      t.string :ninki

      t.timestamps null: false
    end
  end
end
