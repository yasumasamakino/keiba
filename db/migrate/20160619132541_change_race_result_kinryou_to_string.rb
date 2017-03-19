class ChangeRaceResultKinryouToString < ActiveRecord::Migration
  def change
    change_column :race_result_raws, :kinryou, :string
  end
end
