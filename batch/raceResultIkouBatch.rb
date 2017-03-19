class RaceResultIkouBatch
  def self.execute

    count = 0

    # RaceResultRaw.find_each(batch_size: 10000) do |row|
    @rows = RaceResultRaw.find_by_sql("select * from race_result_raws where racecd like '2017%'")
    @rows.each do |row|

      #レースコード
      racecd = row.racecd
      #馬コード
      umaCd = nil
      if row.umaurl != nil then
        umaCd = row.umaurl.delete("^0-9")
      end
      if RaceResult.where(racecd: racecd).where(umaCd: umaCd).size >= 1
        next
      end

      #着順
      chakujun = row.chakujun
      if chakujun.nil?
        next
      end

      count += 1

      #枠番
      wakuban = row.wakuban
      #馬番
      umaban = row.umaban
      #性 0:牡 1:牝 2:セン
      sei = nil
      if row.seirei[0, 1] =="牡" then
        sei = 0
      elsif row.seirei[0, 1] =="牝" then
        sei = 1
      elsif row.seirei[0, 1] =="セ" then
        sei = 2
      else
        sei = 9
      end
      #齢
      rei = nil
      if row.seirei != nil then
        rei = row.seirei.delete("^0-9")
      end
      #斤量
      kinryou = row.kinryou
      #騎手コード
      kishuCd = nil
      if row.kishuurl != nil then
        kishuCd = row.kishuurl.delete("^0-9")
      end
      #タイム
      time = row.time
      #タイム(秒)
      timeSecond = nil
      if row.time != nil then
        timeSecond = row.time[0,1].to_f * 60 +  row.time[2,2].to_f + row.time[5,1].to_f/10
      end
      #着差
      chakusa = row.chakusa
      #上がり
      agari = row.agari
      #単勝オッズ
      tanshou = row.tanshou
      #単勝オッズ
      ninki = row.ninki
      #馬体重
      bataijuu = row.bataijuu[0, 3]
      #増減
      zougen = nil
      if row.bataijuu[4, 10] != nil then
        zougen = row.bataijuu[4, 10].chop
      end
      #調教師コード
      choukyoushiCd = nil
      if row.choukyoushiurl != nil then
        choukyoushiCd = row.choukyoushiurl.delete("^0-9")
      end
      #馬主コード
      banushiCd = nil
      if row.banushiurl != nil then
        banushiCd = row.banushiurl.delete("^0-9")
      end
      #通過
      tsuuka = row.tsuuka

      raceResult = RaceResult.new(
        racecd: racecd,
        chakujun: chakujun,
        wakuban: wakuban,
        umaban: umaban,
        umaCd: umaCd,
        sei: sei,
        rei: rei,
        kinryou: kinryou,
        kishuCd: kishuCd,
        time: time,
        chakusa: chakusa,
        agari: agari,
        tanshou: tanshou,
        ninki: ninki,
        bataijuu: bataijuu,
        zougen: zougen,
        choukyoushiCd: choukyoushiCd,
        banushiCd: banushiCd,
        tsuuka: tsuuka,
        timeSecond: timeSecond
      )
      raceResult.save

    end
    p "[レース結果移行処理]" + count.to_s + "件の登録が完了しました。"
  end
end

RaceResultIkouBatch.execute
