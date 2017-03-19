truncate table race_result_agari_avgtimes;

/*平均タイム(場所、距離、芝ダ、レースランク毎)*/
insert into race_result_agari_avgtimes
(
bashocd,
kyori,
raceRank,
babashurui,
raceCnt,
timeSecondAvg,
created_at,
updated_at
)
select
 bashocd,
 kyori,
 raceRank,
 babashurui,
 count(*) as raceCnt,
 round(avg(agari), 1) as timeSecondAvg,
 now(),
 now()
from
(
  select
   a.bashocd,
   a.kyori,
   a.raceRank,
   a.babashurui,
   b.agari
  from races a
  join race_results b
  on a.racecd = b.racecd
  and a.babashurui <> 9
  and a.raceRank >= 4 /*1000万以上*/
  and a.kaisaibi >= '2010/01/01'
  and b.agari > 0
  and b.chakujun in (1,2,3)
) t
group by
  bashocd,
  kyori,
  raceRank,
  babashurui
order by
  bashocd,
  kyori,
  raceRank,
  babashurui
;

truncate table horse_hensa_agari_values;

insert into horse_hensa_agari_values
(
umaCd,
racecd,
kyori,
babashurui,
speed,
created_at,
updated_at
)
/*基準化*/
select
 a.umaCd,
 a.racecd,
 a.kyori,
 a.babashurui,
 ROUND((a.hensa / b.hyoujunhensa),1) * -10 +50 as speed,
 now(),
 now()
from
(
  select
   a.umaCd,
   a.racecd,
   a.kyori,
   a.babashurui,
   a.agari,
   b.timeSecondAvg,
   (a.agari - b.timeSecondAvg) as hensa
  from
  (
    /*全馬の走破タイムを取得*/
    select a.umaCd, b.racecd, b.kyori, b.babashurui, a.agari from race_results a join races b on a.racecd = b.racecd and b.babashurui <> 9 and a.agari > 0 and b.kaisaibi >= STR_TO_DATE('2006/01/01', '%Y/%m/%d')
  ) a left join
  (
    /*距離、馬場毎の平均タイムを取得（レースランクは無視）*/
    select kyori, babashurui, avg(timeSecondAvg) as timeSecondAvg from race_result_agari_avgtimes group by kyori, babashurui
  ) b
  on a.kyori = b.kyori
  and a.babashurui = b.babashurui
) a
join
(
  /*標準偏差算出*/
  select
   kyori,
   babashurui,
   SQRT(sum(hensaHeiho) / count(*)) as hyoujunhensa
  from (
    select
     a.kyori,
     a.babashurui,
     POWER(a.agari - b.timeSecondAvg, 2) as hensaHeiho
    from
    (
      /*全馬の走破タイムを取得*/
	  select a.umaCd, b.racecd, b.kyori, b.babashurui, a.agari from race_results a join races b on a.racecd = b.racecd and b.babashurui <> 9 and a.agari > 0 and b.kaisaibi >= STR_TO_DATE('2006/01/01', '%Y/%m/%d')
    ) a left join
    (
      /*距離、馬場毎の平均タイムを取得（レースランクは無視）*/
      select kyori, babashurui, avg(timeSecondAvg) as timeSecondAvg from race_result_agari_avgtimes group by kyori, babashurui
    ) b
    on a.kyori = b.kyori
    and a.babashurui = b.babashurui
  ) a
  group by kyori, babashurui
) b
on a.kyori = b.kyori
and a.babashurui = b.babashurui
order by umaCd, racecd
;
