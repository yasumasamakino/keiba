class AddIndexRacecd < ActiveRecord::Migration
  def change
   add_index :race_results, :racecd
   add_index :races, :racecd
  end
end
