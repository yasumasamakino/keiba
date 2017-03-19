class AddRentairitsuToPastRaceUmaShisuu < ActiveRecord::Migration
  def change
    add_column :past_race_uma_shisuus, :fatherRt, :float
    add_column :past_race_uma_shisuus, :bloedsScore, :integer
    add_column :past_race_uma_shisuus, :speedHensa, :float
    add_column :past_race_uma_shisuus, :agariHensa, :float
  end
end
