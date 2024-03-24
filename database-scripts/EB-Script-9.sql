CREATE OR REPLACE VIEW eb_schema.partydonorsummary_view
AS select *
from (
        select p."party-name" as partyName, epm."donorName"  as purchaser,  sum(p.denominations) as Amount, count(*) as Tx, 0 as TotalAmount, 0 as TotalTx
        from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d, eb_schema.eb_purchaser_map epm
        where
        p.prefix = d.prefix
        and p."bond-number" = d."bond-number"
        and d.purchaser = epm.purchaser
        group by p."party-name", epm."donorName"
        union all
        select p."party-name" as partyName, 'ZZZ.Total' as purchaser,  0 as Amount, 0 as Tx, sum(p.denominations) as TotalAmount, count(*) as TotalTx
        from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
        where
        p.prefix = d.prefix
        and p."bond-number" = d."bond-number"
        group by p."party-name"
) as combinedData
order by partyName, Amount desc;

select * from eb_schema.partydonorsummary_view;

select p."party-name" as partyName, d.purchaser as purchaser, d."purchase-date", p."encashment-date",  d."issue-branch-code", d.prefix, d."bond-number",  p.denominations as Amount, d."reference-no-urn", d."issue-teller"
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d
where
p.prefix = d.prefix
and p."bond-number" = d."bond-number"
order by partyName, purchaser, "purchase-date"; 

select p."party-name" as partyName, epm."donorName" as purchaser, d."purchase-date", p."encashment-date",  d."issue-branch-code", d.prefix, d."bond-number",  p.denominations as Amount, d."reference-no-urn", d."issue-teller"
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d, eb_schema.eb_purchaser_map epm
where
p.prefix = d.prefix
and p."bond-number" = d."bond-number"
and d.purchaser = epm.purchaser
order by partyName, purchaser, "purchase-date";


CREATE OR REPLACE VIEW eb_schema.partydonordetails_view
as select p."party-name" as partyName, epm."donorName" as purchaser, d."purchase-date", p."encashment-date",  d."issue-branch-code", d.prefix, d."bond-number",  p.denominations as Amount, d."reference-no-urn", d."issue-teller"
from eb_schema.eb_parties_tx p, eb_schema.eb_purchaser_tx d, eb_schema.eb_purchaser_map epm
where
p.prefix = d.prefix
and p."bond-number" = d."bond-number"
and d.purchaser = epm.purchaser
order by partyName, purchaser, "purchase-date"; 

select * from eb_schema.partydonordetails_view pv;
