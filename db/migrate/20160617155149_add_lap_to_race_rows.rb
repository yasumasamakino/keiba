class AddLapToRaceRows < ActiveRecord::Migration
  def change
    add_column :race_rows, :lap, :string
    add_column :race_rows, :pacd, :string
  end
end
