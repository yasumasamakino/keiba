class AddRacerankToRaces < ActiveRecord::Migration
  def change
    add_column :races, :raceRank, :integer
  end
end
