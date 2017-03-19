class CreateRentaibaTsuukas < ActiveRecord::Migration
  def change
    create_table :rentaiba_tsuukas do |t|
      t.string :umaCd
      t.string :racecd
      t.integer :no
      t.integer :position

      t.timestamps null: false
    end
  end
end
