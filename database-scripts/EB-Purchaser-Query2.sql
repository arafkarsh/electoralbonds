select partyName, Linked, Total, total-linked as missingValue, LinkedRecords, AllRecords, allrecords-linkedrecords as missing
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


select p."party-name" as partyName, sum(p.denominations) as Linked, count(*) as LinkedRecords
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where
p.prefix = d.prefix 
and p."bond-number" = d."bond-number" 
group by p."party-name"
order by p."party-name" 

select p."party-name" as partyName, d.purchaser as purchaser,  sum(p.denominations) as Linked, count(*) as LinkedRecords
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where
p.prefix = d.prefix 
and p."bond-number" = d."bond-number" 
and p."party-name" like 'AAM AADMI PARTY'
group by p."party-name", d.purchaser 
union all
select p."party-name" as partyName, 'Total' as purchaser,  sum(p.denominations) as Linked, count(*) as LinkedRecords
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where
p.prefix = d.prefix 
and p."bond-number" = d."bond-number" 
and p."party-name" like 'AAM AADMI PARTY'
group by p."party-name"

select *
from (
	select p."party-name" as partyName, d.purchaser as purchaser,  sum(p.denominations) as Amount, count(*) as Tx, 0 as TotalAmount, 0 as TotalTx
	from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
	where
	p.prefix = d.prefix 
	and p."bond-number" = d."bond-number" 
	group by p."party-name", d.purchaser 
	union all
	select p."party-name" as partyName, 'ZZZ.Total' as purchaser,  0 as Amount, 0 as Tx, sum(p.denominations) as TotalAmount, count(*) as TotalTx
	from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
	where
	p.prefix = d.prefix 
	and p."bond-number" = d."bond-number" 
	group by p."party-name"
) as combinedData
order by partyName, Amount desc


with TopDonors as (
	select p."party-name" as partyName, d.purchaser as purchaser,  sum(p.denominations) as Amount, count(*) as Tx
	from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
	where
	p.prefix = d.prefix 
	and p."bond-number" = d."bond-number" 
	group by p."party-name", d.purchaser 
	order by  p."party-name", Amount desc	
} 

select p."party-name" as partyName, d.purchaser as purchaser, d."purchase-date", p."encashment-date",  d."issue-branch-code", d.prefix, d."bond-number",  p.denominations as Amount, d."reference-no-urn", d."issue-teller"  
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where
p.prefix = d.prefix 
and p."bond-number" = d."bond-number" 
order by partyName, purchaser

