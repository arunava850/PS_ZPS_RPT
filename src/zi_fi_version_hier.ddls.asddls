@AbapCatalog.sqlViewName: 'ZIFIVERSIONHIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FI Statement Version Hierarchy'
define view ZI_FI_VERSION_HIER
//with parameters
//    P_HIER     : hryid
as select from hrrp_directory as a
join hrrp_node as b on a.hryid = b.hryid and
                       a.hrytyp = b.hrytype and
                       a.hryvalto = b.hryvalto
{
key a.hryid as stmt_ver,
key a.hryver,
key b.nodecls, 
key b.parnode,
key cast(b.nodevalue as racct) as hrynode,
    a.hryvalto    as parent_valid_to,
    a.hryvalfrom  as parent_valid_from,
    b.nodetype,
    b.hryvalto,
    b.hryvalfrom    
} where 
    hrytyp = 'FSVN'
