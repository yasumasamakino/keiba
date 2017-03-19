class ChangeRentairitsuRentaiPropToString < ActiveRecord::Migration
  def change
    change_column :rentairitsus, :rentaiProp, :string
  end
end
