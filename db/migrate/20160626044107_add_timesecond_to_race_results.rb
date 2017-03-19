class AddTimesecondToRaceResults < ActiveRecord::Migration
  def change
    add_column :race_results, :timeSecond, :float
  end
end
