@AbapCatalog.sqlViewName: 'ZIRTP32AO2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0032 - Ancillary Operations'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_32_2
  with parameters
    p_month : month,
    p_qtr   : abap.char(2),
    p_year  : gjahr
  as select from ZI_RPT_32( p_month: $parameters.p_month,
                            p_qtr: $parameters.p_qtr , p_year: $parameters.p_year   )
  association [0..*] to ZI_MNODE_TXT as _MText on  $projection.Mainnode = _MText.Mainnode
                                               and _MText.ReportId      = 'RPT32'
  //

  association [0..*] to ZI_SNODE_TXT as _SText on  $projection.Mainnode = _SText.MainNode
                                               and $projection.Subnode  = _SText.SubNode
                                               and _SText.ReportId      = 'RPT32'
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
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  AmountinCC,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  CQtr,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  CQtrPY,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  CY,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  PY,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  PY1,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
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
  case when PY1 is not null and PY2 is not null then  (PY1 - PY2)
       when PY1 is not null and PY2 is null then PY1
       when PY1 is null and PY2 is not null then (-PY2) else 0 end        as PYCHANGE,
  _MText.Mainnodetxt,
  _SText.subnodetxt,
  _MText,
  _SText
}
