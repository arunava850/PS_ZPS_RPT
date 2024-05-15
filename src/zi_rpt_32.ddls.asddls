@AbapCatalog.sqlViewName: 'ZIRTP32AO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0032 - Ancillary Operations'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_32
  with parameters
    p_month : month,
    p_qtr   : abap.char(2),
    p_year  : gjahr

  as select from ZTF_RPT_32( p_clnt:$session.client , p_month: $parameters.p_month,
                            p_qtr: $parameters.p_qtr , p_year: $parameters.p_year   )
{
  Mainnode,
  Subnode,
  Ledger,
  CompanyCode,
  GlAccount,
  GlAccountGroup,
  ProfitCenter,
  Segment,
  CalendarMonth,
  CalendarYear,
  CalendarYearMonth,
  PostingDate,
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
  PY2

}

union select from ztrpt_fi_mstr as _MSTR

{
      // key _MSTR.counter,
  key _MSTR.mainnode,
  key _MSTR.subnode,
      ''                         as Ledger,
      ''                         as CompanyCode,
      ''                         as GLAccount,
      ''                         as GLAccountGroup,
      ''                         as ProfitCenter,
      ''                         as Segment,
      '00'                       as CalendarMonth,
      '0000'                     as CalendarYear,
      '000000'                   as CalendarYearMonth,
      ''                         as PostingDate,
      ''                         as GLAccDesc,
      @Semantics.currencyCode:true
      cast( 'USD' as abap.cuky ) as CurrencyinCC,
      @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
      0                          as AmountinCC,

      @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
      0                          as Cqtr,
      @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
      0                          as CQtrPy,
      @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
      0                          as CY,
      @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
      0                          as PY,
      @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
      0                          as PY1,
      @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
      0                          as PY2

}
where
  _MSTR.rptid = 'RPT32'
