class RentaibaTsuukaCalcBatch
  def self.execute

    offset = 0
    limit = 100000

    while 1 < 2 do
      # @tsuukaRows = RaceResult.find_by_sql("select a.racecd, a.umaCd, a.tsuuka, a.chakujun ,b.babashurui from race_results a join races b on a.racecd = b.racecd and raceRank and b.kaisaibi >= '2016/01/01' ")
      # sql = "select a.racecd, a.umaCd, a.tsuuka, a.chakujun ,b.babashurui from race_results a join races b on a.racecd = b.racecd limit {$offset}, {$limit}"
      sql = "select a.racecd, a.umaCd, a.tsuuka, a.chakujun ,b.babashurui from race_results a join races b on a.racecd = b.racecd where b.kaisaibi >= '2017/01/01' limit {$offset}, {$limit}"
      sql = sql.sub!("{$offset}", offset.to_s)
      sql = sql.sub!("{$limit}", limit.to_s)

      @tsuukaRows = RaceResult.find_by_sql(sql)
      if @tsuukaRows.count == 0 then
        break
      end

      @tsuukaRows.each do |tsuukaRow|

        if RentaibaTsuuka.where(racecd:tsuukaRow.racecd).where(umaCd: tsuukaRow.umaCd).count > 0 then
          next
        end
        tsuukaArray = {}
        tsuukaArray = tsuukaRow.tsuuka.split("-")
        rowCnt = tsuukaArray.count
        for tsuuka in tsuukaArray do
          rentaibaTsuuka = RentaibaTsuuka.new(
            umaCd: tsuukaRow.umaCd,
            racecd: tsuukaRow.racecd,
            no: rowCnt,
            position: tsuuka,
            chakujun: tsuukaRow.chakujun,
            babashurui: tsuukaRow.babashurui
          )
          rentaibaTsuuka.save
          rowCnt = rowCnt -1
        end
      end
      offset = offset + limit
    end
  end
end

RentaibaTsuukaCalcBatch.execute
