@AbapCatalog.sqlViewName: 'ZBSSPCHIER77'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center Hierarchy'

define view ZB_SS_PC_HIER_77
  as select distinct from hrrp_directory as a
    left outer join       hrrp_node      as b on  a.mandt = b.mandt
                                              and a.hryid = b.hryid
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
}
where
      a.mandt     = $session.client
  and a.hryid     =  'H106/PSCO/PS_SS'
  and a.hrycls    =  'PSCO'
  and b.nodetype  =  'L'
  and a.hrytyp    =  '0106'
//  and b.parnode   =  '0Y'
  and b.leafvalue <> ''
