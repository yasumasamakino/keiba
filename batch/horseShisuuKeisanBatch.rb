# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

require "date"

class Calculation
 class << self
  # def chakusaScoreCalc(score, sabunTimeSecond, addValue)
  #   if sabunTimeSecond < 0.1 then
  #     return score += 9
  #   elsif sabunTimeSecond == 0.1 then
  #     return score += 8
  #   else
  #     return score += addValue
  #   end
  #
  # end
  def chakusaScoreCalc(score, sabunTimeSecond, subValue)
    if sabunTimeSecond < 0.1 then
      return score
    elsif sabunTimeSecond >= 0.1 && sabunTimeSecond < 0.2 then
      return score - (subValue /3).round(4)
    elsif sabunTimeSecond >= 0.2 && sabunTimeSecond < 0.3 then
      return score - (subValue /2).round(4)
    else
      return score - subValue
    end

  end
  # def chakujunScore(chakujun, tousuu, raceRank, raceCount, thisRaceRank, sabunTimeSecond, rei, kobaFlag)
  #
  #   score = 100
  #
  #   if chakujun == 1 then
  #     score += 6
  #     if kobaFlag == true then
  #       score += 3
  #     end
  #   elsif chakujun == 2 then
  #     score = chakusaScoreCalc(score, sabunTimeSecond, 7)
  #     if kobaFlag == true then
  #       score += 2
  #     end
  #   elsif chakujun == 3 then
  #     score = chakusaScoreCalc(score, sabunTimeSecond, 6)
  #     if kobaFlag == true then
  #       score += 1
  #     end
  #   elsif chakujun == 4 then
  #     score = chakusaScoreCalc(score, sabunTimeSecond, 5)
  #     # if kobaFlag == true then
  #     #   score += 2
  #     # end
  #   elsif chakujun == 5 then
  #     score = chakusaScoreCalc(score, sabunTimeSecond, 4)
  #     # if kobaFlag == true then
  #     #   score += 2
  #     # end
  #   elsif chakujun == 6 then
  #     score = chakusaScoreCalc(score, sabunTimeSecond, 3)
  #   elsif chakujun == 7 then
  #     score = chakusaScoreCalc(score, sabunTimeSecond, 2)
  #   elsif chakujun == 8 then
  #     score = chakusaScoreCalc(score, sabunTimeSecond, 1)
  #   end
  #
  #   #レース頭数でボーナス
  #   #14頭立て以上で掲示板ならボーナス
  #   if chakujun <= 5 then
  #     if tousuu >= 14 then
  #       score = score * 1.1
  #     elsif tousuu < 10 then
  #       score = score * 0.9
  #     end
  #   end
  #
  #   #過去のレースで今回のレースより格上を走っているか
  #   raceRankDif = raceRank - thisRaceRank
  #
  #   #レースランクボーナス
  #   if chakujun <= 8 then
  #     if raceRankDif == 1 then
  #       score = score * 1.1
  #     elsif raceRankDif == 2 then
  #       score = score * 1.2
  #     elsif raceRankDif == 3 then
  #       score = score * 1.3
  #     elsif raceRankDif == 4 then
  #       score = score * 1.4
  #     elsif raceRankDif == 5 then
  #       score = score * 1.5
  #     elsif raceRankDif == 6 then
  #       score = score * 1.6
  #     elsif raceRankDif == 7 then
  #       score = score * 1.7
  #     elsif raceRankDif == 8 then
  #       score = score * 1.8
  #     end
  #
  #     #前走ならボーナス
  #     if raceCount == 1 then
  #       score = score * 1.1
  #     #2前走ならちょっとボーナス
  #     elsif raceCount == 2 then
  #       score = score * 1.05
  #     #2前前走ならちょっとボーナス
  #     elsif raceCount == 3 then
  #       score = score * 1.03
  #     end
  #
  #   end
  #
  #   return score
  #
  # end

  def chakujunScore(chakujun, tousuu, raceRank, raceCount, thisRaceRank, sabunTimeSecond, rei, kobaFlag)

    score = 1

    raceScore = (score.to_f / tousuu.to_f).round(4)
    if chakujun == 1 then
      # score += 6
    elsif chakujun == 2 then
      score = chakusaScoreCalc(score, sabunTimeSecond, raceScore)
    else
      score = chakusaScoreCalc(score, sabunTimeSecond, (raceScore*(chakujun-1) ) )
    end

    if kobaFlag == true then
      score = (score.to_f * 1.05).round(4)
    end

    #過去のレースで今回のレースより格上を走っているか
    raceRankDif = raceRank - thisRaceRank
    # p raceRankDif
    #レースランクボーナス
    if chakujun <= 8 then
      if raceRankDif == 1 then
        score = (score.to_f * 1.02).round(4)
      elsif raceRankDif == 2 then
        score = (score.to_f * 1.04).round(4)
      elsif raceRankDif == 3 then
        score = (score.to_f * 1.06).round(4)
      elsif raceRankDif == 4 then
        score = (score.to_f * 1.08).round(4)
      elsif raceRankDif == 5 then
        score = (score.to_f * 1.10).round(4)
      elsif raceRankDif == 6 then
        score = (score.to_f * 1.12).round(4)
      elsif raceRankDif == 7 then
        score = (score.to_f * 1.14).round(4)
      elsif raceRankDif == 8 then
        score = (score.to_f * 1.16).round(4)
      elsif raceRankDif == -1 then
        score = (score.to_f * 0.98).round(4)
      elsif raceRankDif == -2 then
        score = (score.to_f * 0.96).round(4)
      elsif raceRankDif == -3 then
        score = (score.to_f * 0.94).round(4)
      elsif raceRankDif == -4 then
        score = (score.to_f * 0.92).round(4)
      elsif raceRankDif == -5 then
        score = (score.to_f * 0.90).round(4)
      end
    end
    # p "スコア" + score.to_s
    return score

  end

  #馬の指数を計算する
  def getUmaScore(umaCd, kaisaibi, thisRaceRank, bashoCd, kyori, babashurui, targetRaceRank, kishuCd)
    #出走馬自身の情報を取得する
    #↓暫定
    sei = 0
    #牝馬の場合は季節を考慮する
    kaisaibiStr = kaisaibi.strftime("%Y/%m/%d")
    zensouDate = nil
    fromZensou = nil

    @rows = RaceResult.find_by_sql(SqlCommand.getUmaPastRaceSql(umaCd, kaisaibiStr))
    raceCount = 0
    score = 0
    anteiCnt_1 = 0
    anteiCnt_2 = 0
    kyakushitsuSum = 0.0

    # p umaCd
    #過去レースの分析
    @rows.each do |row|

      raceCount += 1

      sei = row.sei

      #レース情報の取得
      @race = Race.where("racecd=:racecd",racecd:row.racecd)
      raceRank = 0
      @race.each do |raceRow|
        raceRank = raceRow.raceRank
        if raceCount == 1 then
          zensouDate = raceRow.kaisaibi
        end
      end

      if raceRank == 99 then
        raceCount = raceCount -1
        next
      end

      #レース頭数
      tousuu = RaceResult.where("racecd=:racecd",racecd:row.racecd).count

      #前走の1着との秒数差
      kachiumaTimeSeconds = RaceResult.where("racecd=:racecd",racecd:row.racecd,).where("chakujun=:chakujun",chakujun:1)
      sabunTimeSecond = row.timeSecond - kachiumaTimeSeconds[0].timeSecond

      #3歳の場合、古馬との対決か
      kobaFlag = false
      kobaCount = 0
      if row.rei == 3 then
        kobaCount = RaceResult.where("racecd=:racecd",racecd:row.racecd,).where("rei>:rei",rei:3).count
        if kobaCount > 0
          kobaFlag = true
        end
      end

      #前走のスコア
      score += Calculation.chakujunScore(row.chakujun, tousuu, raceRank, raceCount, thisRaceRank, sabunTimeSecond, row.rei, kobaFlag)
      # p score
      # p row.time[0,1].to_i * 60 +  row.time[2,2].to_i + row.time[5,1].to_f/10
      #馬体重分析
      #馬場得意不得意
      #天気

      #前走からの日数を取得しておく
      if raceCount == 1 then
        fromZensou = kaisaibi - zensouDate
      end

      # #安定感1
      # if raceCount <= 3 then
      #   if row.chakujun <= 5 then
      #     anteiCnt_1 += 1
      #   end
      # end
      #安定感2
      if raceCount <= 3 then
        if row.chakujun <= 8 then
          anteiCnt_2 += 1
        end
      end
    end

    if score == 0 then
      return 0
    end

    score = (score.to_f / raceCount.to_f).round(4)

    tokuiBasho = 0
    #場所と距離の過去成績
    @pastSameRaceRows = RaceResult.find_by_sql(SqlCommand.getUmaPastSameRaceSql(umaCd, bashoCd, kyori, babashurui, kaisaibiStr))
    @pastSameRaceRows.each do |row|
      if row.chakujun == 1
        tokuiBasho += 1
      end
    end

    #競馬場が得意か
    if tokuiBasho >= 3 then
      score = (score.to_f * 1.1).round(4)
    elsif tokuiBasho >= 1
      score = (score.to_f * 1.05).round(4)
    end

    #直近3走の安定感を評価
    # if anteiCnt_1 == 3 then
    #   score = score * 1.05
    # elsif anteiCnt_2 == 3 then
    #   score = score * 1.03
    # end
    if anteiCnt_2 == 3 then
      score = (score.to_f * 1.1).round(4)
    end

    # #前走から90日以上空いている場合、減点
    # if fromZensou.to_i >= 90 then
    #   score = score * 0.6
    # end

    return score
  end

  #馬の連対率を算出する
  def getRentairitsuScore(debug, umaCd, kaisaibi, sei, rei, kinryou, bataijuu, bashoCd, babashurui, baban, kyori, kishuCd, choukyoushiCd)
    if debug == 1 then
      p "getRentairitsuScore：" + umaCd, kaisaibi, sei, rei, kinryou, bataijuu, bashoCd, babashurui, baban, kyori, kishuCd, choukyoushiCd
    end
    score = 0
    rentaiScores = {}

    #性別
    seiRentairitsuSql = "select rentai from rentairitsus where name ='sei' and rentaiProp ='{$sei}' ".to_s.sub!("{$sei}", sei.to_s)
    @seiRentairitsus = Rentairitsu.find_by_sql(seiRentairitsuSql)
    @seiRentairitsus.each do |row|
      if debug == 1 then
        p "性別：" + row.rentai.to_s
      end
      rentaiScores["sei"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
    end

    #!!牡牝の月毎の連対率!!を追加する
    seiMonthRentairitsuSql = "select rentai from rentairitsus where name ='sei_month' and rentaiProp ='{$sei_month}' ".to_s.sub!("{$sei_month}", sei.to_s+"_"+kaisaibi[5,2])
    @seiMonthRentairitsus = Rentairitsu.find_by_sql(seiMonthRentairitsuSql)
    @seiMonthRentairitsus.each do |row|
      if debug == 1 then
        p "牡牝の月毎：" + row.rentai.to_s
      end
      rentaiScores["seiMonth"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
    end

    #!!牡牝の馬場毎の連対率!!を追加する
    seiBabashuruiRentairitsuSql = "select rentai from rentairitsus where name ='sei_babashurui' and rentaiProp ='{$sei_babashurui}' ".to_s.sub!("{$sei_babashurui}", sei.to_s+"_"+babashurui.to_s)
    @seiBabashuruiRentairitsus = Rentairitsu.find_by_sql(seiBabashuruiRentairitsuSql)
    @seiBabashuruiRentairitsus.each do |row|
      if debug == 1 then
        p "牡牝の馬場毎：" + row.rentai.to_s
      end
      rentaiScores["seiBabashurui"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
    end

    #年齢の連対率を反映
    reiRentairitsuSql = "select rentai from rentairitsus where name ='rei' and rentaiProp ='{$rei}' ".sub!("{$rei}", rei.to_s)
    @reiRentairitsus = Rentairitsu.find_by_sql(reiRentairitsuSql)
    @reiRentairitsus.each do |row|
      if debug == 1 then
        p "年齢：" + row.rentai.to_s
      end
      rentaiScores["rei"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
    end


    #斤量の連対率を反映
    kinryouRentairitsuSql = "select rentai from rentairitsus where name ='kinryou' and rentaiProp ='{$kinryou}' ".sub!("{$kinryou}", kinryou.to_s)
    @kinryouRentairitsus = Rentairitsu.find_by_sql(kinryouRentairitsuSql)
    @kinryouRentairitsus.each do |row|
      if debug == 1 then
        p "斤量：" + row.rentai.to_s
      end
      rentaiScores["kinryou"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
    end

    #馬体重の連対率を反映
    bataijuu = bataijuu.to_i.round(-1)
    bataijuuRentairitsuSql = "select rentai from rentairitsus where name ='bataijuu' and rentaiProp ='{$bataijuu}' ".sub!("{$bataijuu}", bataijuu.to_s)
    @bataijuuRentairitsu = Rentairitsu.find_by_sql(bataijuuRentairitsuSql)
    @bataijuuRentairitsu.each do |row|
      if debug == 1 then
        p "馬体重：" + row.rentai.to_s
      end
      rentaiScores["bataijuu"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
    end

    #馬番の連対率を反映
    umabanRtKey = bashoCd.to_s + "_" + babashurui.to_s + "_" + baban.to_s
    umabanRentairitsuSql = "select rentai from rentairitsus where name ='umaban' and rentaiProp ='{$umabanRtKey}' ".sub!("{$umabanRtKey}", umabanRtKey.to_s)
    @umabanRentairitsu = Rentairitsu.find_by_sql(umabanRentairitsuSql)
    @umabanRentairitsu.each do |row|
      if debug == 1 then
        p "馬番：" + row.rentai.to_s
      end
      rentaiScores["umaban"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
      # umabanScores[baban] = row.rentai.round(4)
    end

    #脚質の連対率を反映
    kyakushitsu = 0
    @kyakushitsu = RentaibaTsuuka.find_by_sql(SqlCommand.getKyakushitsuSql(umaCd, kaisaibi))
    @kyakushitsu.each do |row|
      kyakushitsu = row.kyakushitsu
    end
    kyakushitsuRtKey = bashoCd.to_s + "_" + kyori.to_s + "_" + babashurui.to_s + "_" + kyakushitsu.to_s
    kyakushitsuRentairitsuSql = "select rentai from rentairitsus where name ='kyakushitsu' and rentaiProp ='{$kyakushitsuRtKey}' ".sub!("{$kyakushitsuRtKey}", kyakushitsuRtKey.to_s)
    @kyakushitsuRentairitsu = Rentairitsu.find_by_sql(kyakushitsuRentairitsuSql)
    @kyakushitsuRentairitsu.each do |row|
      if debug == 1 then
        p "脚質：" + row.rentai.to_s
      end
      rentaiScores["kyakushitsu"] = row.rentai.round(4)
      score = score + row.rentai.round(4)
    end

    #血統の連対率
    bloedsCnt = 0
    bloedsScore = 0
    @bloeds = HorseBloed.where(umaCd:umaCd).where(parentKbn: 0).order(:sedai)
    @bloeds.each do |row|
      bloedUmaCd = row.bloedUmaCd
      bloedRtKey = bashoCd.to_s + "_" + babashurui.to_s + "_" + kyori.to_s + "_" + bloedUmaCd.to_s
      bloedRentairitsuSql = "select rentai from rentairitsus where name ='bloed_f' and rentaiProp ='{$bloedRtKey}' ".sub!("{$bloedRtKey}", bloedRtKey.to_s)
      @bloedRentairitsu = Rentairitsu.find_by_sql(bloedRentairitsuSql)
      @bloedRentairitsu.each do |row|

        if debug == 1 then
          p "血統：" + row.rentai.to_f.round(4).to_s
        end
        if bloedsCnt == 0 then
          rentaiScores["bloed_f"] = row.rentai.round(4)
          score = score + row.rentai.to_f.round(4)

          # bloedMawariRtKey = babashurui.to_s + "_" + mawari.to_s + "_" + bloedUmaCd.to_s
          # bloedMawariRentairitsuSql = "select rentai from rentairitsus where name ='bloed_f' and rentaiProp ='{$bloedMawariRtKey}' ".sub!("{$bloedMawariRtKey}", bloedMawariRtKey.to_s)
          # p bloedMawariRentairitsuSql
          # @bloedMawariRentairitsu = Rentairitsu.find_by_sql(bloedMawariRentairitsuSql)
          # @bloedMawariRentairitsu.each do |mawariRow|
          #   rentaiScores["bloed_f_mawari"] = mawariRow.rentai.round(4)
          #   score = score + mawariRow.rentai.to_f.round(4)
          # end

        else
          if row.rentai.to_f >= 0.25 then
            bloedsScore += 1
          end
        end
        bloedsCnt += 1
      end
    end
    rentaiScores["bloedsScores"] = bloedsScore
    #血統指数
    if bloedsScore.to_i >= 5 then
      score = score * 1.2
    end

    #騎手の連対率を反映
    @kishuRentai = RaceResult.find_by_sql(SqlCommand.getKishuRentairitsuSql(kishuCd, kaisaibi))
    @kishuRentai.each do |row|
      if debug == 1 then
        p "騎手：" + row.rentairitsu.to_s
      end
      rentaiScores["kishu"] = row.rentairitsu.to_f.round(4)
      score = score + row.rentairitsu.to_f.round(4)
    end

    # #調教師の連対率を反映
    # @choukyoushiRentai = RaceResult.find_by_sql(SqlCommand.getChoukyoushiRentairitsuSql(choukyoushiCd, kaisaibi))
    # @choukyoushiRentai.each do |row|
    #   rentaiScores["choukyoushi"] = row.rentairitsu.to_f.round(4)
    #   score = score + row.rentairitsu.to_f.round(4)
    # end

    rentaiScores["sum"] = score

    if debug == 1 then
      p rentaiScores
    end

    return rentaiScores
  end
  def getKaishuuScore(score, umaCd, kyori, babashurui, debug)

    kaishuuScores = {}

    #スピード偏差値
    speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(umaCd, kyori, babashurui))
    kaishuuScores["speedHensa"] = speedHensaMax[0].speed
    if kaishuuScores["speedHensa"] == nil then
      speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(umaCd, kyori+200, babashurui))
      kaishuuScores["speedHensa"] = speedHensaMax[0].speed
    end
    if kaishuuScores["speedHensa"] == nil then
      speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(umaCd, kyori-200, babashurui))
      kaishuuScores["speedHensa"] = speedHensaMax[0].speed
    end

    #上がり偏差値
    agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(umaCd, kyori, babashurui))
    kaishuuScores["agariHensas"] = agariHensaMax[0].speed
    if kaishuuScores["agariHensas"] == nil then
      agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(umaCd, kyori+200, babashurui))
      kaishuuScores["agariHensas"] = agariHensaMax[0].speed
    end
    if kaishuuScores["agariHensas"] == nil then
      agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(umaCd, kyori-200, babashurui))
      kaishuuScores["agariHensas"] = agariHensaMax[0].speed
    end

    #回収率が高い
    if kaishuuScores["speedHensa"] != nil then
      if kaishuuScores["speedHensa"] == 44 || kaishuuScores["speedHensa"] == 50 || kaishuuScores["speedHensa"] == 53 then
        if debug == 1 then
          p "スピード偏差回収率ヒット!!"
        end
        score = score * 1.2
      end
    end

    #回収率が高い
    if kaishuuScores["agariHensas"] != nil then
      if kaishuuScores["agariHensas"] >= 51 && kaishuuScores["agariHensas"] <= 54 then
        if debug == 1 then
          p "上がり偏差回収率ヒット!!"
        end
        score = score * 1.2
      end
    end

    kaishuuScores["score"] = score

    if debug == 1 then
      p kaishuuScores
    end

    return kaishuuScores
  end
 end
end

class SqlCommand
 class << self
   def getUmaPastRaceSql(umaCd, kaisaibi)
     #直近5レースを取得する
     sql = "select  a.* from race_results a "\
     + "join races b "\
     + "on a.racecd = b.racecd "\
     + "where umaCd = '{$umaCd}' "\
     + " and kaisaibi < '{$kaisaibi}' "\
     + " and chakujun > 0 "\
     + "order by b.kaisaibi desc limit 5"
     sql = sql.sub!("{$umaCd}", umaCd)
     sql = sql.sub!("{$kaisaibi}", kaisaibi)
     return sql
   end

   def getUmaPastSameRaceSql(umaCd, bashoCd, kyori, babashurui, kaisaibi)
     #同じ場所、距離、馬場のレース成績を取得する
     sql = "select  a.* from race_results a "\
     + "join races b "\
     + "on a.racecd = b.racecd "\
     + "where umaCd = '{$umaCd}' "\
     + " and b.bashoCd = '{$bashoCd}' "\
     + " and b.babashurui = '{$babashurui}' "\
     + " and b.kyori = '{$kyori}' "\
     + " and b.kaisaibi < '{$kaisaibi}' "\
     + "order by b.kaisaibi"
     sql = sql.sub!("{$umaCd}", umaCd.to_s)
     sql = sql.sub!("{$bashoCd}", bashoCd.to_s)
     sql = sql.sub!("{$kyori}", kyori.to_s)
     sql = sql.sub!("{$babashurui}", babashurui.to_s)
     sql = sql.sub!("{$kaisaibi}", kaisaibi)
     return sql
   end
   def getUmaSpeedHensaSql(umaCd, kyori, babashurui)
     sql = "select kyori, max(speed) as speed from horse_hensa_values"\
      + " where umaCd = '{$umaCd}'"\
      + " and kyori = {$kyori}"\
      + " and babashurui = {$babashurui}"
      sql = sql.sub!("{$umaCd}", umaCd.to_s)
      sql = sql.sub!("{$kyori}", kyori.to_s)
      sql = sql.sub!("{$babashurui}", babashurui.to_s)
      return sql
   end
   def getUmaAgariHensaSql(umaCd, kyori, babashurui)
     sql = "select kyori, max(speed) as speed from horse_hensa_agari_values"\
      + " where umaCd = '{$umaCd}'"\
      + " and kyori = {$kyori}"\
      + " and babashurui = {$babashurui}"
      sql = sql.sub!("{$umaCd}", umaCd.to_s)
      sql = sql.sub!("{$kyori}", kyori.to_s)
      sql = sql.sub!("{$babashurui}", babashurui.to_s)
      return sql
   end
   def getKishuKaishuritsuSql(kishuCd, kaisaibi)
     kaisaibiBf = (kaisaibi[0,4].to_i - 1).to_s + kaisaibi[4,6]
     sql = "select a.kishuCd, toushi, kaishu, round(kaishu/toushi*100,2) as kaishuritsu from "\
      + "(/*投資金額*/" \
      + "select kishuCd, count(*)*100 as toushi from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='{$kishuCd}' group by kishuCd) a "\
      + "join (/*回収金額*/" \
      + "select kishuCd, sum(tanshou)*100 as kaishu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='{$kishuCd}' where chakujun =1 group by kishuCd) b "\
      + "on a.kishuCd = b.kishuCd "
      sql = sql.sub!("{$kishuCd}", kishuCd.to_s)
      sql = sql.sub!("{$kaisaibi}", kaisaibi)
      sql = sql.sub!("{$kaisaibiBf}", kaisaibiBf)
      sql = sql.sub!("{$kishuCd}", kishuCd.to_s)
      sql = sql.sub!("{$kaisaibi}", kaisaibi)
      sql = sql.sub!("{$kaisaibiBf}", kaisaibiBf)
      return sql
   end
   def getKishuRentairitsuSql(kishuCd, kaisaibi)
     kaisaibiBf = (kaisaibi[0,4].to_i - 1).to_s + kaisaibi[4,6]
      sql = "select a.kishuCd, bosu, rentaisu, round(rentaisu/bosu,4) as rentairitsu from "\
      + "(/*母数*/ "\
      + "select kishuCd, count(*) as bosu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='{$kishuCd}' group by kishuCd) a  "\
      + "join (/*連対数*/ "\
      + "select kishuCd, count(*) as rentaisu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and rr.kishuCd ='{$kishuCd}' and rr.chakujun between 1 and 3 group by rr.kishuCd) b  "\
      + "on a.kishuCd = b.kishuCd "
      sql = sql.sub!("{$kishuCd}", kishuCd.to_s)
      sql = sql.sub!("{$kaisaibi}", kaisaibi)
      sql = sql.sub!("{$kaisaibiBf}", kaisaibiBf)
      sql = sql.sub!("{$kishuCd}", kishuCd.to_s)
      sql = sql.sub!("{$kaisaibi}", kaisaibi)
      sql = sql.sub!("{$kaisaibiBf}", kaisaibiBf)
      return sql
   end
   def getChoukyoushiRentairitsuSql(choukyoushiCd, kaisaibi)
     kaisaibiBf = (kaisaibi[0,4].to_i - 1).to_s + kaisaibi[4,6]
      sql = "select a.choukyoushiCd, bosu, rentaisu, round(rentaisu/bosu,4) as rentairitsu from "\
      + "(/*母数*/ "\
      + "select choukyoushiCd, count(*) as bosu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and choukyoushiCd ='{$choukyoushiCd}' group by choukyoushiCd) a  "\
      + "join (/*連対数*/ "\
      + "select choukyoushiCd, count(*) as rentaisu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and rr.choukyoushiCd ='{$choukyoushiCd}' and rr.chakujun between 1 and 3 group by rr.choukyoushiCd) b  "\
      + "on a.choukyoushiCd = b.choukyoushiCd "
      sql = sql.sub!("{$choukyoushiCd}", choukyoushiCd.to_s)
      sql = sql.sub!("{$kaisaibi}", kaisaibi)
      sql = sql.sub!("{$kaisaibiBf}", kaisaibiBf)
      sql = sql.sub!("{$choukyoushiCd}", choukyoushiCd.to_s)
      sql = sql.sub!("{$kaisaibi}", kaisaibi)
      sql = sql.sub!("{$kaisaibiBf}", kaisaibiBf)
      return sql
   end
   def getKyakushitsuSql(umaCd, kaisaibi)
    sql = "select "\
    + "round( "\
    + "  avg(  "\
    + "   case when pa < 0.15 then "\
    + "    1 "\
    + "    when pa > 0.15 and pa <= 0.30 then "\
    + "    2 "\
    + "    when pa > 0.30 and pa <= 0.70 then "\
    + "    3 "\
    + "    else "\
    + "    4 "\
    + "    end "\
    + "  ) "\
    + ", 0) as kyakushitsu "\
    + "from ( "\
    + "  select  "\
    + "   rt.racecd, tousuu, round(avg(rt.position/tousuu), 2) as pa "\
    + "  from rentaiba_tsuukas rt "\
    + "  join race_tousuus racetousuu "\
    + "  on rt.racecd = racetousuu.racecd "\
    + "  and position IS NOT NULL "\
    + "  join races "\
    + "   on races.racecd = rt.racecd "\
    + "   and races.kaisaibi <= '{$kaisaibi}' "\
    + "  where rt.umaCd = '{$umaCd}' "\
    + "  group by rt.racecd, tousuu "\
    + "  order by rt.racecd desc limit 3 "\
    + ") a "
    sql = sql.sub!("{$umaCd}", umaCd)
    sql = sql.sub!("{$kaisaibi}", kaisaibi)
    return sql
   end
 end
end

class HorseShisuuKeisanBatch

  def self.execute

    debug = 0
    mailSend = true
    thisKaisaibi = "2017/02/12"
    nowTime = Time.now

    mailHonbun = []

    raceInfoArray = []

    raceInfoArray.push(["c201705010611",7,1800,1])
    raceInfoArray.push(["c201708020611",8,2200,1])
    # raceInfoArray.push(["c201705010606",3,2400,1])
    # raceInfoArray.push(["c201705010607",3,1400,0])
    # raceInfoArray.push(["c201705010608",3,2100,0])
    # raceInfoArray.push(["c201705010609",5,1400,1])
    # raceInfoArray.push(["c201705010612",4,1600,1])
    #
    # raceInfoArray.push(["c201708020607",3,1900,0])
    # raceInfoArray.push(["c201708020608",4,1800,0])
    # raceInfoArray.push(["c201708020609",3,1600,1])
    # raceInfoArray.push(["c201708020612",4,1200,0])
    #
    # raceInfoArray.push(["c201710010202",3,1000,0])
    # raceInfoArray.push(["c201710010206",3,2600,1])
    # raceInfoArray.push(["c201710010207",3,1700,0])
    # raceInfoArray.push(["c201710010208",3,1200,1])
    # raceInfoArray.push(["c201710010209",3,2000,1])
    # raceInfoArray.push(["c201710010210",3,1200,1])
    # raceInfoArray.push(["c201710010211",5,1700,0])
    # raceInfoArray.push(["c201710010212",4,2000,1])

    raceInfoArray.each do |raceInfo|

      mailHonbunRow = []

      raceId = raceInfo[0]
      thisRaceRank = raceInfo[1]
      thisKyori = raceInfo[2]
      thisBabashurui = raceInfo[3]

      url = 'http://race.netkeiba.com/?pid=race_old&id=' + raceId.to_s
      thisBashoCd = raceId[5, 2]

      charset = 'euc-jp'

      html = open(url) do |f|
        #charset = f.charset # 文字種別を取得
        f.read # htmlを読み込んで変数htmlに渡す
      end
      #htmlをパース(解析)してオブジェクトを生成
      doc = Nokogiri::HTML.parse(html, nil, charset)

      #レース概要を取得
      name = nil
      description = nil
      doc.xpath('//div[@class="data_intro"]').each do |node|
        name = node.css('h1').inner_text
        description = node.css('span').inner_text
      end
      #発走時刻
      hassoujikoku = nil
      hassoujikokuTime = nil
      if description.match(/\d{2}:\d{2}/) != nil then
        hassoujikoku = description.match(/\d{2}:\d{2}/)[0]
        hassoujikokuTime = Time.parse(thisKaisaibi.to_s + " " + hassoujikoku.to_s)
      end

      p doc.title.gsub(/[\r\n]/,"")
      if hassoujikokuTime > nowTime then
        mailHonbunRow.push(doc.title.gsub(/[\r\n]/,""))
        mailHonbunRow.push(description)
      end

      umaCdArray = []
      kishuCdArray = []
      choukyoushiCdArray = []
      doc.css('a').each do |anchor|
        umaCd = nil
        if anchor[:href].include?("db.netkeiba.com/horse/") then
          umaCd = anchor[:href].gsub(/[^0-9]/,"")
          umaCdArray.push(umaCd)
        end
        if anchor[:href].include?("db.netkeiba.com/jockey/") then
          kishuCd = anchor[:href].gsub(/[^0-9]/,"")
          kishuCdArray.push(kishuCd)
        end
        if anchor[:href].include?("db.netkeiba.com/trainer/") then
          choukyoushiCd = anchor[:href].gsub(/[^0-9]/,"")
          choukyoushiCdArray.push(choukyoushiCd)
        end
      end

      payTrs = doc.xpath('//*/table[@class="race_table_old nk_tb_common"]/tr')
      seireiArray = []
      kinryouArray = []
      bataijuuArray = []
      payTrs.each do |payTr|
        if payTr.xpath('./td[4]').text != "" then
          seireiArray.push(payTr.xpath('./td[4]').text)
        end
        if payTr.xpath('./td[5]').text != "" then
          kinryouArray.push(payTr.xpath('./td[5]').text)
        end
        if payTr.xpath('./td[8]').text != "" then
          bataijuuArray.push(payTr.xpath('./td[8]').text)
        end
      end

      baban = 1

      today = Date.parse(thisKaisaibi)
      zensouDate = nil
      fromZensou = 0
      scores = {}
      bloedsScores = {}
      speedHensas = {}
      agariHensas = {}
      umabanScores = {}
      for umaCd in umaCdArray do

        score = Calculation.getUmaScore(umaCd, today, thisRaceRank, thisBashoCd, thisKyori, thisBabashurui, thisRaceRank, kishuCdArray[baban-1])

        if debug == 1 then
          p baban.to_s + "ー" + umaCd.to_s
        end
        if debug == 1 then
          p score
        end
        #性別の連対率を反映
        sei = 0
        seiStr = seireiArray[baban-1][0, 1]
        if seiStr == "牡" then
          sei = 0
        elsif seiStr == "牝"
          sei = 1
        else
          sei = 2
        end

        bataijuu = 0

        if bataijuuArray[baban-1] != nil && bataijuuArray[baban-1].to_f > 300 then
          bataijuu = bataijuuArray[baban-1][0 ,3].to_i.round(-1)
        else
          pastBataijuuSql = "select rr.bataijuu as pastBataijuu from race_results rr join races rc on rr.racecd = rc.racecd where umaCd='{$umaCd}' order by rc.kaisaibi desc limit 5 ".sub!("{$umaCd}", umaCd.to_s)
          @pastBataijuus = RaceResult.find_by_sql(pastBataijuuSql)
          @pastBataijuus.each do |row|
            if row.pastBataijuu != nil && row.pastBataijuu != 0 then
              bataijuu = row.pastBataijuu
              break
            end
          end
        end

        #年齢
        rei = seireiArray[baban-1][1, 1]
        rentaiScores = Calculation.getRentairitsuScore(debug, umaCd, thisKaisaibi, sei, rei, kinryouArray[baban-1], bataijuu.to_s, thisBashoCd, thisBabashurui, baban, thisKyori, kishuCdArray[baban -1], choukyoushiCdArray[baban-1])
        #TODO バグっていたが結果的に回収率アップ？テストする。
        score += score + rentaiScores["sum"].to_f

        kaishuuScores = Calculation.getKaishuuScore(score, umaCd, thisKyori, thisBabashurui, debug)
        score = kaishuuScores["score"].to_f

        #馬番と指数のmapを作成してキーでソート
        scores[baban] = score

        baban += 1

      end

      #勝ち馬5頭を取得
      loopCnt=0
      scores.sort_by{|key, value| -value}.each do|key, value|
        p key.to_s + "　" + value.round(4).to_s
        mailHonbunRow.push(key.to_s + "　" + value.round(4).to_s)
        loopCnt += 1
        # if loopCnt == 3 then
        #   break
        # end
        # p key.to_s + "　" + value.round(4).to_s
      end
      if hassoujikokuTime > nowTime then
        mailHonbun.push(mailHonbunRow)
      end

    end

    if mailSend && mailHonbun.size > 0 then
      @mail = KaimeMailer.send_mail(mailHonbun).deliver
    end

  end

end

class KaishuritsuKeisanBatch
  def self.execute

    version = "0.68"
    toushiGaku = 0
    toushiRace = 0

    kaishuGaku = 0
    tekichuRace = 0
    debug = 0

    #まずは10年分
    # @races = Race.find_by_sql("select * from races where kaisaibi >= '2015/01/01' and kaisaibi <= '2015/12/31' and babashurui <> 9 and raceRank = 1 order by kaisaibi")
    @races = Race.find_by_sql("select * from races where kaisaibi >= '2016/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9 order by kaisaibi")
    # @races = Race.find_by_sql("select * from races where kaisaibi >= '2010/01/01' and kaisaibi <= '2015/12/31' and raceRank between 3 and 5 and bashocd in ('03') order by kaisaibi")

    #レース数を取得する
    @races.each do |race|

      # if RaceResult.where("racecd=:racecd",racecd:race.racecd).count < 12 then
      #   next
      # end

      @raceResults = RaceResult.where("racecd=:racecd",racecd:race.racecd)
      scores = {}
      bloedsScores = {}
      speedHensas = {}
      agariHensas = {}
      umabanScores = {}
      @raceResults.each do |raceResult|

        kaisaibiStr = race.kaisaibi.strftime("%Y/%m/%d")

        #指数を算出
        score = Calculation.getUmaScore(raceResult.umaCd, race.kaisaibi, race.raceRank, race.bashocd, race.kyori, race.babashurui, race.raceRank, raceResult.kishuCd)

        #連対率を追加
        rentaiScores = Calculation.getRentairitsuScore(debug, raceResult.umaCd, kaisaibiStr, raceResult.sei, raceResult.rei, raceResult.kinryou, raceResult.bataijuu, race.bashocd, race.babashurui, raceResult.umaban, race.kyori, raceResult.kishuCd, raceResult.choukyoushiCd, raceMawari)
        score += score + rentaiScores["sum"].to_f

        kaishuuScores = Calculation.getKaishuuScore(score, raceResult.umaCd, race.kyori, race.babashurui, debug)
        score = kaishuuScores["score"].to_f

        pastRaceUmaShisuu = PastRaceUmaShisuu.new(
          racecd: raceResult.racecd,
          chakujun: raceResult.chakujun,
          shisuu: score,
          fatherRt: rentaiScores["bloed_f"],
          bloedsScore: rentaiScores["bloedsScore"],
          speedHensa: kaishuuScores["speedHensas"],
          agariHensa: kaishuuScores["agariHensas"],
          version: version
        )
        pastRaceUmaShisuu.save

        #馬番と指数のmapを作成してキーでソート
        scores[raceResult.umaban] = score
      end
      # scores.sort_by{ |_, v| -v }
      #勝ち馬5頭を取得
      count = 0
      yosouRentaiba = {}
      scores.sort_by{|key, value| -value}.each do|key, value|
        yosouRentaiba[key] = value
        count += 1
        # if count == 5 then
        if count == 2 then
          break
        end
      end

      toushiGaku += 1000
      toushiRace += 1

      #レースの1,2着を取得
      #指数マップと合致させる
      topFlag = false
      top = 0
      topStr = 0
      @raceResultsTop = RaceResult.where("racecd=:racecd",racecd:race.racecd).where("chakujun=:chakujun",chakujun:1)
      if @raceResultsTop.count > 1 then
        toushiGaku = toushiGaku - 1000
        toushiRace = toushiRace - 1
        next
      end
      @raceResultsTop.each do |top|
        top = top.umaban.to_i
        topStr += top
        topFlag = yosouRentaiba.has_key?(top)
      end

      secFlag = false
      sec = 0
      secStr = 0
      @raceResultsSec = RaceResult.where("racecd=:racecd",racecd:race.racecd).where("chakujun=:chakujun",chakujun:2)
      if @raceResultsSec.count > 1 then
        toushiGaku = toushiGaku - 1000
        toushiRace = toushiRace - 1
        next
      end
      @raceResultsSec.each do |sec|
        sec = sec.umaban.to_i
        secStr += sec
        secFlag = yosouRentaiba.has_key?(sec)
      end

      # thdFlag = false
      # thd = 0
      # thdStr = 0
      # @raceResultsThd = RaceResult.where("racecd=:racecd",racecd:race.racecd).where("chakujun=:chakujun",chakujun:3)
      # if @raceResultsThd.count > 1 then
      #   toushiGaku = toushiGaku - 3500
      #   toushiRace = toushiRace - 1
      #   next
      # end
      # @raceResultsThd.each do |thd|
      #   thd = thd.umaban.to_i
      #   thdStr += thd
      #   thdFlag = yosouRentaiba.has_key?(thd)
      # end

      #2頭含まれていれば払い戻し金額取得して回収額にセット
      haraimodoshi = 0
      if topFlag && secFlag then
      # if topFlag && secFlag && thdFlag then
        # @pays = RacePayRaw.where("racecd=:racecd",racecd:race.racecd).where("bakenName=:bakenName",bakenName:"馬連")
        # @pays = RacePayRaw.where("racecd=:racecd",racecd:race.racecd).where("bakenName=:bakenName",bakenName:"三連複")
        @pays = RacePay.where("racecd=:racecd",racecd:race.racecd).where("bakenKbn=:bakenKbn",bakenKbn: 5)
        @pays.each do |pay|
          haraimodoshi = pay.pay.to_i * 10
          kaishuGaku += pay.pay.to_i * 10
          break
        end
        pastRaceTekichuu = PastRaceTekichuu.new(
          racecd: race.racecd.to_s,
          version: version
        )
        pastRaceTekichuu.save

        #的中レースをインクリメント
        tekichuRace += 1
        tousuu = RaceResult.where("racecd=:racecd",racecd:race.racecd).count
        p "raceCd：" + race.racecd.to_s + "　頭数：" + tousuu.to_s + " 1着-" + topStr.to_s + " 2着-" + secStr.to_s + " 払い戻し額：" + haraimodoshi.to_s
        # p "raceCd：" + race.racecd.to_s + "　頭数：" + tousuu.to_s + " 1着-" + topStr.to_s + " 2着-" + secStr.to_s + " 3着-" + thdStr.to_s + " 払い戻し額：" + haraimodoshi.to_s
      else
        p "はずれ"
      end

    end

    #投資金額 / 払い戻し金額して回収率
    #レース / 的中レースして的中率
    p "投資レース数：" + toushiRace.to_s
    p "的中レース数：" + tekichuRace.to_s
    # p "的中率：" + tekichuRace.div(toushiRace).to_f.to_s
    p "投資額：" + toushiGaku.to_s
    p "回収額：" + kaishuGaku.to_s
    # p "回収率：" + ((kaishuGaku / toushiGaku).to_f * 100).to_s
    p "バージョン：" + version.to_s

  end
end

HorseShisuuKeisanBatch.execute
# KaishuritsuKeisanBatch.execute
