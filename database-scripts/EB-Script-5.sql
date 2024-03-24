SELECT sno, "reference-no-urn", "journal-date", "purchase-date", "expiry-date", purchaser, prefix, "bond-number", denominations, "issue-branch-code", "issue-teller", status, "1", "00001201904120000001166", "12/Apr/2019"
FROM eb_schema.eb_purchaser_tx;

select purchaser, sum(denominations) as total
FROM eb_schema.eb_purchaser_tx
group by purchaser 
order by total desc;

select count(*) 
from eb_schema.eb_purchaser_tx 

select purchaser, prefix, "bond-number",  count(*) as Records, sum(denominations) as Total 
from eb_schema.eb_purchaser_tx 
group by purchaser, prefix, "bond-number"  
order by purchaser, prefix, "bond-number" 

select purchaser, prefix, "bond-number",  count(*) as Records, sum(denominations) as Total 
from eb_schema.eb_purchaser_tx 
group by purchaser, prefix, "bond-number"  
having count(*) > 1
order by purchaser, prefix, "bond-number"  

select status, count(*) as Records, sum(denominations) as Total 
from eb_schema.eb_purchaser_tx 
group by status

select count(*)
from eb_schema.eb_purchaser_tx 


select purchaser,sno,  "purchase-date" , prefix, "bond-number", denominations, "issue-branch-code", "issue-teller", status 
from eb_schema.eb_purchaser_tx ep 
where "bond-number" IN ('20048', '20001', '11476', '11484', '11487', '20025') 

"20029", "20033", "20035", "15601", "15603", "20011", '20013', '20015', '20017')
