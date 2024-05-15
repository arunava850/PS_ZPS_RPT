@AbapCatalog.sqlViewName: 'ZBGRPACCGL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Group Accounts - GLs'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZB_GRP_ACC_GL as select from ska1 as a 
       left outer join acdoca as b on a.saknr = b.racct
{
    a.bilkt,
    a.saknr
}
