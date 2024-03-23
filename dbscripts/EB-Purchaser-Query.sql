select p."party-name" , d.purchaser, p."encashment-date", p."bond-number", p.denominations  
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where p."bond-number" = d."bond-number" 
and p."party-name" like 'AAM AADMI PARTY'
order by p."party-name" , d.purchaser, p."encashment-date" asc

select p."party-name" , d.purchaser, p."encashment-date", p."bond-number", p.denominations  
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where p."bond-number" = d."bond-number" 
and p."party-name" like 'AAM AADMI PARTY'
order by p."party-name" , d.purchaser, p."encashment-date" asc


select p."party-name" , p."encashment-date", p."bond-number", p.denominations  
from eb_schema.eb_parties_tx p
where p."party-name" like 'AAM AADMI PARTY'
order by p."party-name" asc

select p."party-name" ,  sum(p.denominations) as Total, count(*) as Records 
from eb_schema.eb_parties_tx p
where p."party-name" like 'AAM AADMI PARTY'
group by p."party-name" 
order by p."party-name" asc

select p."party-name" ,  sum(p.denominations) as Total, count(*) as Records, 'Yes' as matched  
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where
p.prefix = d.prefix 
and p."bond-number" = d."bond-number" 
and p."party-name" like 'AAM AADMI PARTY'
group by p."party-name"
union all
select p."party-name" ,  sum(p.denominations) as Total, count(*) as Records, 'All' as matched
from eb_schema.eb_parties_tx p
where
p."party-name" like 'AAM AADMI PARTY'
group by p."party-name"

select *
from (
	select p."party-name" as partyName,  sum(p.denominations) as Total, count(*) as Records, 'Linked' as matched  
	from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
	where
	p.prefix = d.prefix 
	and p."bond-number" = d."bond-number" 
	group by p."party-name"
	union All
	select p."party-name" as partyName,  sum(p.denominations) as Total, count(*) as Records, 'All' as matched
	from eb_schema.eb_parties_tx p
	group by p."party-name"
) as combinedData
order by partyName, matched

select partyName, Linked, Total, LinkedRecords, AllRecords, allrecords-linkedrecords as missing
from (
	select partyName, sum(Linked) as Linked, sum(Total) as Total, sum(LinkedRecords) as LinkedRecords, sum(AllRecords) as AllRecords
	from (
		select p."party-name" as partyName,  sum(p.denominations) as Linked, 0 as Total, count(*) as LinkedRecords, 0 as AllRecords  
		from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
		where
		p.prefix = d.prefix 
		and p."bond-number" = d."bond-number" 
		group by p."party-name"
		union All
		select p."party-name" as partyName,  0 as Linked, sum(p.denominations) as Total, 0 as LinkedRecords, count(*) as AllRecords
		from eb_schema.eb_parties_tx p
		group by p."party-name"
	) as combinedData
	group by partyName
) as missingData
order by partyName



select p."party-name" , d.purchaser,  sum(p.denominations) as Total, count(*) as Records
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where p."bond-number" = d."bond-number" 
group by p."party-name", d.purchaser 
order by p."party-name" , d.purchaser asc
