class TempPastshisuuUpdateBatch
  def self.execute
    @racecds = PastRaceUmaShisuu.find_by_sql("select distinct racecd from past_race_uma_shisuus order by racecd")
    @racecds.each do |racecdRow|

      @raceRows = PastRaceUmaShisuu.where(racecd: racecdRow.racecd).order("shisuu desc")
      order = 1
      @raceRows.each do |raceRow|
        raceRow.update( shisuuOrder: order)
        order += 1
      end

    end
  end
end

TempPastshisuuUpdateBatch.execute
