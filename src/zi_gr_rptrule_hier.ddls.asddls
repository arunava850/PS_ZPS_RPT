@AbapCatalog.sqlViewName: 'ZIGRPTRULEHIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Group Reporting Rule Hierarchy'
define view ZI_GR_RPTRULE_HIER 
with parameters
p_coa : fc_itclg 
as select distinct from 
fincs_ri_dt as a
join fincs_fsitem as b on a.itclg = b.itclg and
                          b.item between a.item_fr and a.item_to
 {
 a.itclg,
 a.rihry, 
 a.rptid,
 a.ritem,
 a.ithry,
 a.itemnode,
 a.item_fr,
 a.item_to, 
 a.revsign,
 cast(case  
   when a.revsign = 'X' then -1 
   else 1
  end as abap.int2) as zsign,
  b.item 
}
where a.item_fr <> '' and a.ithry = ''
union all
select distinct from 
fincs_ri_dt as a
join ZI_GR_HIER_CATG(p_coa : $parameters.p_coa) as b on a.ithry = b.hier_hid
join hrrp_node as c on b.ZHIER_HID = c.hryid and
                         a.itemnode   = c.parnode
join fincs_fsitem as d on a.itclg = d.itclg and
                          c.hrynode = d.item
 {
  a.itclg,
 a.rihry, 
 a.rptid,
 a.ritem,
 a.ithry,
 a.itemnode,
 a.item_fr,
 a.item_to, 
 a.revsign,
 cast(case  
   when a.revsign = 'X' then -1 
   else 1
  end as abap.int2) as zsign,
 d.item 
}
where a.item_fr = '' and a.ithry <> '' and c.nodetype = 'D'

