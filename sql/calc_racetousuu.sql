truncate table race_tousuus;

insert into race_tousuus
(
racecd,
tousuu,
created_at,
updated_at
)
select
 racecd,
 count(*) tousuu,
 now(),
 now()
from race_results group by racecd
;
