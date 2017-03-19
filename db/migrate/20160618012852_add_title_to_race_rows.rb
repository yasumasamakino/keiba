class AddTitleToRaceRows < ActiveRecord::Migration
  def change
    add_column :race_rows, :raceTitle, :string
    add_column :race_rows, :raceDatePlace, :string
  end
end
