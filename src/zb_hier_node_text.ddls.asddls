@AbapCatalog.sqlViewName: 'ZBHIERNODETEXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center Hierarchy'

define view ZB_HIER_NODE_TEXT
  with parameters
    p_hryid : hryid
  //  p_parnode : parnode

  as select distinct from hrrp_node  as _n
    inner join            hrrp_nodet as _t on  _t.spras   = $session.system_language
                                           and _t.hryid   = _n.hryid
                                           and _t.hryver  = _n.hryver
                                           and _t.nodecls = _n.nodecls
                                           and _t.hrynode = _n.parnode
  //  and _t.parnode = $parameters.p_parnode

{
  key  _n.hryid     as HierID,
  key  _n.nodecls   as NodeClass,
  key  _t.parnode   as ParNode,
  key  _n.leafvalue as LeafValue,
  key  _t.nodetxt   as NodeTxt
}
where
      _n.hryid    = $parameters.p_hryid
  and _n.nodetype = 'L';
