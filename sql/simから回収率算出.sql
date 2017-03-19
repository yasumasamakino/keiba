/*レースランク*/
select a.raceRank, toushi, kaishuu, round(kaishuu/toushi*100,4) 回収率 from
(
select raceRank, count(*) *1000 toushi from races rc
where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
group by raceRank
) a
join
(
select raceRank, sum(pay) * 10 kaishuu from past_race_tekichuus prt
join race_pays rp
on prt.racecd = rp.racecd
and bakenKbn ="5"
join races rc
on prt.racecd = rc.racecd
where prt.version ="0.62"
and rc.kaisaibi >= '2015/01/01' and rc.kaisaibi <= '2016/12/31' and rc.raceRank between 3 and 9 and rc.babashurui <> 9
group by raceRank
) b
on a.raceRank = b.raceRank

/*天候*/
select a.tenkou, toushi, kaishuu, round(kaishuu/toushi*100,4) 回収率 from
(
select tenkou, count(*) *1000 toushi from races rc
where kaisaibi >= '2016/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
group by tenkou
) a
join
(
select tenkou, sum(pay) * 10 kaishuu from past_race_tekichuus prt
join race_pays rp
on prt.racecd = rp.racecd
and bakenKbn ="5"
join races rc
on prt.racecd = rc.racecd
where prt.version ="0.62"
and rc.kaisaibi >= '2016/01/01' and rc.kaisaibi <= '2016/12/31' and rc.raceRank between 3 and 9 and rc.babashurui <> 9
group by tenkou
) b
on a.tenkou = b.tenkou

/*月毎*/
select a.month, toushi, kaishuu, round(kaishuu/toushi*100,4) 回収率 from
(
select substring(rc.kaisaibi,6,2) month, count(*) *1000 toushi from races rc
where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
group by substring(rc.kaisaibi,6,2)
) a
join
(
select substring(rc.kaisaibi,6,2) month, sum(pay) * 10 kaishuu from past_race_tekichuus prt
join race_pays rp
on prt.racecd = rp.racecd
and bakenKbn ="5"
join races rc
on prt.racecd = rc.racecd
where prt.version ="0.62"
and rc.kaisaibi >= '2015/01/01' and rc.kaisaibi <= '2016/12/31' and rc.raceRank between 3 and 9 and rc.babashurui <> 9
group by substring(rc.kaisaibi,6,2)
) b
on a.month = b.month

/*月毎、レース毎*/
select a.month, a.raceRank, toushi, kaishuu, round(kaishuu/toushi*100,4) 回収率 from
(
select substring(rc.kaisaibi,6,2) month, rc.raceRank, count(*) *1000 toushi from races rc
where kaisaibi >= '2016/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
group by substring(rc.kaisaibi,6,2),rc.raceRank
) a
join
(
select substring(rc.kaisaibi,6,2) month, rc.raceRank, sum(pay) * 10 kaishuu from past_race_tekichuus prt
join race_pays rp
on prt.racecd = rp.racecd
and bakenKbn ="5"
join races rc
on prt.racecd = rc.racecd
where prt.version ="0.62"
and rc.kaisaibi >= '2016/01/01' and rc.kaisaibi <= '2016/12/31' and rc.raceRank between 3 and 9 and rc.babashurui <> 9
group by substring(rc.kaisaibi,6,2), rc.raceRank
) b
on a.month = b.month
and a.raceRank = b.raceRank


select count(*) from races where kaisaibi >= '2016/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9


/*芝→ダートの馬場替り*/
select
prs.umaCd
,prs.racecd
,prs.kaisaibi
,prs.babashurui
,prs.chakujun
,bfr.racecd
,bfr.kaisaibi
,bfr.babashurui
,bfr.chakujun
from
(
  select a.umaCd, a.racecd, a.kaisaibi, a.babashurui, a.chakujun, max(b.kaisaibi) zensouKaisaibi from
  (
    select rr.umaCd, rc.racecd, rc.kaisaibi, rc.babashurui, rr.chakujun from race_results rr
    join races rc
    on rr.racecd = rc.racecd
  ) a
  left join
  (
    select rr.umaCd, rc.racecd, rc.kaisaibi, rc.babashurui, rr.chakujun from race_results rr
    join races rc
    on rr.racecd = rc.racecd
  ) b
  on a.umaCd = b.umaCd
  and a.kaisaibi > b.kaisaibi
  group by a.umaCd, a.racecd, a.kaisaibi, a.babashurui, a.chakujun
) prs
join
(
  select rr.umaCd, rr.racecd, rr.chakujun, rc.kaisaibi, rc.babashurui
  from race_results rr
  join races rc
  on rr.racecd = rc.racecd
) bfr
on prs.umaCd = bfr.umaCd
and prs.zensouKaisaibi = bfr.kaisaibi
where prs.babashurui = 1
and bfr.babashurui = 0
and prs.kaisaibi >= "2010/01/01"
