# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

class HelloBatch
  def self.execute

    url = 'http://db.netkeiba.com/race/'

    #レースコード作成
    # year = 2000
    # keibajouCd = 1
    # kaisaikai = 1
    # nissuu = 1
    # racaNo = 1
    # raceCd = nil

    charset = 'euc-jp'

    yearArray = [2017]
    kaijouArray = [6,9,7]
    kaisaikaiArray = [1,2,3,4,5,6,7,8,9]
    nissuuArray = [1,2,3,4,5,6,7,8,9]
    # for year in 2016..2016
    for year in yearArray do
      #01札幌
      #02函館
      #03福島
      #04新潟
      #05東京
      #06中山
      #07中京
      #08京都
      #09阪神
      #10小倉
      for keibajouCd in kaijouArray do
        keibajouCdStr = format("%02d", keibajouCd)
        for kaisaikai in kaisaikaiArray do
          kaisaikaiStr = format("%02d", kaisaikai)
          for nissuu in nissuuArray do
            nissuuStr = format("%02d", nissuu)
            for raceNo in 1..12
              sleep(1)

              raceNoStr = format("%02d", raceNo)
              raceCd = year.to_s + keibajouCdStr + kaisaikaiStr + nissuuStr + raceNoStr

              if RaceRow.where(racecd: raceCd).size >= 1
                next
              end

              # スクレイピング先のURL
              requestUrl = url + raceCd
              p requestUrl
              html = open(requestUrl) do |f|
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

              if name == nil
                break
              end

              raceTitle = doc.title

              raceDatePlace = nil
              doc.xpath('//p[@class="smalltxt"]').each do |node|
                raceDatePlace = node.inner_text
              end

              #レース展開を取得
              lapTrsArray = []
              lapTrs = doc.xpath('//*/table[@class="result_table_02"]/tr')
              lapTrs.each do |lapTr|
                tmpLap = lapTr.xpath('./td[@class="race_lap_cell"][1]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                if tmpLap.present?
                  lapTrsArray.push(tmpLap)
                end
              end

              #レース情報登録
              raceRow = RaceRow.new(
                    racecd: raceCd,
                    name: name,
                    description: description,
                    lap: lapTrsArray[0],
                    pacd: lapTrsArray[1],
                    raceTitle: raceTitle,
                    raceDatePlace: raceDatePlace
                    )
              raceRow.save

              #払い戻し情報を取得して登録
              bakenName = nil
              racePayRaw = nil

              payTrs = doc.xpath('//*/table[@class="pay_table_01"]/tr')
              payTrs.each do |payTr|
                #馬券種類
                bakenName = payTr.xpath('./th[1]').text.gsub(/(\r\n|\r|\n|\f)/,"")

                #馬番
                umabanPay = nil
                umabanPay_1 = payTr.xpath('./td[1]').children[0]
                if umabanPay_1.present?
                  umabanPay = umabanPay_1.to_s
                end

                umabanPay_2 = payTr.xpath('./td[1]').children[2]
                if umabanPay_2.present?
                  umabanPay = umabanPay.to_s + '|' + umabanPay_2.to_s
                end
                umabanPay_3 = payTr.xpath('./td[1]').children[4]
                if umabanPay_3.present?
                  umabanPay = umabanPay.to_s + '|' + umabanPay_3.to_s
                end

                #払い戻し
                pay = nil
                pay_1 = payTr.xpath('./td[2]').children[0]
                if pay_1.present?
                  pay = pay_1.to_s
                end

                pay_2 = payTr.xpath('./td[2]').children[2]
                if pay_2.present?
                  pay = pay.to_s + '|' + pay_2.to_s
                end

                pay_3 = payTr.xpath('./td[2]').children[4]
                if pay_3.present?
                  pay = pay.to_s + '|' + pay_3.to_s
                end

                #人気
                ninkiPay = nil
                ninkiPay_1 = payTr.xpath('./td[3]').children[0]
                if ninkiPay_1.present?
                  ninkiPay = ninkiPay_1.to_s
                end

                ninkiPay_2 = payTr.xpath('./td[3]').children[2]
                if ninkiPay_2.present?
                  ninkiPay = ninkiPay.to_s + '|' + ninkiPay_2.to_s
                end

                ninkiPay_3 = payTr.xpath('./td[3]').children[4]
                if ninkiPay_3.present?
                  ninkiPay = ninkiPay.to_s + '|' + ninkiPay_3.to_s
                end

                racePayRaw = RacePayRaw.new(racecd: raceCd, bakenName: bakenName, umaban: umabanPay, pay: pay, ninki: ninkiPay)
                racePayRaw.save

              end

              #レース結果登録
              chakujun = nil
              wakuban = nil
              umaban = nil
              umaurl = nil
              bamei = nil
              seirei = nil
              kinryou = nil
              kishu = nil
              kishuurl = nil
              time = nil
              chakusa = nil
              tsuuka = nil
              agari = nil
              tanshou = nil
              ninki = nil
              bataijuu = nil
              choukyoushi = nil
              choukyoushiurl = nil
              banushi = nil
              banushiurl = nil

              raceResultRaw = nil

              #レース情報詳細を取得して登録
              trs = doc.xpath('//*/table[@class="race_table_01 nk_tb_common"]/tr')
              trs.each do |tr|
                #馬主
                banushi = tr.xpath('./diary_snap_cut/td[1]/a').text.gsub(/(\r\n|\r|\n|\f)/,"")
                tr.xpath('./diary_snap_cut/td[1]').css('a').each do |anchor|
                  banushiurl = anchor[:href].gsub(/(\r\n|\r|\n|\f)/,"")
                end
                #通過
                # tsuuka = tr.xpath('./diary_snap_cut/td[2]').children[0].text.gsub(/(\r\n|\r|\n|\f)/,"")
                tsuuka = tr.xpath('./diary_snap_cut/td[2]').children[0].to_s
                #上がり
                agari = tr.xpath('./diary_snap_cut/td[3]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #着順
                chakujun = tr.xpath('./td[1]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #枠番
                wakuban = tr.xpath('./td[2]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #馬番
                umaban = tr.xpath('./td[3]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #馬名
                bamei = tr.xpath('./td[4]/a').text.gsub(/(\r\n|\r|\n|\f)/,"")
                tr.xpath('./td[4]').css('a').each do |anchor|
                  umaurl = anchor[:href].gsub(/(\r\n|\r|\n|\f)/,"")
                end
                #性齢
                seirei = tr.xpath('./td[5]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #斤量
                kinryou = tr.xpath('./td[6]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #騎手
                kishu = tr.xpath('./td[7]/a').text.gsub(/(\r\n|\r|\n|\f)/,"")
                tr.xpath('./td[7]').css('a').each do |anchor|
                  kishuurl = anchor[:href].gsub(/(\r\n|\r|\n|\f)/,"")
                end
                #タイム
                time = tr.xpath('./td[8]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #着差
                chakusa =  tr.xpath('./td[9]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #オッズ
                tanshou = tr.xpath('./td[10]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #人気
                ninki = tr.xpath('./td[11]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #馬体重
                bataijuu = tr.xpath('./td[12]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                #調教師
                choukyoushi = tr.xpath('./td[13]').text.gsub(/(\r\n|\r|\n|\f)/,"")
                tr.xpath('./td[13]').css('a').each do |anchor|
                  choukyoushiurl = anchor[:href].gsub(/(\r\n|\r|\n|\f)/,"")
                end

                raceResultRaw = RaceResultRaw.new(
                  racecd: raceCd,
                  chakujun: chakujun,
                  wakuban: wakuban,
                  umaban: umaban,
                  umaurl: umaurl,
                  bamei: bamei,
                  seirei: seirei,
                  kinryou: kinryou,
                  kishu: kishu,
                  kishuurl: kishuurl,
                  time: time,
                  chakusa: chakusa,
                  tsuuka: tsuuka,
                  agari: agari,
                  tanshou: tanshou,
                  ninki: ninki,
                  bataijuu: bataijuu,
                  choukyoushi: choukyoushi,
                  choukyoushiurl: choukyoushiurl,
                  banushi: banushi,
                  banushiurl: banushiurl
                )
                raceResultRaw.save

                html = nil
                doc = nil

              end

            end
          end
        end
      end
    end

    p "正常終了!!"
  end
end

HelloBatch.execute
