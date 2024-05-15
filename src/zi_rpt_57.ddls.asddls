@AbapCatalog.sqlViewName: 'ZIRPT57'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0057-Consol TB by Month'
//@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

//@Analytics.query: true
define view ZI_RPT_57
  with parameters

    p_fisprd : jahrper
  as select from ZTF_RPT_57(p_clnt : $session.client, p_fisprd: $parameters.p_fisprd )
{
  // $session.client as client,
  Ledger,
  CompanyCode,
  FiscalYear,
  GlAccount,

  @Semantics.currencyCode:true
  CurrencyInCC,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AmountInCC,

  TradingPartner,
  //PostingDate,
  FiscalYearPer,
  GLAccDesc,
  NodeTxt
}
union

select from ZI_RPT_57_Cal_Mstr(p_fisprd: $parameters.p_fisprd )

{
  $session.client as mandt,
  //client,
  Ledger,
  CompanyCode,
  FiscalYear,
  GlAccount,
  @Semantics.currencyCode:true
  CurrencyInCC,
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AmountInCC,
  TradingPartner,
  FiscalYearPer,
  GLAccDesc,
  NodeTxt
}
