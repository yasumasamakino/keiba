class AddBabashuruiToRentaibaTsuukas < ActiveRecord::Migration
  def change
    add_column :rentaiba_tsuukas, :babashurui, :integer
  end
end
