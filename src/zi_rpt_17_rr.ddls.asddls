@AbapCatalog.sqlViewName: 'ZIRPT17RR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0017-R&O NSS RR'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_17_RR
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  as select from ZTF_RPT_17_RR(p_clnt:$session.client , p_qtr: $parameters.p_qtr , p_year: $parameters.p_year )
{
  CompanyCode,
  ProfitCenter,
  GlAccount,
  UnitinCC,
  @DefaultAggregation: #SUM
  CQtr,
  @DefaultAggregation: #SUM
  CQtrPY,
  @DefaultAggregation: #SUM
  CY,
  @DefaultAggregation: #SUM
  PY
}
