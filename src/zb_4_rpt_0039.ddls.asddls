@AbapCatalog.sqlViewName: 'ZB4RPT0039'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0039 - Basic View (PSSS Hier)'

define view ZB_4_RPT_0039 as select from hrrp_directory as a left outer join hrrp_node as b
on a.hryid = b.hryid                                                                         
{
    key a.hryid         as HierarchyId,
    b.parnode           as Facilities,
    b.nodevalue         as NodeValue,
    b.leafvalue
    
    
}
where a.hryid = 'H106/PSCO/PSSS' and 
      a.hrycls = 'PSCO'          and 
      a.hrytyp = '0106'          and      
      //b.nodetype = 'L'           and
      b.parnode = '08.1.1'       and 
      b.parnode = '08.1.2'       and 
      b.parnode = '08.1.3'      
