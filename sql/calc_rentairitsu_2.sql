truncate table rentairitsus;

/*牡牝の連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
  'sei',
  a.sei,
  round(kaishu/toushi, 4),
  now(),
  now()
from
(select
 sei
,count(*) kaishu
from race_results
where chakujun between 1 and 2
group by sei ) a
join
(select
 sei
,count(*) toushi
from race_results
group by sei) b
on a.sei = b.sei
;

/*牡牝の月毎の連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
  'sei_month',
  concat(a.sei, '_',a.month),
  round(kaishu/toushi, 4),
  now(),
  now()
from
(select
 rr.sei
 ,substring(rc.kaisaibi,6,2) month
,count(*) kaishu
from race_results rr
join races rc
on rr.racecd = rc.racecd
where rr.chakujun between 1 and 2
group by sei, substring(rc.kaisaibi,6,2) ) a
join
(select
 rr.sei
 ,substring(rc.kaisaibi,6,2) month
,count(*) toushi
from race_results rr
join races rc
on rr.racecd = rc.racecd
group by sei, substring(rc.kaisaibi,6,2) ) b
on a.sei = b.sei
and a.month = b.month
;

/*牡牝の馬場毎の連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
  'sei_babashurui',
  concat(a.sei, '_',a.babashurui),
  round(kaishu/toushi, 4),
  now(),
  now()
from
(select
 rr.sei
 ,rc.babashurui
,count(*) kaishu
from race_results rr
join races rc
on rr.racecd = rc.racecd
where rr.chakujun between 1 and 2
group by sei, rc.babashurui ) a
join
(select
 rr.sei
 ,rc.babashurui
,count(*) toushi
from race_results rr
join races rc
on rr.racecd = rc.racecd
group by sei, rc.babashurui ) b
on a.sei = b.sei
and a.babashurui = b.babashurui
;

/*年齢の連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
 'rei',
 a.rei,
 round(kaishu/toushi, 4),
 now(),
 now()
from
(select
 rei
,count(*) kaishu
from race_results
where chakujun between 1 and 2
group by rei ) a
join
(select
 rei
,count(*) toushi
from race_results
group by rei) b
on a.rei = b.rei
;

/*斤量の連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
 'kinryou',
 cast(a.kinryou AS DECIMAL(3,1)),
 round(kaishu/toushi, 4),
 now(),
 now()
from
(select
 kinryou
,count(*) kaishu
from race_results
where chakujun between 1 and 2
group by kinryou ) a
join
(select
 kinryou
,count(*) toushi
from race_results
group by kinryou) b
on a.kinryou = b.kinryou
;

/*馬体重の連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
 'bataijuu',
 a.bataijuu,
 round(kaishu/toushi, 4),
 now(),
 now()
from
(
select
 bataijuu
 ,sum(kaishu) kaishu
from (
  select
  round(bataijuu,-1) as bataijuu
  ,count(*)  kaishu
  from race_results
  where chakujun between 1 and 2
  group by bataijuu
  ) aa
group by bataijuu
) a
join
(
select
 bataijuu
 ,sum(toushi) toushi
from (
  select
   round(bataijuu,-1) as bataijuu
   ,count(*) toushi
  from race_results
  group by bataijuu
  ) bb
group by bataijuu
) b
on a.bataijuu = b.bataijuu
;

/*調教師連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
 "choukyoushi_babashurui",
 concat(a.choukyoushiCd, '_',a.babashurui),
 case when toushi >= 20 then
  round(kaishu/toushi, 4)
 else
  0.15
 end rentai,
 now(),
 now()
from
(select
 rr.choukyoushiCd
 ,rc.babashurui
,count(*) kaishu
from race_results rr
join races rc
on rr.racecd = rc.racecd
where rr.chakujun between 1 and 2
group by rr.choukyoushiCd,rc.babashurui ) a
join
(select
 rr.choukyoushiCd
 ,rc.babashurui
 ,count(*) toushi
from race_results rr
join races rc
on rr.racecd = rc.racecd
group by rr.choukyoushiCd,rc.babashurui) b
on a.choukyoushiCd = b.choukyoushiCd
and a.babashurui = b.babashurui
;

/*場所、馬場毎の馬番連対率*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
'umaban',
concat(a.bashoCd, '_',a.babashurui, '_', a.umaban),
round(b.cnt/a.cnt, 4) as rentairitsu,
now(),
now()
from
(
/*母数*/
select
 rc.bashoCd, rc.babashurui, rr.umaban ,count(*) cnt
from race_results rr
join races rc
 on rc.racecd = rr.racecd
and rc.kaisaibi >= '2010/01/01'
and babashurui <> 9
group by rc.bashoCd, rc.babashurui, rr.umaban
) a
join
(
/*連対馬*/
select
 rc.bashoCd, rc.babashurui, rr.umaban ,count(*) cnt
from race_results rr
join races rc
 on rc.racecd = rr.racecd
and rc.kaisaibi >= '2010/01/01'
and babashurui <> 9
where rr.chakujun between 1 and 2
group by rc.bashoCd, rc.babashurui, rr.umaban
) b
on a.bashoCd = b.bashoCd
and a.babashurui = b.babashurui
and a.umaban = b.umaban
;

/*場所、馬場毎、脚質毎の連対率*/
/*逃げ*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
'kyakushitsu',
concat(bashoCd, '_', a.kyori, '_', a.babashurui, '_', kyakushitsu),
rentairitsu,
now(),
now()
from (
  select a.bashoCd, a.babashurui, a.kyori, round(b.cnt/a.cnt, 4) as rentairitsu, 1 as kyakushitsu from
  (
    /*逃げの母数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join race_tousuus racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa <= 0.15
    group by bashoCd, babashurui, kyori
  ) a
  join
  (
    /*逃げの連対数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join race_tousuus racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa <= 0.15
     and chakujun between 1 and 2
    group by bashoCd, babashurui, kyori
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  union all
  /*好位*/
  select a.bashoCd, a.babashurui, a.kyori, round(b.cnt/a.cnt, 4), 2 from
  (
    /*好位の母数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join race_tousuus racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa > 0.15 and pa <= 0.30
    group by bashoCd, babashurui, kyori
  ) a
  join
  (
    /*好位の連対数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join (select racecd, count(*) tousuu from race_results group by racecd) racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa > 0.15 and pa <= 0.30
     and chakujun between 1 and 2
    group by bashoCd, babashurui, kyori
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  union all
  /*中団*/
  select a.bashoCd, a.babashurui, a.kyori, round(b.cnt/a.cnt, 4), 3 from
  (
    /*中団の母数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join (select racecd, count(*) tousuu from race_results group by racecd) racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa > 0.30 and pa <= 0.70
    group by bashoCd, babashurui, kyori
  ) a
  join
  (
    /*中団の連対数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join (select racecd, count(*) tousuu from race_results group by racecd) racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa > 0.30 and pa <= 0.70
     and chakujun between 1 and 2
    group by bashoCd, babashurui, kyori
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  union all
  /*後方*/
  select a.bashoCd, a.babashurui, a.kyori, round(b.cnt/a.cnt, 4), 4 from
  (
    /*後方の母数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join (select racecd, count(*) tousuu from race_results group by racecd) racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa > 0.70
    group by bashoCd, babashurui, kyori
  ) a
  join
  (
    /*後方の連対数*/
    select
     bashoCd, babashurui, kyori, count(*) cnt
    from (
      select
       rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.babashurui, rt.chakujun, round(avg(rt.position/tousuu), 2) as pa
      from rentaiba_tsuukas rt
      join races rc
      on rt.racecd = rc.racecd
      join (select racecd, count(*) tousuu from race_results group by racecd) racetousuu
      on rc.racecd = racetousuu.racecd
      where rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      group by rt.umaCd, rt.racecd, rc.bashoCd, rc.kyori, rt.chakujun, rt.babashurui
    ) a
    where pa > 0.70
     and chakujun between 1 and 2
    group by bashoCd, babashurui, kyori
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  order by bashoCd, babashurui, kyakushitsu, kyori
) a
;

/*種牡馬連対*/
insert into rentairitsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
select
  "bloed_f", /*父(father)のf*/
  concat(a.bashoCd, '_', a.babashurui, '_', a.kyori, '_', a.bloedUmaCd),
  round(sum(rentaiCnt)/sum(cnt), 4),
  now(),
  now()
from (
  /*父親*/
  select
    a.bashoCd,
    a.babashurui,
    a.kyori,
    a.bloedUmaCd,
    cnt,
    rentaiCnt
  from
  (
    /*出走馬の父親*/
    select
     bashoCd,
     babashurui,
     kyori,
     bloedUmaCd,
     count(*) cnt
    from (
      select
       rr.racecd,
       rc.bashoCd,
       rc.babashurui,
       rc.kyori,
       rr.chakujun,
       hb.bloedUmaCd
      from race_results rr
      join races rc
      on rr.racecd = rc.racecd
      and rc.babashurui <> 9
      and rc.kaisaibi >= '2010/01/01'
      join horse_bloeds hb
      on rr.umaCd = hb.umaCd
      and hb.sedai = 1
      and hb.parentKbn = 0
    ) a
    group by
      bashoCd,
      babashurui,
      kyori,
      bloedUmaCd
  ) a
  join
  (
  /*連対馬の父親*/
  select
   bashoCd,
   babashurui,
   kyori,
   bloedUmaCd,
   count(*) rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun between 1 and 2
    join horse_bloeds hb
    on rr.umaCd = hb.umaCd
    and hb.sedai = 1
    and hb.parentKbn = 0
  ) a
  group by
    bashoCd,
    babashurui,
    kyori,
    bloedUmaCd
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  and a.bloedUmaCd = b.bloedUmaCd
  union all
  /*祖父*/
  select
    a.bashoCd,
    a.babashurui,
    a.kyori,
    a.bloedUmaCd,
    cnt,
    rentaiCnt
  from
  (
    /*出走馬の祖父*/
    select
     bashoCd,
     babashurui,
     kyori,
     bloedUmaCd,
     count(*) cnt
    from (
      select
       rr.racecd,
       rc.bashoCd,
       rc.babashurui,
       rc.kyori,
       rr.chakujun,
       hb.bloedUmaCd
      from race_results rr
      join races rc
      on rr.racecd = rc.racecd
      and rc.kaisaibi >= '2010/01/01'
      and rc.babashurui <> 9
      join horse_bloeds hb
      on rr.umaCd = hb.umaCd
      and hb.sedai = 2
      and hb.parentKbn = 0
    ) a
    group by
      bashoCd,
      babashurui,
      kyori,
      bloedUmaCd
  ) a
  join
  (
  /*連対馬の祖父*/
  select
   bashoCd,
   babashurui,
   kyori,
   bloedUmaCd,
   count(*) rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun between 1 and 2
    join horse_bloeds hb
    on rr.umaCd = hb.umaCd
    and hb.sedai = 2
    and hb.parentKbn = 0
  ) a
  group by
    bashoCd,
    babashurui,
    kyori,
    bloedUmaCd
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  and a.bloedUmaCd = b.bloedUmaCd
  union all
  /*曽祖父*/
  select
    a.bashoCd,
    a.babashurui,
    a.kyori,
    a.bloedUmaCd,
    cnt,
    rentaiCnt
  from
  (
    /*出走馬の曽祖父*/
    select
     bashoCd,
     babashurui,
     kyori,
     bloedUmaCd,
     count(*) cnt
    from (
      select
       rr.racecd,
       rc.bashoCd,
       rc.babashurui,
       rc.kyori,
       rr.chakujun,
       hb.bloedUmaCd
      from race_results rr
      join races rc
      on rr.racecd = rc.racecd
      and rc.kaisaibi >= '2010/01/01'
      and rc.babashurui <> 9
      join horse_bloeds hb
      on rr.umaCd = hb.umaCd
      and hb.sedai = 3
      and hb.parentKbn = 0
    ) a
    group by
      bashoCd,
      babashurui,
      kyori,
      bloedUmaCd
  ) a
  join
  (
  /*連対馬の曽祖父*/
  select
   bashoCd,
   babashurui,
   kyori,
   bloedUmaCd,
   count(*) rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun between 1 and 2
    join horse_bloeds hb
    on rr.umaCd = hb.umaCd
    and hb.sedai = 3
    and hb.parentKbn = 0
  ) a
  group by
    bashoCd,
    babashurui,
    kyori,
    bloedUmaCd
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  and a.bloedUmaCd = b.bloedUmaCd
  union all
  /*曽祖父の父*/
  select
    a.bashoCd,
    a.babashurui,
    a.kyori,
    a.bloedUmaCd,
    cnt,
    rentaiCnt
  from
  (
    /*出走馬の曽祖父の父*/
    select
     bashoCd,
     babashurui,
     kyori,
     bloedUmaCd,
     count(*) cnt
    from (
      select
       rr.racecd,
       rc.bashoCd,
       rc.babashurui,
       rc.kyori,
       rr.chakujun,
       hb.bloedUmaCd
      from race_results rr
      join races rc
      on rr.racecd = rc.racecd
      and rc.kaisaibi >= '2010/01/01'
      and rc.babashurui <> 9
      join horse_bloeds hb
      on rr.umaCd = hb.umaCd
      and hb.sedai = 4
      and hb.parentKbn = 0
    ) a
    group by
      bashoCd,
      babashurui,
      kyori,
      bloedUmaCd
  ) a
  join
  (
  /*連対馬の曽祖父の父*/
  select
   bashoCd,
   babashurui,
   kyori,
   bloedUmaCd,
   count(*) rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun between 1 and 2
    join horse_bloeds hb
    on rr.umaCd = hb.umaCd
    and hb.sedai = 4
    and hb.parentKbn = 0
  ) a
  group by
    bashoCd,
    babashurui,
    kyori,
    bloedUmaCd
  ) b
  on a.bashoCd = b.bashoCd
  and a.babashurui = b.babashurui
  and a.kyori = b.kyori
  and a.bloedUmaCd = b.bloedUmaCd
) a
group by
  a.bashoCd,
  a.babashurui,
  a.kyori,
  a.bloedUmaCd
;
