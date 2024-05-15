@AbapCatalog.sqlViewName: 'ZBRPT0086'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0086 - Basic View (Profit Center Hier)'

define view ZB_RPT_0086 as select from hrrp_directory as a inner join hrrp_node as b
on a.hryid  = b.hryid            and
   a.hryid  = 'H109/PSUS/EQUITY' and 
   a.hrycls = 'PSUS'             and 
   a.hrytyp = 'FSVN'                     
     
inner join hrrp_nodet as c on c.spras = 'E'              and
                                   b.hryid   = c.hryid   and
                                   b.hryver  = c.hryver  and
                                   b.nodecls = c.nodecls and
                                   b.parnode = c.parnode and
                                   b.hrytype = c.hrytyp                                                               

{
    key a.hryid         as HierarchyId,
    b.parnode           as ParNode,
    c.nodetxt           as Equity,
    b.nodevalue         as NodeValue,
    b.leafvalue
      
    
}

        
