delete  from eb_schema.eb_purchaser_map ;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

insert into  eb_schema.eb_purchaser_map (uuid, purchaser, donarName)
SELECT UUID_GENERATE_V4(), purchaser, purchaser
FROM (
	select distinct purchaser
	from eb_schema.eb_purchaser_tx
	order by purchaser
) as uniquePurchasers;


select * from eb_purchaser_map epm 
order by purchaser;

insert into eb_schema.eb_purchaser_m (donorid, donorName)
select UUID_GENERATE_V4(), donorname 
from (
	select distinct p."donorName" as donorname
	from eb_schema.eb_purchaser_map p
	order by p."donorName" 
) as uniqueDonors

update eb_schema.eb_purchaser_map as p 
set donorid = d.donorid 
from eb_schema.eb_purchaser_m as d
where p."donorName" = d.donorname 
