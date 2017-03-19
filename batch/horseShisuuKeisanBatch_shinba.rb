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

    #直近3走の安定感を評価
    # if anteiCnt_1 == 3 then
    #   score = score * 1.05
    # elsif anteiCnt_2 == 3 then
    #   score = score * 1.03
    # end
    if anteiCnt_2 == 3 then
      score = (score.to_f * 1.1).round(4)
    end

    #牝馬特別ロジック
    if sei == 1 then
      if kaisaibiStr.split("/")[1] == "07" then
        score = (score.to_f * 1.1).round(4)
      elsif kaisaibiStr.split("/")[1] == "08" then
        score = score * 1.05
      elsif kaisaibiStr.split("/")[1] == "02"\
        || kaisaibiStr.split("/")[1] == "03"\
        || kaisaibiStr.split("/")[1] == "11"\
        || kaisaibiStr.split("/")[1] == "12"
      then
        score = (score.to_f * 0.9).round(4)
      end

    end

    return score
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
   def getKishuKaishuritsuSql(kishuCd, kaisaibi)
     kaisaibiBf = (kaisaibi[0,4].to_i - 1).to_s + kaisaibi[4,5]
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
     kaisaibiBf = (kaisaibi[0,4].to_i - 1).to_s + kaisaibi[4,5]
      sql = "select a.kishuCd, bosu, rentaisu, round(rentaisu/bosu,4) as rentairitsu from "\
      + "(/*母数*/ "\
      + "select kishuCd, count(*) as bosu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='{$kishuCd}' group by kishuCd) a  "\
      + "join (/*連対数*/ "\
      + "select kishuCd, count(*) as rentaisu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='{$kishuCd}' where chakujun between 1 and 3 group by kishuCd) b  "\
      + "on a.kishuCd = b.kishuCd "
      sql = sql.sub!("{$kishuCd}", kishuCd.to_s)
      sql = sql.sub!("{$kaisaibi}", kaisaibi)
      sql = sql.sub!("{$kaisaibiBf}", kaisaibiBf)
      sql = sql.sub!("{$kishuCd}", kishuCd.to_s)
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

    #絶対に変更すること！
    thisKaisaibi = "2017/02/04"
    raceId = "c201705010306"
    thisRaceRank = 1
    thisKyori = 1800
    #0ダート 1芝
    thisBabashurui = 1

    debug = 0
    url = 'http://race.netkeiba.com/?pid=race_old&id=' + raceId.to_s
    thisBashoCd = raceId[5, 2]

    charset = 'euc-jp'

    html = open(url) do |f|
      #charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    #htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)
    p doc.title

    umaCdArray = []
    kishuCdArray = []
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
    fatherScores = {}
    bloedsScores = {}
    kishuScores = {}
    umabanScores = {}
    for umaCd in umaCdArray do

      score = 0
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
      seiRentairitsuSql = "select rentai from rentairitsus where name ='sei' and rentaiProp ='{$sei}' ".to_s.sub!("{$sei}", sei.to_s)
      @seiRentairitsus = Rentairitsu.find_by_sql(seiRentairitsuSql)
      @seiRentairitsus.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        score = score + row.rentai.round(4)
      end

      #斤量の連対率を反映
      kinryouRentairitsuSql = "select rentai from rentairitsus where name ='kinryou' and rentaiProp ='{$kinryou}' ".sub!("{$kinryou}", kinryouArray[baban-1].to_s)
      @kinryouRentairitsus = Rentairitsu.find_by_sql(kinryouRentairitsuSql)
      @kinryouRentairitsus.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        score = score + row.rentai.round(4)
      end

      #馬体重の連対率を反映
      bataijuuRentairitsuSql = "select rentai from rentairitsus where name ='bataijuu' and rentaiProp ='{$bataijuu}' ".sub!("{$bataijuu}", bataijuuArray[baban-1][0 ,3].to_i.round(-1).to_s)
      @bataijuuRentairitsu = Rentairitsu.find_by_sql(bataijuuRentairitsuSql)
      @bataijuuRentairitsu.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        score = score + row.rentai.round(4)
      end

      #馬番の連対率を反映
      umabanRtKey = thisBashoCd.to_s + "_" + thisBabashurui.to_s + "_" + baban.to_s
      umabanRentairitsuSql = "select rentai from rentairitsus where name ='umaban' and rentaiProp ='{$umabanRtKey}' ".sub!("{$umabanRtKey}", umabanRtKey.to_s)
      @umabanRentairitsu = Rentairitsu.find_by_sql(umabanRentairitsuSql)
      @umabanRentairitsu.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        umabanScores[baban] = row.rentai.round(4)
      end

      #血統情報取得
      url = 'http://db.netkeiba.com/horse/ped/' + umaCd.to_s + '/'
      charset = 'euc-jp'

      html = open(url) do |f|
        f.read # htmlを読み込んで変数htmlに渡す
      end

      #htmlをパース(解析)してオブジェクトを生成
      doc = Nokogiri::HTML.parse(html, nil, charset)

      payTrs = doc.xpath('//*/table[@class="blood_table detail"]/tr')
      sedai1_Array = []
      sedai2_Array = []
      sedai3_Array = []
      sedai4_Array = []
      payTrs.each do |payTr|
        payTr.xpath('./td[@rowspan="16"]/a').each do |as|
          href = as.attribute("href")
          if href.to_s.index("ped") == nil && href.to_s.index("sire") == nil && href.to_s.index("mare") == nil then
            sedai1_Array.push(as.attribute("href").value.sub!("/horse/", "").sub!("/", ""))
          end
        end
        payTr.xpath('./td[@rowspan="8"]/a').each do |as|
          href = as.attribute("href")
          if href.to_s.index("ped") == nil && href.to_s.index("sire") == nil && href.to_s.index("mare") == nil then
            sedai2_Array.push(as.attribute("href").value.sub!("/horse/", "").sub!("/", ""))
          end
        end
        payTr.xpath('./td[@rowspan="4"]/a').each do |as|
          href = as.attribute("href")
          if href.to_s.index("ped") == nil && href.to_s.index("sire") == nil && href.to_s.index("mare") == nil then
            sedai3_Array.push(as.attribute("href").value.sub!("/horse/", "").sub!("/", ""))
          end
        end
        payTr.xpath('./td[@rowspan="2"]/a').each do |as|
          href = as.attribute("href")
          if href.to_s.index("ped") == nil && href.to_s.index("sire") == nil && href.to_s.index("mare") == nil then
            sedai4_Array.push(as.attribute("href").value.sub!("/horse/", "").sub!("/", ""))
          end
        end
      end
      #父親のみの配列を作成
      fatherBloedsArray=[]
      loopCnt = 0
      sedai1_Array.each do |row|
        if loopCnt % 2 == 0 then
          fatherBloedsArray.push(sedai1_Array[loopCnt])
        end
        loopCnt += 1
      end
      loopCnt = 0
      sedai2_Array.each do |row|
        if loopCnt % 2 == 0 then
          fatherBloedsArray.push(sedai2_Array[loopCnt])
        end
        loopCnt += 1
      end
      loopCnt = 0
      sedai3_Array.each do |row|
        if loopCnt % 2 == 0 then
          fatherBloedsArray.push(sedai3_Array[loopCnt])
        end
        loopCnt += 1
      end
      loopCnt = 0
      sedai4_Array.each do |row|
        if loopCnt % 2 == 0 then
          fatherBloedsArray.push(sedai4_Array[loopCnt])
        end
        loopCnt += 1
      end

      #血統の連対率
      bloedsCnt = 0
      bloedsScore = 0
      fatherBloedsArray.each do |row|
        bloedRtKey = thisBashoCd.to_s + "_" + thisBabashurui.to_s + "_" + thisKyori.to_s + "_" + row.to_s
        bloedRentairitsuSql = "select rentai from rentairitsus where name ='bloed_f' and rentaiProp ='{$bloedRtKey}' ".sub!("{$bloedRtKey}", bloedRtKey.to_s)
        @bloedRentairitsu = Rentairitsu.find_by_sql(bloedRentairitsuSql)
        @bloedRentairitsu.each do |row|


          if debug == 1 then
            p row.rentai.to_f
          end
          if bloedsCnt == 0 then
            fatherScores[baban] = row.rentai.to_f
          else
            if row.rentai.to_f >= 0.25 then
              bloedsScore += 1
            end
          end
          bloedsCnt += 1
        end
      end
      bloedsScores[baban] = bloedsScore

      #騎手の連対率を反映
      @kishuRentai = RaceResult.find_by_sql(SqlCommand.getKishuRentairitsuSql(kishuCdArray[baban -1], thisKaisaibi))
      @kishuRentai.each do |row|
        # p row.rentairitsu.to_f
        # score = score + (row.rentairitsu.to_f * 0.5).round(4)
        # score = score + row.rentairitsu.to_f.round(4)
        kishuScores[baban] = row.rentairitsu.to_f.round(4)
      end

      #馬番と指数のmapを作成してキーでソート
      scores[baban] = score

      baban += 1

    end

    #勝ち馬5頭を取得
    scores.sort_by{|key, value| -value}.each do|key, value|
      p key.to_s + "　" + value.round(4).to_s + " 馬番連対：" + umabanScores[key].to_s \
      + " 父親連対率：" + fatherScores[key].to_s + " 血統連対点：" + bloedsScores[key].to_s + " 騎手連対率：" + kishuScores[key].to_s
    end

  end

end

HorseShisuuKeisanBatch.execute
# KaishuritsuKeisanBatch.execute
