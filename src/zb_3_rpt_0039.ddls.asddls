@AbapCatalog.sqlViewName: 'ZB3RPT0039'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0039 - Basic View (PSSS Hier)'

define view ZB_3_RPT_0039
  as select from    hrrp_directory as a
    left outer join hrrp_node      as b on  a.mandt  = b.mandt
                                        and a.hryid  = b.hryid
                                        and a.hryid  = 'H106/PSCO/PS_SS'
                                        and a.hrycls = 'PSCO'
                                        and a.hrytyp = '0106'

    inner join      hrrp_nodet     as t on  b.mandt   =  t.mandt
                                        and b.hryid   =  t.hryid
                                        and b.hryver  =  t.hryver
                                        and b.nodecls =  t.nodecls
                                        and b.parnode =  t.hrynode
                                        and b.parnode =  '0Y'
                                        and b.hrytype =  t.hrytyp
                                        and t.hryid   =  'H106/PSCO/PS_SS'
                                        and t.nodetxt <> ''
                                        and t.spras   =  'E'

{
  key a.hryid     as HierarchyId,
      b.parnode   as Parnode,
      b.nodevalue as NodeValue,
      b.leafvalue,
      t.nodetxt   as Facilities

}

where
  a.mandt = $session.client;
