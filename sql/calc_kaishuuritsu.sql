truncate table kaishuuritsus;

insert into kaishuuritsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
/*性別の回収率*/
select
  'sei',
  a.sei,
  round(kaishu/toushi, 4),
  now(),
  now()
from
(select
 sei
,sum(tanshou)*100 kaishu
from race_results
where chakujun = 1
group by sei ) a
join
(select
 sei
,count(*) * 100 toushi
from race_results
group by sei) b
on a.sei = b.sei
;

insert into kaishuuritsus
(
name,
rentaiProp,
rentai,
created_at,
updated_at
)
/*性別の月毎の回収率*/
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
,sum(tanshou)*100 kaishu
from race_results rr
join races rc
on rr.racecd = rc.racecd
where rr.chakujun = 1
group by substring(rc.kaisaibi,6,2), rr.sei ) a
join
(select
 rr.sei
,substring(rc.kaisaibi,6,2) month
,count(*) * 100 toushi
from race_results rr
join races rc
on rr.racecd = rc.racecd
group by substring(rc.kaisaibi,6,2), rr.sei) b
on a.sei = b.sei
and a.month = b.month
;

/*性別の馬場毎の回収率*/
insert into kaishuuritsus
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
,sum(tanshou)*100 kaishu
from race_results rr
join races rc
on rr.racecd = rc.racecd
where rr.chakujun = 1
group by rc.babashurui, rr.sei ) a
join
(select
 rr.sei
,rc.babashurui
,count(*) * 100 toushi
from race_results rr
join races rc
on rr.racecd = rc.racecd
group by rc.babashurui, rr.sei) b
on a.sei = b.sei
and a.babashurui = b.babashurui
;

/*年齢の回収率*/
insert into kaishuuritsus
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
,sum(tanshou)*100 kaishu
from race_results
where chakujun = 1
group by rei ) a
join
(select
 rei
,count(*)*100 toushi
from race_results
group by rei) b
on a.rei = b.rei
;

/*斤量の回収率*/
insert into kaishuuritsus
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
,sum(tanshou)*100 kaishu
from race_results
where chakujun = 1
group by kinryou ) a
join
(select
 kinryou
,count(*)*100 toushi
from race_results
group by kinryou) b
on a.kinryou = b.kinryou
;

/*馬体重の回収率*/
insert into kaishuuritsus
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
  ,sum(tanshou)*100  kaishu
  from race_results
  where chakujun = 1
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
   ,count(*) * 100 toushi
  from race_results
  group by bataijuu
  ) bb
group by bataijuu
) b
on a.bataijuu = b.bataijuu
;

/*場所、馬場毎の馬番回収率*/
insert into kaishuuritsus
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
round(b.cnt/a.cnt, 4),
now(),
now()
from
(
/*母数*/
select
 rc.bashoCd, rc.babashurui, rr.umaban ,count(*) *100 cnt
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
 rc.bashoCd, rc.babashurui, rr.umaban ,sum(rr.tanshou) * 100 as cnt
from race_results rr
join races rc
 on rc.racecd = rr.racecd
and rc.kaisaibi >= '2010/01/01'
and babashurui <> 9
where rr.chakujun = 1
group by rc.bashoCd, rc.babashurui, rr.umaban
) b
on a.bashoCd = b.bashoCd
and a.babashurui = b.babashurui
and a.umaban = b.umaban
;

/*場所、馬場毎、脚質毎の連対率*/
insert into kaishuuritsus
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
  kaishuuritsu,
  now(),
  now()
from (
  /*逃げ*/
  select
    t.bashoCd
    ,t.babashurui
    ,t.kyori
    ,round(IfNull(kaishuu,0)/toushi, 4) kaishuuritsu
    ,1 as kyakushitsu
  from
  (
    /*逃げ馬への投資額*/
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,count(*) * 100 as toushi
    from
    (
      /*逃げ馬の抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa <= 0.15
    ) target
    join races rc
    on target.racecd = rc.racecd
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) t
  left join
  (
    /*逃げ馬の回収額*/
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,sum(tanshou) * 100 as kaishuu
    from
    (
      /*逃げ馬の抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa <= 0.15
    ) target
    join races rc
    on target.racecd = rc.racecd
    join race_results rr
    on target.racecd = rr.racecd
    and target.umaCd = rr.umaCd
    and rr.chakujun = 1
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) k
  on t.bashoCd = k.bashoCd
  and t.babashurui = k.babashurui
  and t.kyori = k.kyori
  union all
  /*好位*/
  select
    t.bashoCd
    ,t.babashurui
    ,t.kyori
    ,round(IfNull(kaishuu,0)/toushi, 4) kaishuuritsu
    ,2 as kyakushitsu
  from
  (
    /*逃げ馬への投資額*/
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,count(*) * 100 as toushi
    from
    (
      /*逃げ馬の抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa > 0.15 and pa <= 0.30
    ) target
    join races rc
    on target.racecd = rc.racecd
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) t
  left join
  (
    /*逃げ馬の回収額*/
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,sum(tanshou) * 100 as kaishuu
    from
    (
      /*逃げ馬の抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa > 0.15 and pa <= 0.30
    ) target
    join races rc
    on target.racecd = rc.racecd
    join race_results rr
    on target.racecd = rr.racecd
    and target.umaCd = rr.umaCd
    and rr.chakujun = 1
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) k
  on t.bashoCd = k.bashoCd
  and t.babashurui = k.babashurui
  and t.kyori = k.kyori
  union all
  /*差し*/
  select
    t.bashoCd
    ,t.babashurui
    ,t.kyori
    ,round(IfNull(kaishuu,0)/toushi, 4) kaishuuritsu
    ,3 as kyakushitsu
  from
  (
    /*差しへの投資額*/
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,count(*) * 100 as toushi
    from
    (
      /*差しの抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa > 0.30 and pa <= 0.70
    ) target
    join races rc
    on target.racecd = rc.racecd
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) t
  left join
  (
    /*差しの回収額*/
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,sum(tanshou) * 100 as kaishuu
    from
    (
      /*差しの抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa > 0.30 and pa <= 0.70
    ) target
    join races rc
    on target.racecd = rc.racecd
    join race_results rr
    on target.racecd = rr.racecd
    and target.umaCd = rr.umaCd
    and rr.chakujun = 1
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) k
  on t.bashoCd = k.bashoCd
  and t.babashurui = k.babashurui
  and t.kyori = k.kyori
  union all
  /*追い込み*/
  select
    t.bashoCd
    ,t.babashurui
    ,t.kyori
    ,round(IfNull(kaishuu,0)/toushi, 4) kaishuuritsu
    ,4 as kyakushitsu
  from
  (
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,count(*) * 100 as toushi
    from
    (
      /*追い込みの抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa > 0.70
    ) target
    join races rc
    on target.racecd = rc.racecd
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) t
  left join
  (
    /*追い込みの回収額*/
    select
      rc.bashoCd
      ,rc.babashurui
      ,rc.kyori
      ,sum(tanshou) * 100 as kaishuu
    from
    (
      /*追い込みの抽出*/
      select
        umaCd,
        racecd,
        pa
      from (
        select
         rt.umaCd, rt.racecd, round(avg(rt.position/tousuu), 2) pa
        from rentaiba_tsuukas rt
        join races rc
        on rc.racecd = rt.racecd
        and rc.babashurui <> 9
        and rc.kaisaibi >= '2010/01/01'
        join race_tousuus racetousuu
        on rc.racecd = racetousuu.racecd
        group by rt.umaCd, rt.racecd
      ) a
      where pa > 0.70
    ) target
    join races rc
    on target.racecd = rc.racecd
    join race_results rr
    on target.racecd = rr.racecd
    and target.umaCd = rr.umaCd
    and rr.chakujun = 1
    group by rc.bashoCd ,rc.babashurui ,rc.kyori
  ) k
  on t.bashoCd = k.bashoCd
  and t.babashurui = k.babashurui
  and t.kyori = k.kyori
) a
;

/*種牡馬連対*/
insert into kaishuuritsus
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
  round(sum(rentaiCnt)/sum(cnt), 4) rentairitsu,
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
     count(*) * 100 cnt
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
   sum(tanshou)*100 rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     rr.tanshou,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun = 1
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
     count(*) * 100 cnt
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
   sum(tanshou)*100 rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     rr.tanshou,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun = 1
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
     count(*) * 100 cnt
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
   sum(tanshou)*100 rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     rr.tanshou,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun = 1
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
     count(*) * 100 cnt
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
   sum(tanshou)*100 rentaiCnt
  from (
    select
     rr.racecd,
     rc.bashoCd,
     rc.babashurui,
     rc.kyori,
     rr.chakujun,
     rr.tanshou,
     hb.bloedUmaCd
    from race_results rr
    join races rc
    on rr.racecd = rc.racecd
    and rc.kaisaibi >= '2010/01/01'
    and rc.babashurui <> 9
    and rr.chakujun = 1
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

/*性別、月ごとの回収率*/
insert into kaishuuritsus
(
  name,
  rentaiProp,
  rentai,
  created_at,
  updated_at
)
select
  "sei_month",
  concat(a.sei, '_', a.month),
  round(kaishuu/toushi,4),
  now(),
  now()
from (
    /*投資額*/
    select rr.sei, substring(rc.kaisaibi,6,2) month, count(*) *100 toushi from race_results rr
    join races rc
    on rc.racecd = rr.racecd
    and rc.kaisaibi >= '2010/01/01'
    group by rr.sei, substring(rc.kaisaibi,6,2)
  ) a
  join
  (
    /*回収額*/
    select rr.sei, substring(rc.kaisaibi,6,2) month, sum(rp.pay) kaishuu from race_results rr
    join race_pays rp
    on rr.racecd = rp.racecd
    and rp.bakenKbn =1
    join races rc
    on rc.racecd = rr.racecd
    and rc.kaisaibi >= '2010/01/01'
    where rr.chakujun = 1
    group by rr.sei, substring(rc.kaisaibi,6,2)
  ) b
  on a.sei = b.sei
  and a.month = b.month
;

/*人気毎、レースランクの回収率*/
insert into kaishuuritsus
(
  name,
  rentaiProp,
  rentai,
  created_at,
  updated_at
)
select
  "race_ninki",
  concat(a.raceRank, '_', a.ninki),
  ritsu,
  now(),
  now()
from (
  /*回収率*/
  select
   bosuu.ninki
   ,bosuu.raceRank
   ,round(kaishuu.kaishuu / bosuu.sougaku, 4) ritsu
  from
  (
  /*投資額*/
  select
   rr.ninki
   ,rc.raceRank
   ,count(*) * 100 sougaku
  from race_results rr
  join races rc
  on rr.racecd = rc.racecd
  where rc.kaisaibi >= '2000/01/01'
   and rc.babashurui <> 9
  group by rr.ninki,rc.raceRank
  ) bosuu
  join
  (
  /*回収率*/
  select
   rr.ninki
   ,rc.raceRank
   ,sum(tanshou) * 100 kaishuu
  from race_results rr
  join races rc
  on rr.racecd = rc.racecd
  where rr.chakujun = 1
   and rc.kaisaibi >= '2000/01/01'
   and rc.babashurui <> 9
  group by rr.ninki,rc.raceRank
  ) kaishuu
  on bosuu.ninki = kaishuu.ninki
  and bosuu.raceRank = kaishuu.raceRank
  order by bosuu.raceRank, bosuu.ninki
) a
;
