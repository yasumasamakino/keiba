rails runner batch/hello_batch.rb
rails runner batch/raceIkouBatch.rb
rails runner batch/raceResultIkouBatch.rb
rails runner batch/rentaibaTsuukaCalcBatch.rb
rails runner batch/racePayIkouBatch.rb
rails runner batch/getBloedBatch.rb

mysql -ukeiba -pkeiba keiba_development < sql/calc_racetousuu.sql
mysql -ukeiba -pkeiba keiba_development < sql/calc_hensa.sql
mysql -ukeiba -pkeiba keiba_development < sql/calc_hensa_agari.sql
mysql -ukeiba -pkeiba keiba_development < sql/calc_rentairitsu_3.sql
mysql -ukeiba -pkeiba keiba_development < sql/calc_kaishuuritsu.sql
