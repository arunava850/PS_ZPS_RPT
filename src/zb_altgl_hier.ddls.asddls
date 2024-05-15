@AbapCatalog.sqlViewName: 'ZBALTGLHIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Profit Center Hierarchy'

define view ZB_ALTGL_HIER
  as select distinct from hrrp_directory as a
    left outer join       hrrp_node      as b on a.hryid = b.hryid

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
      a.hrysid    =  'ALT_GL'
  and a.hrycls    =  'PSUS'
  and b.nodetype  =  'D'
  and a.hrytyp    =  'FSVN'
  and b.parnode   =  '0ALT_GL'
  and b.leafvalue <> ''
