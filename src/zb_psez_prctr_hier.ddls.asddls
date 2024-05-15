@AbapCatalog.sqlViewName: 'ZBPSEZPRCTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center Hierarchy'

define view ZB_PSEZ_PRCTR_HIER
  as select from    hrrp_directory as a
    left outer join hrrp_node      as b on a.hryid = b.hryid

  //left outer join hrrp_nodet on a.hryid = hrrp_nodet.hryid

{
  key a.hryid      as HierarchyId,
  key a.hryver     as HierarchyVersion,
  key a.hryvalto   as ValidTodate,
      a.hryvalfrom as ValidFromDate,
      a.hrytyp     as HiearchyType,
      a.hrycls     as HierarchyClass,
      b.parnode    as HierarchyParentNode,
      b.nodetype   as NodeType,
      b.nodevalue  as NodeValue
      //hrrp_nodet.nodetxt  as NodeText
}
where
      a.hryid     =  'H106/PSCO/PSEZ'
  and a.hrycls    =  'PSCO'
  and b.nodetype  =  'D'
  and a.hrytyp    =  '0106'
  and b.parnode   =  '0PSEZ'
  and b.leafvalue <> ''
//      (b.parnode >= '01.2.4.1' and b.parnode <= '01.2.4.6') or
//      (b.parnode >= '01.2.5.1' and b.parnode <= '01.2.5.6') 
