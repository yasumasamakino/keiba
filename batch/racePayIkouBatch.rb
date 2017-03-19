class RacePayDb
  class << self
    def register(racecd, bakenKbn, umaban, ninki ,pay)

      no = 1

      racePay = RacePay.new(
        racecd: racecd,
        no: no,
        bakenKbn: bakenKbn,
        umaban: umaban,
        ninki: ninki,
        pay: pay
      )
      racePay.save
    end
    def arrayRegister(racecd, bakenKbn, umaban, ninki ,pay)

      if umaban == nil ||
        ninki == nil ||
        pay == nil
      then
        return
      end

      umabanArray = umaban.split("|")
      payArray = pay.split("|")
      ninkiArray = ninki.split("|")

      if umabanArray.count != payArray.count || umabanArray.count != ninkiArray.count then
        return
      end

      no = 1
      roopCnt = 0
      for ub in umabanArray do
        racePay = RacePay.new(
          racecd: racecd,
          no: no,
          bakenKbn: bakenKbn,
          umaban: ub,
          ninki: ninkiArray[roopCnt],
          pay: payArray[roopCnt].delete("^0-9").to_i
        )
        racePay.save

        roopCnt += 1
        no += 1
      end

      return
    end
  end
end

class RacePayIkouBatch
  def self.execute

    roopCnt = 0
    # RacePayRaw.find_each(batch_size: 10000) do |racePayRaw|
    @racePayRaw = RacePayRaw.find_by_sql("select * from race_pay_raws where racecd like '2017%' ")
    @racePayRaw.each do |racePayRaw|

      no = 1
      umaban = nil
      ninki = 0
      pay = 0
      bakenKbn = 0

      if racePayRaw.bakenName == '単勝' then
        bakenKbn = 1
      elsif racePayRaw.bakenName == '枠連' then
        bakenKbn = 2
      elsif racePayRaw.bakenName == '複勝' then
        bakenKbn = 3
      elsif racePayRaw.bakenName == '馬単' then
        bakenKbn = 4
      elsif racePayRaw.bakenName == '馬連' then
        bakenKbn = 5
      elsif racePayRaw.bakenName == 'ワイド' then
        bakenKbn = 6
      elsif racePayRaw.bakenName == '三連単' then
        bakenKbn = 7
      elsif racePayRaw.bakenName == '三連複' then
        bakenKbn = 8
      end

      if RacePay.where(racecd: racePayRaw.racecd).where(bakenKbn: bakenKbn).size >= 1
        next
      end

      RacePayDb.arrayRegister(racePayRaw.racecd, bakenKbn, racePayRaw.umaban, racePayRaw.ninki ,racePayRaw.pay)

      roopCnt += 1

    end

  end
end

RacePayIkouBatch.execute
