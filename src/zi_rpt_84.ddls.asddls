@AbapCatalog.sqlViewName: 'ZIRPT84'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0084 B&O Management Fee Rpt'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_84
  as select from ZTF_RPT_84( p_clnt: $session.client )
{
  Region,
  RegionName,
  AccountType,
  ProfitCenter,
  ProfitCenterName,
  Segment,
  FiscalYear,
  FiscalPeriod,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AmountinCC,
  @Semantics.currencyCode:true
  CurrencyinCC
}
