class AddVersionToPastRaceUmaShisuu < ActiveRecord::Migration
  def change
    add_column :past_race_uma_shisuus, :version, :string
  end
end
