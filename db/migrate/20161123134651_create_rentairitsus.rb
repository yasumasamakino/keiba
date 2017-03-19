class CreateRentairitsus < ActiveRecord::Migration
  def change
    create_table :rentairitsus do |t|
      t.string :name
      t.integer :rentaiProp
      t.float :rentai

      t.timestamps null: false
    end
  end
end
