@AbapCatalog.sqlViewName: 'ZIRPT31'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0031 Inv_In_Uncons_RE_Entities'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_31
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  as select from ZTF_RPT_31( p_clnt:$session.client , p_qtr: $parameters.p_qtr , p_year: $parameters.p_year )
{
  Mainnode,
  Subnode,
  Ledger,
  CompanyCode,
  GlAccount,
  ProfitCenter,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AmountinCC,
  @Semantics.currencyCode:true
  CurrencyinCC,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  CQtr,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  CQtrPY,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  CY,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  PY,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  PY1,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  PY2,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  case when CQtr is not null and CQtrPY is not null then  (CQtr - CQtrPY)
       when CQtr is not null and CQtrPY is null then CQtr
       when CQtr is null and CQtrPY is not null then (-CQtrPY) else 0 end as CQTRCHANGE,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  case when CY is not null and PY is not null then  (CY - PY)
       when CY is not null and PY is null then CY
       when CY is null and PY is not null then (-PY) else 0 end           as CYChange,

  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  case when PY2 is not null and PY1 is not null then  (PY2 - PY1)
       when PY2 is not null and PY1 is null then PY2
       when PY2 is null and PY1 is not null then (-PY1) else 0 end        as PYCHANGE


}
