class RaceIkouBatch
  def self.execute

    count = 0

    # RaceRow.all.each do |racerow|
    @rows = RaceRow.find_by_sql("select * from race_rows where racecd like '2017%'")
    @rows.each do |racerow|
      #レースコード
      racecd = racerow.racecd
      if Race.where(racecd: racecd).size >= 1
        next
      end
      #レース名
      raceName = racerow.name
      if raceName.nil?
        next
      end
      count += 1
      #レース開催日
      kaisaibi = racerow.raceTitle.match(/\d{4}年\d{1,2}月\d{1,2}日/)[0]
      kaisaibi = kaisaibi.gsub(/年/, "/").gsub(/月/, "/").gsub(/日/, "/")
      #開催場所コード
      bashocd = racerow.racecd[4, 2]
      #馬場種類
      babashurui = nil
      if racerow.description[0, 1] =="ダ" then
        babashurui = 0
      elsif racerow.description[0, 1] =="芝" then
        babashurui = 1
      else
        babashurui = 9
      end
      #馬場状態 良:0 稍重:1　重:2 不良:3
      babajoutai = nil
      if racerow.description.index("不良") != nil then
        babajoutai = 3
      elsif racerow.description.index("稍重") != nil then
        babajoutai = 1
      elsif racerow.description.index("重") != nil then
        babajoutai = 2
      elsif racerow.description.index("良") != nil then
        babajoutai = 0
      else
        babajoutai = 9
      end

      #天候 晴:0 曇:1　雨:2
      tenkou = nil
      if racerow.description.index("晴") != nil then
        tenkou = 0
      elsif racerow.description.index("曇") != nil then
        tenkou = 1
      elsif racerow.description.index("雨") != nil then
        tenkou = 2
      else
        tenkou = 9
      end

      #発走時刻
      hassoujikoku = nil
      if racerow.description.match(/\d{2}:\d{2}/) != nil then
        hassoujikoku = racerow.description.match(/\d{2}:\d{2}/)[0]
      end

      #距離
      kyori = racerow.description.match(/\d{4}/)[0]

      #周り
      mawari = nil
      if racerow.description.index("右") != nil then
        mawari = 0
      elsif racerow.description.index("左") != nil then
        mawari = 1
      else
        mawari = 9
      end

      #クラス
      rank = nil
      if racerow.raceDatePlace.index("障害") != nil then
        rank = 99
      elsif racerow.raceDatePlace.index("未勝利") != nil then
        rank = 1
      elsif racerow.raceDatePlace.index("新馬") != nil then
        rank = 1
      elsif racerow.raceDatePlace.index("未出走") != nil then
        rank = 2
      elsif racerow.raceDatePlace.index("オープン") != nil then
        if racerow.name.index("G1") != nil then
          rank = 9
        elsif racerow.name.index("G2") != nil
          rank = 8
        elsif racerow.name.index("G3") != nil
          rank = 7
        else
          rank = 6
        end
      elsif racerow.raceDatePlace.index("1500") != nil then
        rank = 5
      elsif racerow.raceDatePlace.index("1600") != nil then
        rank = 5
      elsif racerow.raceDatePlace.index("1000") != nil then
        rank = 4
      elsif racerow.raceDatePlace.index("900") != nil then
        rank = 4
      elsif racerow.raceDatePlace.index("500") != nil then
        rank = 3
      else
        rank = 99
      end

      race = Race.new(
        racecd: racecd,
        name: raceName,
        kaisaibi: kaisaibi,
        bashocd: bashocd,
        babashurui: babashurui,
        babajoutai: babajoutai,
        tenkou: tenkou,
        hassoujikoku: hassoujikoku,
        kyori: kyori,
        mawari:mawari,
        raceRank: rank
      )
      race.save

    end

    p "[レース情報移行処理]" + count.to_s + "件の登録が完了しました。"
  end
end

RaceIkouBatch.execute
