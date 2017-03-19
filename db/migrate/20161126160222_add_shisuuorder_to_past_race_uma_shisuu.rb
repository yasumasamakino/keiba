class AddShisuuorderToPastRaceUmaShisuu < ActiveRecord::Migration
  def change
    add_column :past_race_uma_shisuus, :shisuuOrder, :integer
  end
end
