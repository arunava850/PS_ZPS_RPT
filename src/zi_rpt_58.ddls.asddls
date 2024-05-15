@AbapCatalog.sqlViewName: 'ZIRPT58'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0058-TBal Book by CCode'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_58
  with parameters
    p_year : gjahr
  as select from ZTF_RPT_58( p_clnt: $session.client, p_year: $parameters.p_year )
{
  LedgerYear,
  LEFT( LedgerYear, 2 ) as Ledger,
  CompanyCode,
  GlAccount,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AmountInCC,
  @Semantics.currencyCode:true
  CurrencyInCC,
  TradingPartner,
  GLAccDesc,
  NodeTxt
}
