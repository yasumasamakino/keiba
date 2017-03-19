class AddIndexRaceToUmacd < ActiveRecord::Migration
  def change
    add_index :race_results, :umaCd
  end
end
