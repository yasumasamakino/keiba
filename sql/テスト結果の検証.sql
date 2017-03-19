/*払い戻し全て*/
select
*
from (
  select
   distinct racecd
  from past_race_tekichuus
  where version = '0.81_test'
) racecds
join
(
  select
   racecd
   ,pay
  from race_pays
  where bakenKbn = 5
) pays
on racecds.racecd = pays.racecd

/*払い戻し全て*/
select
*
from (
  select
   distinct racecd
  from past_race_tekichuus
  where version = '0.81_test'
) racecds
join
(
  select
   racecd
   ,pay
   ,ninki
  from race_pays
  where bakenKbn = 5
) pays
on racecds.racecd = pays.racecd
order by pay


/*レース数毎の回収率*/
select
 a.raceNo
 ,toushi
 ,kaishuu
 ,round(kaishuu/toushi, 4) kaishuuritsu
from (
  select
   substring(racecds.racecd,11,2) raceNo
   ,sum(pay) kaishuu
  from (
    select
     distinct racecd
    from past_race_tekichuus
    where version = '0.84_test'
  ) racecds
  join
  (
    select
     racecd
     ,pay
    from race_pays
    where bakenKbn = 5
  ) pays
  on racecds.racecd = pays.racecd
  group by substring(racecds.racecd,11,2)
) a
join (
  select
   count(*) * 100 as toushi
   ,substring(racecd,11,2) raceNo
  from races where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
  group by substring(racecd,11,2)
) b
on a.raceNo = b.raceNo

/*レース数毎の的中率*/
select
 a.raceNo
 ,toushi
 ,tekichuu
 ,round(tekichuu/toushi, 4) tekichuuritsu
from (
  select
   substring(racecds.racecd,11,2) raceNo
   ,count(*) tekichuu
  from (
    select
     distinct racecd
    from past_race_tekichuus
    where version = '0.84_test'
  ) racecds
  group by substring(racecds.racecd,11,2)
) a
join (
  select
   count(*) as toushi
   ,substring(racecd,11,2) raceNo
  from races where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
  group by substring(racecd,11,2)
) b
on a.raceNo = b.raceNo


/*レースランク毎の回収率*/
select
 a.raceRank
 ,toushi
 ,kaishuu
 ,round(kaishuu/toushi, 4) kaishuuritsu
from (
  select
   raceRank
   ,sum(pay) kaishuu
  from (
    select
     distinct racecd
    from past_race_tekichuus
    where version = '0.84_test'
  ) racecds
  join
  (
    select
     racecd
     ,pay
    from race_pays rp
    where bakenKbn = 5
  ) pays
  on racecds.racecd = pays.racecd
  join races rc
  on racecds.racecd = rc.racecd
  group by rc.raceRank
) a
join (
  select
   count(*) * 100 as toushi
   ,raceRank
  from races where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
  group by raceRank
) b
on a.raceRank = b.raceRank

/*レースランク毎の的中率*/
select
 a.raceRank
 ,toushi
 ,tekichuu
 ,round(tekichuu/toushi, 4) tekichuuritsu
from (
  select
   raceRank
   ,count(*) tekichuu
  from (
    select
     distinct racecd
    from past_race_tekichuus
    where version = '0.81_test'
  ) racecds
  join races rc
  on racecds.racecd = rc.racecd
  group by rc.raceRank
) a
join (
  select
   count(*) as toushi
   ,raceRank
  from races where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
  group by raceRank
) b
on a.raceRank = b.raceRank

/*場所毎の回収率*/
select
 a.bashoCd
 ,toushi
 ,kaishuu
 ,round(kaishuu/toushi, 4) kaishuuritsu
from (
  select
   bashoCd
   ,sum(pay) kaishuu
  from (
    select
     distinct racecd
    from past_race_tekichuus
    where version = '0.84_test'
  ) racecds
  join
  (
    select
     racecd
     ,pay
    from race_pays rp
    where bakenKbn = 5
  ) pays
  on racecds.racecd = pays.racecd
  join races rc
  on racecds.racecd = rc.racecd
  group by rc.bashoCd
) a
join (
  select
   count(*) * 100 as toushi
   ,bashoCd
  from races where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
  group by bashoCd
) b
on a.bashoCd = b.bashoCd

/*場所毎の的中率*/
select
 a.bashoCd
 ,toushi
 ,tekichuu
 ,round(tekichuu/toushi, 4) tekichuuritsu
from (
  select
   bashoCd
   ,count(*) tekichuu
  from (
    select
     distinct racecd
    from past_race_tekichuus
    where version = '0.84_test'
  ) racecds
  join races rc
  on racecds.racecd = rc.racecd
  group by rc.bashoCd
) a
join (
  select
   count(*) as toushi
   ,bashoCd
  from races where kaisaibi >= '2015/01/01' and kaisaibi <= '2016/12/31' and raceRank between 3 and 9 and babashurui <> 9
  group by bashoCd
) b
on a.bashoCd = b.bashoCd


select a.kishuCd, toushi, kaishu, round(kaishu/toushi,4) as kaishuritsu from
(/*投資金額*/"
select kishuCd, count(*)*100 as toushi from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '2015/01/01' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='00422' group by kishuCd) a
join (/*回収金額*/
select kishuCd, sum(tanshou)*100 as kaishu from race_results rr join races rc on rr.racecd = rc.racecd and rc.kaisaibi >= '2015/01/01' and rc.kaisaibi <= '{$kaisaibi}' and kishuCd ='00422' where chakujun =1 group by kishuCd) b
on a.kishuCd = b.kishuCd
