class AddPayToRacePay < ActiveRecord::Migration
  def change
    add_column :race_pays, :pay, :integer
  end
end
