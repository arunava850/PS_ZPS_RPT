@AbapCatalog.sqlViewName: 'ZIRTP94'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0094 - G&A Table'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_94
  with parameters
    p_month : month,
    p_qtr   : abap.char(2),
    p_year  : gjahr

  as select from ZTF_RPT94( p_clnt:$session.client , p_month: $parameters.p_month,
                            p_qtr: $parameters.p_qtr , p_year: $parameters.p_year)
{
  //  Mainnode,
  //  Subnode,
  Ledger,
  CompanyCode,
  GlAccount,
  //  GlAccountGroup,
  ProfitCenter,
  Segment,
  CalendarMonth,
  CalendarYear,
  CalendarYearMonth,
  GLAccDesc,
  @Semantics.currencyCode:true
  CurrencyinCC,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AmountinCC,
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
       when CY is null and PY is not null then (-PY) else 0 end           as PYCHANGE

}

//union select from ztrpt_fi_mstr as _MSTR
//
//{
//  // key _MSTR.counter,
//  //  key _MSTR.mainnode,
//  //  key _MSTR.subnode,
//  ''                         as Ledger,
//  ''                         as CompanyCode,
//  ''                         as GLAccount,
//  //      ''                         as GLAccountGroup,
//  ''                         as ProfitCenter,
//  ''                         as Segment,
//  '00'                       as CalendarMonth,
//  '0000'                     as CalendarYear,
//  '000000'                   as CalendarYearMonth,
//  ''                         as GLAccDesc,
//  @Semantics.currencyCode:true
//  cast( 'USD' as abap.cuky ) as CurrencyinCC,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as AmountinCC,
//
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as Cqtr,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as CQtrPy,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as CY,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as PY,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as PY1,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as PY2,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as CQTRCHANGE,
//  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
//  0                          as PYCHANGE
//
//
//}
//where
//  _MSTR.rptid = 'RPT94'
