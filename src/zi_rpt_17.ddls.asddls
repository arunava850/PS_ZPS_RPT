@AbapCatalog.sqlViewName: 'ZIRPT17'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0017-R&O NSS'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_17
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  as select from ZTF_RPT_17(p_clnt:$session.client , p_qtr: $parameters.p_qtr , p_year: $parameters.p_year )

{
  State,
  ProfitCenter,
  @DefaultAggregation: #SUM
  COPByGL,
  @DefaultAggregation: #SUM
  COPByPC,
  @DefaultAggregation: #SUM
  TotalSqFoot
}
