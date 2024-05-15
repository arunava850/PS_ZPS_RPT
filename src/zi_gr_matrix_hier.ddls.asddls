@AbapCatalog.sqlViewName: 'ZIGRMATRIXHIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Custom Group Reporting Hierarchy'
define view ZI_GR_MATRIX_HIER  
//with parameters
//    P_HIER     : hryid
as select from hrrp_node as leaf
{
key cast(substring(hryid, 9, 10 ) as fc_ithry) as short_hryid,
key hryid,
key hryver,
key nodecls,
key hrynode,
  hryvalto,
  hryvalfrom
} where 
    nodetype    = 'L'   
