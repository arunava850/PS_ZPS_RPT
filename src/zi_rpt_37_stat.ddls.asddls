@AbapCatalog.sqlViewName: 'ZIRPT37STAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 37 - SEC Schedule STAT'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_37_STAT
  with parameters
    p_year : gjahr
  as select from ZTF_RPT_37_STAT(p_clnt:$session.client ,  p_year: $parameters.p_year )
{
  State,
  ProfitCenter,
  @DefaultAggregation: #SUM
  NoofFacilities,
  @DefaultAggregation: #SUM
  NetRentableSquareFoot
}
