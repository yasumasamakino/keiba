# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

class RaceResultIkouBatch
  def self.execute
    url = 'http://race.netkeiba.com/?pid=race_old&id=c201605040706'
    charset = 'euc-jp'

    html = open(url) do |f|
      #charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    #htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)

    umaCdArray = []
    doc.css('a').each do |anchor|
      umaCd = nil
      if anchor[:href].include?("db.netkeiba.com/horse/") then
        umaCd = anchor[:href].gsub(/[^0-9]/,"")
        umaCdArray.push(umaCd)
      end
    end
  end
end

RaceResultIkouBatch.execute
