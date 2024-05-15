@AbapCatalog.sqlViewName: 'ZB2RPT77'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center Hierarchy'

define view ZB_RPT_77 as select from hrrp_directory as a inner join hrrp_node as b
on a.hryid  = b.hryid           and
   a.hryid  = 'H106/PSCO/PS_SS' and 
   a.hrycls = 'PSCO'            and 
   a.hrytyp = '0106'  

inner join hrrp_nodet as t on b.hryid    = t.hryid          and
                              b.hryver   = t.hryver         and
                              b.nodecls  = t.nodecls        and
                              b.parnode  = t.hrynode        and
                              b.hrytype  = t.hrytyp         and
                              t.hryid    = 'H106/PSCO/PS_SS' and
                              t.nodetxt  <> ''              and
                              t.spras    = 'E'  
                                        
inner join cepc on b.nodevalue = cepc.prctr and
                  cepc.segment = 'PS_STORAGE'                                 
                                                                                      
{
    key a.hryid   as  HierarchyId,
    a.hrycls      as  HierarchyClass,
    b.parnode     as  HierarchyParentNode,  
    b.nodetype    as  NodeType,
    b.nodevalue   as  NodeValue,
    case when b.nodevalue = '16218Z' then 'Third Party Facilities'
         when b.nodevalue = '16219Z' then 'Canadian Facilities' 
         when b.nodevalue = '16217Z' then 'Savvy Storage Insurance Program'
         else t.nodetxt end as Facilities,
  //  t.nodetxt     as  Facilities,
    t.hrynode     as  HryNode,
    cepc.segment  as  Storage,
    cepc.ort01    as  Location,
    cepc.prctr    as  ProfitCenter    

}
