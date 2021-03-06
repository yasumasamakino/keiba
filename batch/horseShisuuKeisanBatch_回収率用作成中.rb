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

    #脚質
    kyakushitsu = (kyakushitsuSum.to_f / @rows.count).round(1)
    # #函館
    # if bashoCd.eql?("02") then
    #   if kyakushitsu < 3 then
    #     score = score + 10
    #   elsif kyakushitsu >= 3 && kyakushitsu < 6 then
    #     score = score + 7
    #   elsif kyakushitsu >= 6 && kyakushitsu < 11
    #     score = score - 10
    #   elsif kyakushitsu >= 11
    #     score = score - 10
    #   end
    # end
    # #福島
    # if bashoCd.eql?("03") then
    #   if kyakushitsu < 3 then
    #     score = score + 10
    #   elsif kyakushitsu >= 3 && kyakushitsu < 6 then
    #     score = score + 7
    #   elsif kyakushitsu >= 6 && kyakushitsu < 11
    #     score = score - 10
    #   elsif kyakushitsu >= 11
    #     score = score - 10
    #   end
    # end
    #東京
    # if bashoCd.eql?("05") then
    #   if kyakushitsu < 3 then
    #     score = score - 3
    #   elsif kyakushitsu >= 3 && kyakushitsu < 5 then
    #     score = score + 3
    #   elsif kyakushitsu >= 5 && kyakushitsu < 8
    #     score = score + 7
    #   elsif kyakushitsu >= 8 && kyakushitsu < 10
    #     score = score + 5
    #   elsif kyakushitsu >= 10 && kyakushitsu < 12
    #     score = score + 5
    #   elsif kyakushitsu > 13
    #     # score = score + 3
    #   end
    # end
    # #阪神、京都
    # if bashoCd.eql?("08") || bashoCd.eql?("09") then
    #   if kyakushitsu < 3 then
    #     # score = score - 3
    #   elsif kyakushitsu >= 3 && kyakushitsu < 5 then
    #     score = score + 7
    #   elsif kyakushitsu >= 5 && kyakushitsu < 8
    #     score = score + 7
    #   elsif kyakushitsu >= 8 && kyakushitsu < 10
    #     score = score + 5
    #   elsif kyakushitsu >= 10 && kyakushitsu < 12
    #     score = score + 3
    #   elsif kyakushitsu > 13
    #     # score = score + 3
    #   end
    # end
    # #中山、札幌、函館、福島、中京、小倉
    # if bashoCd.eql?("06") || bashoCd.eql?("01") || bashoCd.eql?("02") || bashoCd.eql?("03") || bashoCd.eql?("07")  || bashoCd.eql?("10") then
    #   if kyakushitsu < 3 then
    #     score = score + 5
    #   elsif kyakushitsu >= 3 && kyakushitsu < 5 then
    #     score = score + 7
    #   elsif kyakushitsu >= 5 && kyakushitsu < 8
    #     score = score + 5
    #   # elsif kyakushitsu >= 8 && kyakushitsu < 10
    #   #   score = score + 7
    #   elsif kyakushitsu >= 10 && kyakushitsu < 12
    #     score = score - 3
    #   elsif kyakushitsu > 13
    #     score = score - 5
    #   end
    # end

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
   def getKishuKaishuuritsuSql(kishuCd, kaisaibi)
     kaisaibiBf = (kaisaibi[0,4].to_i - 1).to_s + kaisaibi[4,5]
      sql = "select a.kishuCd, bosu, rentaisu, round(rentaisu/bosu,4) as rentairitsu from "\
      + "(/*母数*/ "\
      + "select kishuCd, count(*) * 100 as bosu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='{$kishuCd}' group by kishuCd) a  "\
      + "join (/*連対数*/ "\
      + "select kishuCd, sum(rr.tanshou) * 100 as rentaisu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '{$kaisaibiBf}' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='{$kishuCd}' where chakujun = 1 group by kishuCd) b  "\
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
    thisKaisaibi = "2016/12/11"
    raceId = "c201609050412"
    thisRaceRank = 4
    thisKyori = 1200
    #0ダート 1芝
    thisBabashurui = 0

    debug = 0
    kaishuuritsuKijun = 0.8
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
    kyakushitsuScores = {}
    fatherScores = {}
    bloedsScores = {}
    kishuScores = {}
    speedHensas = {}
    agariHensas = {}
    umabanScores = {}
    seiScores = {}
    reiScores = {}
    kinryouScores = {}
    bataijuuScores = {}
    for umaCd in umaCdArray do

      score = Calculation.getUmaScore(umaCd, today, thisRaceRank, thisBashoCd, thisKyori, thisBabashurui, thisRaceRank, kishuCdArray[baban-1])
      if debug == 1 then
        p baban.to_s + "ー" + umaCd.to_s
      end
      if debug == 1 then
        p score
      end
      #性別の回収率を反映
      sei = 0
      seiStr = seireiArray[baban-1][0, 1]
      if seiStr == "牡" then
        sei = 0
      elsif seiStr == "牝"
        sei = 1
      else
        sei = 2
      end
      seiKaishuuritsuSql = "select rentai from kaishuuritsus where name ='sei' and rentaiProp ='{$sei}' ".to_s.sub!("{$sei}", sei.to_s)
      @seiKaishuuritsus = Kaishuuritsu.find_by_sql(seiKaishuuritsuSql)
      @seiKaishuuritsus.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        seiScore=((row.rentai.round(4)/kaishuuritsuKijun)*100 -100).round(4)
        seiScores[baban] = seiScore
        # score = score + row.rentai.round(4)
      end

      #年齢の回収率を反映
      reiStr = seireiArray[baban-1][1, 1]
      reiKaishuuritsuSql = "select rentai from kaishuuritsus where name ='rei' and rentaiProp ='{$rei}' ".sub!("{$rei}", reiStr.to_s)
      @reiKaishuuritsus = Kaishuuritsu.find_by_sql(reiKaishuuritsuSql)
      @reiKaishuuritsus.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        reiScore=((row.rentai.round(4)/kaishuuritsuKijun)*100 -100).round(4)
        reiScores[baban] = reiScore
        # score = score + row.rentai.round(4)
      end

      #斤量の回収率を反映
      kinryouKaishuuritsuSql = "select rentai from kaishuuritsus where name ='kinryou' and rentaiProp ='{$kinryou}' ".sub!("{$kinryou}", kinryouArray[baban-1].to_s)
      @kinryouKaishuuritsus = Rentairitsu.find_by_sql(kinryouKaishuuritsuSql)
      @kinryouKaishuuritsus.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        kinryouScore=((row.rentai.round(4)/kaishuuritsuKijun)*100 -100).round(4)
        kinryouScores[baban] = kinryouScore
      end

      #馬体重の連対率を反映
      bataijuuKaishuuritsuSql = "select rentai from kaishuuritsus where name ='bataijuu' and rentaiProp ='{$bataijuu}' ".sub!("{$bataijuu}", bataijuuArray[baban-1][0 ,3].to_i.round(-1).to_s)
      @bataijuuKaishuuritsus = Kaishuuritsu.find_by_sql(bataijuuKaishuuritsuSql)
      @bataijuuKaishuuritsus.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        bataijuuScore=((row.rentai.round(4)/kaishuuritsuKijun)*100 -100).round(4)
        bataijuuScores[baban] = bataijuuScore
        # score = score + row.rentai.round(4)
      end

      #馬番の連対率を反映
      umabanRtKey = thisBashoCd.to_s + "_" + thisBabashurui.to_s + "_" + baban.to_s
      umabanKaishuuritsuSql = "select rentai from kaishuuritsus where name ='umaban' and rentaiProp ='{$umabanRtKey}' ".sub!("{$umabanRtKey}", umabanRtKey.to_s)
      @umabanKaishuuritsu = Kaishuuritsu.find_by_sql(umabanKaishuuritsuSql)
      @umabanKaishuuritsu.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        umabanScore=((row.rentai.round(4)/kaishuuritsuKijun)*100 -100).round(4)
        umabanScores[baban] = umabanScore
      end

      #脚質の連対率を反映
      kyakushitsu = 0
      @kyakushitsu = RentaibaTsuuka.find_by_sql(SqlCommand.getKyakushitsuSql(umaCd, thisKaisaibi))
      @kyakushitsu.each do |row|
        kyakushitsu = row.kyakushitsu
      end
      kyakushitsuRtKey = thisBashoCd.to_s + "_" + thisKyori.to_s + "_" + thisBabashurui.to_s + "_" + kyakushitsu.to_s
      kyakushitsuKaishuuritsuSql = "select rentai from kaishuuritsus where name ='kyakushitsu' and rentaiProp ='{$kyakushitsuRtKey}' ".sub!("{$kyakushitsuRtKey}", kyakushitsuRtKey.to_s)
      @kyakushitsuKaishuuritsu = Kaishuuritsu.find_by_sql(kyakushitsuKaishuuritsuSql)
      @kyakushitsuKaishuuritsu.each do |row|
        if debug == 1 then
          p row.rentai.to_f
        end
        kyakushitsuScore=((row.rentai.round(4)/kaishuuritsuKijun)*100 -100).round(4)
        kyakushitsuScores[baban] = kyakushitsuScore
      end

      #血統の連対率
      bloedsCnt = 0
      bloedsScore = 0
      @bloeds = HorseBloed.where(umaCd:umaCd).where(parentKbn: 0).order(:sedai)
      @bloeds.each do |row|
        bloedRtKey = thisBashoCd.to_s + "_" + thisBabashurui.to_s + "_" + thisKyori.to_s + "_" + row.bloedUmaCd.to_s
        bloedKaishuuritsuSql = "select rentai from kaishuuritsus where name ='bloed_f' and rentaiProp ='{$bloedRtKey}' ".sub!("{$bloedRtKey}", bloedRtKey.to_s)
        @bloedKaishuuritsu = Kaishuuritsu.find_by_sql(bloedKaishuuritsuSql)
        @bloedKaishuuritsu.each do |row|


          if debug == 1 then
            p row.rentai.to_f
          end
          if bloedsCnt == 0 then
            fatherScores[baban] = row.rentai.to_f
          else
            if row.rentai.to_f >= 0.8 then
              bloedsScore += 1
            end
          end
          bloedsCnt += 1
        end
      end
      bloedsScores[baban] = bloedsScore

      #騎手の連対率を反映
      @kishuKaishuuritsu = Kaishuuritsu.find_by_sql(SqlCommand.getKishuKaishuuritsuSql(kishuCdArray[baban -1], thisKaisaibi))
      @kishuKaishuuritsu.each do |row|
        # p row.rentairitsu.to_f
        # score = score + (row.rentairitsu.to_f * 0.5).round(4)
        # score = score + row.rentairitsu.to_f.round(4)
        kishuScores[baban] = row.rentairitsu.to_f.round(4)
      end

      #スピード偏差値
      speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(umaCd, thisKyori, thisBabashurui))
      speedHensas[baban] = speedHensaMax[0].speed
      if speedHensas[baban] == nil then
        speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(umaCd, thisKyori+200, thisBabashurui))
        speedHensas[baban] = speedHensaMax[0].speed
      end
      if speedHensas[baban] == nil then
        speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(umaCd, thisKyori-200, thisBabashurui))
        speedHensas[baban] = speedHensaMax[0].speed
      end

      #上がり偏差値
      agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(umaCd, thisKyori, thisBabashurui))
      agariHensas[baban] = agariHensaMax[0].speed
      if agariHensas[baban] == nil then
        agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(umaCd, thisKyori+200, thisBabashurui))
        agariHensas[baban] = agariHensaMax[0].speed
      end
      if agariHensas[baban] == nil then
        agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(umaCd, thisKyori-200, thisBabashurui))
        agariHensas[baban] = agariHensaMax[0].speed
      end

      #馬番と指数のmapを作成してキーでソート
      scores[baban] = score

      baban += 1

    end

    #勝ち馬5頭を取得
    scores.sort_by{|key, value| -value}.each do|key, value|
      p key.to_s + "　" + value.round(4).to_s + " 性別回収：" + seiScores[key].to_s + " 年齢：" + reiScores[key].to_s + " 馬体重回収：" + bataijuuScores[key].to_s  + " 馬番回収：" + umabanScores[key].to_s + " 脚質回収：" + kyakushitsuScores[key].to_s \
      + " 斤量回収率：" + kinryouScores[key].to_s+ " 父親回収率：" + fatherScores[key].to_s + " 血統連対点：" + bloedsScores[key].to_s + " 騎手回収："\
        + kishuScores[key].to_s + " スピード偏差値：" + speedHensas[key].to_s + " 上がり偏差値：" + agariHensas[key].to_s
    end

  end

end

class KaishuritsuKeisanBatch
  def self.execute

    toushiGaku = 0
    toushiRace = 0

    kaishuGaku = 0
    tekichuRace = 0

    #まずは10年分
    @races = Race.find_by_sql("select * from races where kaisaibi >= '2013/01/01' and kaisaibi <= '2015/12/31' and babashurui <> 9 order by kaisaibi")
    # @races = Race.find_by_sql("select * from races where kaisaibi >= '2013/01/01' and kaisaibi <= '2015/12/31' and raceRank between 4 and 9  and bashocd not in ('03') order by kaisaibi")
    # @races = Race.find_by_sql("select * from races where kaisaibi >= '2010/01/01' and kaisaibi <= '2015/12/31' and raceRank between 3 and 5 and bashocd in ('03') order by kaisaibi")

    #レース数を取得する
    @races.each do |race|

      # if RaceResult.where("racecd=:racecd",racecd:race.racecd).count < 12 then
      #   next
      # end

      @raceResults = RaceResult.where("racecd=:racecd",racecd:race.racecd)
      scores = {}
      kishus = {}
      kyakushitsuScores = {}
      fatherScores = {}
      bloedsScores = {}
      kishuScores = {}
      speedHensas = {}
      agariHensas = {}
      umabanScores = {}
      @raceResults.each do |raceResult|

        #指数を算出
        score = Calculation.getUmaScore(raceResult.umaCd, race.kaisaibi, race.raceRank, race.bashocd, race.kyori, race.babashurui, race.raceRank, raceResult.kishuCd)

        #騎手の連対率を反映
        kaisaibiStr = race.kaisaibi.strftime("%Y/%m/%d")
        @kishuRentai = RaceResult.find_by_sql(SqlCommand.getKishuRentairitsuSql(raceResult.kishuCd, kaisaibiStr))
        @kishuRentai.each do |row|
          # score = score + (row.rentairitsu.to_f * 0.1).round(4)
          score = score + row.rentairitsu.to_f.round(4)
        end

        #性別の連対率を反映
        seiRentairitsuSql = "select rentai from rentairitsus where name ='sei' and rentaiProp ='{$sei}' ".to_s.sub!("{$sei}", raceResult.sei.to_s)
        @seiRentairitsus = Rentairitsu.find_by_sql(seiRentairitsuSql)
        @seiRentairitsus.each do |row|
          score = score + row.rentai.round(4)
        end

        #年齢の連対率を反映
        reiRentairitsuSql = "select rentai from rentairitsus where name ='rei' and rentaiProp ='{$rei}' ".sub!("{$rei}", raceResult.rei.to_s)
        @reiRentairitsus = Rentairitsu.find_by_sql(reiRentairitsuSql)
        @reiRentairitsus.each do |row|
          score = score + row.rentai.round(4)
        end

        #斤量の連対率を反映
        kinryouRentairitsuSql = "select rentai from rentairitsus where name ='kinryou' and rentaiProp ='{$kinryou}' ".sub!("{$kinryou}", raceResult.kinryou.to_s)
        @kinryouRentairitsus = Rentairitsu.find_by_sql(kinryouRentairitsuSql)
        @kinryouRentairitsus.each do |row|
          score = score + row.rentai.round(4)
        end

        #馬体重の連対率を反映
        bataijuuRentairitsuSql = "select rentai from rentairitsus where name ='bataijuu' and rentaiProp ='{$bataijuu}' ".sub!("{$bataijuu}", raceResult.bataijuu.to_s)
        @bataijuuRentairitsu = Rentairitsu.find_by_sql(bataijuuRentairitsuSql)
        @bataijuuRentairitsu.each do |row|
          score = score + row.rentai.round(4)
        end

        #馬番の連対率を反映
        umabanRtKey = race.bashocd.to_s + "_" + race.babashurui.to_s + "_" + raceResult.umaban.to_s
        umabanRentairitsuSql = "select rentai from rentairitsus where name ='umaban' and rentaiProp ='{$umabanRtKey}' ".sub!("{$umabanRtKey}", umabanRtKey.to_s)
        @umabanRentairitsu = Rentairitsu.find_by_sql(umabanRentairitsuSql)
        @umabanRentairitsu.each do |row|
          # score = score + row.rentai.round(4)
          umabanScores[raceResult.umaban] = row.rentai.round(4)
        end

        #脚質の連対率を反映
        kyakushitsu = 0
        @kyakushitsu = RentaibaTsuuka.find_by_sql(SqlCommand.getKyakushitsuSql(raceResult.umaCd, kaisaibiStr))
        @kyakushitsu.each do |row|
          kyakushitsu = row.kyakushitsu
        end
        kyakushitsuRtKey = race.bashocd.to_s + "_" + race.kyori.to_s + "_" + race.babashurui.to_s + "_" + kyakushitsu.to_s
        kyakushitsuRentairitsuSql = "select rentai from rentairitsus where name ='kyakushitsu' and rentaiProp ='{$kyakushitsuRtKey}' ".sub!("{$kyakushitsuRtKey}", kyakushitsuRtKey.to_s)
        @kyakushitsuRentairitsu = Rentairitsu.find_by_sql(kyakushitsuRentairitsuSql)
        @kyakushitsuRentairitsu.each do |row|
          # score = score + row.rentai.round(4)
          kyakushitsuScores[raceResult.umaban] = row.rentai.round(4)
        end

        #血統の連対率
        bloedsCnt = 0
        bloedsScore = 0
        @bloeds = HorseBloed.where(umaCd:raceResult.umaCd).where(parentKbn: 0).order(:sedai)
        @bloeds.each do |row|
          bloedRtKey = race.bashocd.to_s + "_" + race.babashurui.to_s + "_" + race.kyori.to_s + "_" + row.bloedUmaCd.to_s
          bloedRentairitsuSql = "select rentai from rentairitsus where name ='bloed_f' and rentaiProp ='{$bloedRtKey}' ".sub!("{$bloedRtKey}", bloedRtKey.to_s)
          @bloedRentairitsu = Rentairitsu.find_by_sql(bloedRentairitsuSql)
          @bloedRentairitsu.each do |row|
            if bloedsCnt == 0 then
              fatherScores[raceResult.umaban] = row.rentai.to_f
            else
              if row.rentai.to_f >= 25 then
                bloedsScore += 1
              end
            end
            bloedsCnt += 1
          end
        end
        bloedsScores[raceResult.umaban] = bloedsScore

        #騎手の連対率を反映
        @kishuRentai = RaceResult.find_by_sql(SqlCommand.getKishuRentairitsuSql(raceResult.kishuCd, kaisaibiStr))
        @kishuRentai.each do |row|
          kishuScores[raceResult.umaban] = row.rentairitsu.to_f.round(4)
        end

        #スピード偏差値
        speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(raceResult.umaCd, race.kyori, race.babashurui.to_s))
        speedHensas[raceResult.umaban] = speedHensaMax[0].speed
        if speedHensas[raceResult.umaban] == nil then
          speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(raceResult.umaCd, race.kyori+200, race.babashurui.to_s))
          speedHensas[raceResult.umaban] = speedHensaMax[0].speed
        end
        if speedHensas[raceResult.umaban] == nil then
          speedHensaMax = HorseHensaValue.find_by_sql(SqlCommand.getUmaSpeedHensaSql(raceResult.umaCd, race.kyori-200, race.babashurui.to_s))
          speedHensas[raceResult.umaban] = speedHensaMax[0].speed
        end

        #上がり偏差値
        agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(raceResult.umaCd, race.kyori, race.babashurui.to_s))
        agariHensas[raceResult.umaban] = agariHensaMax[0].speed
        if agariHensas[raceResult.umaban] == nil then
          agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(raceResult.umaCd, race.kyori+200, race.babashurui.to_s))
          agariHensas[raceResult.umaban] = agariHensaMax[0].speed
        end
        if agariHensas[raceResult.umaban] == nil then
          agariHensaMax = HorseHensaAgariValue.find_by_sql(SqlCommand.getUmaAgariHensaSql(raceResult.umaCd, race.kyori-200, race.babashurui.to_s))
          agariHensas[raceResult.umaban] = agariHensaMax[0].speed
        end

        pastRaceUmaShisuu = PastRaceUmaShisuu.new(
          racecd: raceResult.racecd,
          chakujun: raceResult.chakujun,
          shisuu: score,
          fatherRt: fatherScores[raceResult.umaban],
          bloedsScore: bloedsScores[raceResult.umaban],
          speedHensa: speedHensas[raceResult.umaban],
          agariHensa: agariHensas[raceResult.umaban]
        )
        pastRaceUmaShisuu.save

        #馬番と指数のmapを作成してキーでソート
        scores[raceResult.umaban] = score
        kishus[raceResult.umaban] = raceResult.kishuCd
      end
      # scores.sort_by{ |_, v| -v }
      #勝ち馬5頭を取得
      count = 0
      yosouRentaiba = {}
      scores.sort_by{|key, value| -value}.each do|key, value|
        yosouRentaiba[key] = value
        count += 1
        # if count == 5 then
        if count == 7 then
          break
        end
      end

      toushiGaku += 3500
      toushiRace += 1

      #レースの1,2着を取得
      #指数マップと合致させる
      topFlag = false
      top = 0
      topStr = 0
      @raceResultsTop = RaceResult.where("racecd=:racecd",racecd:race.racecd).where("chakujun=:chakujun",chakujun:1)
      if @raceResultsTop.count > 1 then
        toushiGaku = toushiGaku - 3500
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
        toushiGaku = toushiGaku - 3500
        toushiRace = toushiRace - 1
        next
      end
      @raceResultsSec.each do |sec|
        sec = sec.umaban.to_i
        secStr += sec
        secFlag = yosouRentaiba.has_key?(sec)
      end

      thdFlag = false
      thd = 0
      thdStr = 0
      @raceResultsThd = RaceResult.where("racecd=:racecd",racecd:race.racecd).where("chakujun=:chakujun",chakujun:3)
      if @raceResultsThd.count > 1 then
        toushiGaku = toushiGaku - 3500
        toushiRace = toushiRace - 1
        next
      end
      @raceResultsThd.each do |thd|
        thd = thd.umaban.to_i
        thdStr += thd
        thdFlag = yosouRentaiba.has_key?(thd)
      end

      #2頭含まれていれば払い戻し金額取得して回収額にセット
      haraimodoshi = 0
      # if topFlag && secFlag then
      if topFlag && secFlag && thdFlag then
        # @pays = RacePayRaw.where("racecd=:racecd",racecd:race.racecd).where("bakenName=:bakenName",bakenName:"馬連")
        # @pays = RacePayRaw.where("racecd=:racecd",racecd:race.racecd).where("bakenName=:bakenName",bakenName:"三連複")
        @pays = RacePay.where("racecd=:racecd",racecd:race.racecd).where("bakenKbn=:bakenKbn",bakenKbn: 8)
        @pays.each do |pay|
          haraimodoshi = pay.pay.to_i
          kaishuGaku += pay.pay.to_i
          break
        end
        #的中レースをインクリメント
        tekichuRace += 1
        tousuu = RaceResult.where("racecd=:racecd",racecd:race.racecd).count
        # p "raceCd：" + race.racecd.to_s + "　頭数：" + tousuu.to_s + " 1着-" + topStr.to_s + " 2着-" + secStr.to_s + " 払い戻し額：" + haraimodoshi.to_s
        p "raceCd：" + race.racecd.to_s + "　頭数：" + tousuu.to_s + " 1着-" + topStr.to_s + " 2着-" + secStr.to_s + " 3着-" + thdStr.to_s + " 払い戻し額：" + haraimodoshi.to_s
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

  end
end


HorseShisuuKeisanBatch.execute
# KaishuritsuKeisanBatch.execute
