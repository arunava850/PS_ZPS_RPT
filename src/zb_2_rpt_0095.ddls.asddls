@AbapCatalog.sqlViewName: 'ZB2RPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center Hierarchy'

define view ZB_2_RPT_0095 as select from hrrp_directory as a inner join hrrp_node as b
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
    t.nodetxt     as  Facilities,
    t.hrynode     as  HryNode,
    cepc.segment  as  Segment,
    cepc.ort01    as  Location,
    cepc.prctr    as  ProfitCenter    

}
