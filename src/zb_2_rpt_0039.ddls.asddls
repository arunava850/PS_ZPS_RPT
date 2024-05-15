@AbapCatalog.sqlViewName: 'ZB2RPT0039'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center Hierarchy'

define view ZB_2_RPT_0039
  as select from    hrrp_directory as a
    left outer join hrrp_node      as b on  a.mandt = b.mandt
                                        and a.hryid = b.hryid
                                        and a.hryid = 'H106/PSCO/PSMARKET'  
                                        and b.nodetype = 'D'                                    
                                        
    inner join hrrp_nodet as t on b.hryid    = t.hryid              and
                                  b.hryver   = t.hryver             and
                                  b.nodecls  = t.nodecls            and
                                  b.parnode  = t.hrynode            and
                                  b.hrytype  = t.hrytyp             and                                  
                                  t.hryid    = 'H106/PSCO/PSMARKET' and
                                  t.nodetxt  <> ''                  and
                                  t.spras    = 'E'  

    left outer join cepc                on  b.mandt      = cepc.mandt
                                        and b.nodevalue  = cepc.prctr
                                      //  and cepc.segment = 'PS_STORAGE'

    inner join      ZB_3_RPT_0039  as c on b.nodevalue = c.NodeValue

{
  key a.hryid      as HierarchyId,
  key a.hryver     as HierarchyVersion,
  key a.hryvalto   as ValidTodate,
      a.hryvalfrom as ValidFromDate,
      a.hrytyp     as HiearchyType,
      a.hrycls     as HierarchyClass,
      b.parnode    as Facilities,
      b.nodetype   as NodeType,
      b.nodevalue  as NodeValue,
     // b.hrylevel   as HierLevel,
      t.nodetxt    as Market,
      cepc.segment as Storage,
      cepc.ort01   as Location,
      cepc.ort02   as District,
      c.NodeValue  as ProfCtr

}
where
      a.mandt    = $session.client
  and a.hrycls   = 'PSCO'
  and a.hrytyp   = '0106'    

