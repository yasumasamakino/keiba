# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

class GetBloedBatch
  def self.execute

    offset = 0
    limit = 100000

    while 1 < 2 do
      sql = "select distinct umaCd from race_results a join races b on a.racecd = b.racecd where b.kaisaibi >= '2017/01/01' order by umaCd desc limit {$offset}, {$limit}"
      sql = sql.sub!("{$offset}", offset.to_s)
      sql = sql.sub!("{$limit}", limit.to_s)

      @rows = RaceResult.find_by_sql(sql)
      if @rows.count == 0 then
        break
      end
      @rows.each do |row|

        if HorseBloed.where(umaCd: row.umaCd).count > 0 then
          next
        end

        sleep(1)

        url = 'http://db.netkeiba.com/horse/ped/' + row.umaCd.to_s + '/'
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

        parentKbn = 0
        sedai1_Array.each do |bloedUmaCd|
          horseBloed = HorseBloed.new(
                umaCd: row.umaCd,
                sedai: 1,
                parentKbn: parentKbn,
                bloedUmaCd: bloedUmaCd
                )
          horseBloed.save
          if parentKbn == 0 then
            parentKbn = 1
          else
            parentKbn = 0
          end
        end

        parentKbn = 0
        sedai2_Array.each do |bloedUmaCd|
          horseBloed = HorseBloed.new(
                umaCd: row.umaCd,
                sedai: 2,
                parentKbn: parentKbn,
                bloedUmaCd: bloedUmaCd
                )
          horseBloed.save
          if parentKbn == 0 then
            parentKbn = 1
          else
            parentKbn = 0
          end
        end

        parentKbn = 0
        sedai3_Array.each do |bloedUmaCd|
          horseBloed = HorseBloed.new(
                umaCd: row.umaCd,
                sedai: 3,
                parentKbn: parentKbn,
                bloedUmaCd: bloedUmaCd
                )
          horseBloed.save
          if parentKbn == 0 then
            parentKbn = 1
          else
            parentKbn = 0
          end
        end

        parentKbn = 0
        sedai4_Array.each do |bloedUmaCd|
          horseBloed = HorseBloed.new(
                umaCd: row.umaCd,
                sedai: 4,
                parentKbn: parentKbn,
                bloedUmaCd: bloedUmaCd
                )
          horseBloed.save
          if parentKbn == 0 then
            parentKbn = 1
          else
            parentKbn = 0
          end
        end

      end
      offset = offset + limit
    end

  end
end

GetBloedBatch.execute
