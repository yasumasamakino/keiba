--人気別回収率（単勝）
select
round(1ban.pay / a.pay, 4) as 1ban,
round(2ban.pay / a.pay, 4) as 2ban,
round(3ban.pay / a.pay, 4) as 3ban,
round(4ban.pay / a.pay, 4) as 4ban,
round(5ban.pay / a.pay, 4) as 5ban,
round(6ban.pay / a.pay, 4) as 6ban,
round(7ban.pay / a.pay, 4) as 7ban,
round(9ban.pay / a.pay, 4) as 8ban,
round(10ban.pay / a.pay, 4) as 10ban,
round(11ban.pay / a.pay, 4) as 11ban,
round(12ban.pay / a.pay, 4) as 12ban,
round(13ban.pay / a.pay, 4) as 13ban,
round(14ban.pay / a.pay, 4) as 14ban,
round(15ban.pay / a.pay, 4) as 15ban,
round(16ban.pay / a.pay, 4) as 16ban,
round(17ban.pay / a.pay, 4) as 17ban,
round(18ban.pay / a.pay, 4) as 18ban
from
(
select
count(*) * 100 as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
) a
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 1
) 1ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 2
) 2ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 3
) 3ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 4
) 4ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 5
) 5ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 6
) 6ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 7
) 7ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 8
) 8ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 9
) 9ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 10
) 10ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 11
) 11ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 12
) 12ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 13
) 13ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 14
) 14ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 15
) 15ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 16
) 16ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 17
) 17ban
,
(select
sum(REPLACE(pay,",","")) as pay
from race_pay_raws pay
join races race
on pay.racecd = race.racecd
and pay.bakenName = "単勝"
and race.babashurui <> 9
and pay.ninki not like "%|%"
and pay.ninki = 18
) 18ban
;
