class CreateKaishuuritsus < ActiveRecord::Migration
  def change
    create_table :kaishuuritsus do |t|
      t.string :name
      t.string :rentaiProp
      t.float :rentai

      t.timestamps null: false
    end
  end
end
