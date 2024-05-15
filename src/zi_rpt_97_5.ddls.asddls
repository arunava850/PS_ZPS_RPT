@AbapCatalog.sqlViewName: 'ZVRPT971'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rpt97'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_97_5
  as select from ZTF_RPT_97_1( p_clnt:$session.client )
{

  ProfitCenter,
  district,
  @DefaultAggregation: #SUM
  NoOfFacility
}
union select from ZB_2_RPT_0039 as _MSTR

{
  ''             as ProfitCenter,
  _MSTR.District as district,
  0              as NoOfFacility
}
