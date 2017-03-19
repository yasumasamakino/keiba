class AddChakujunToRentaibaTsuukas < ActiveRecord::Migration
  def change
    add_column :rentaiba_tsuukas, :chakujun, :integer
  end
end
