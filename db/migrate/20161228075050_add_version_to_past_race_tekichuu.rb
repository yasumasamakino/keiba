class AddVersionToPastRaceTekichuu < ActiveRecord::Migration
  def change
    add_column :past_race_tekichuus, :version, :string
  end
end
