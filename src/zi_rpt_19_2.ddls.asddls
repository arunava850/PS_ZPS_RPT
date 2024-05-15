@AbapCatalog.sqlViewName: 'ZIRTP19_2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0019 SameStore 5Quarter'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_19_2
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  // p_bukrs : bukrs
  as select from ZI_RPT_19(  p_qtr: $parameters.p_qtr , p_year: $parameters.p_year
                 //                             p_bukrs: $parameters.p_bukrs
                             )
  association [0..*] to ZI_MNODE_TXT as _MText on  $projection.Mainnode = _MText.Mainnode
                                               and _MText.ReportId      = 'RPT19'
  //

  association [0..*] to ZI_SNODE_TXT as _SText on  $projection.Mainnode = _SText.MainNode
                                               and $projection.Subnode  = _SText.SubNode
                                               and _SText.ReportId      = 'RPT19'
{
  Mainnode,
  Subnode,
  Ledger,
  CompanyCode,
  GlAccount,
  GlAccountGroup,
  ProfitCenter,
  Segment,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  AmountinCC,
  @Semantics.currencyCode:true
  CurrencyinCC,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  Q1,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  Q2,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  Q3,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  Q4,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyinCC'} }
  Q5,
  GLAccDesc,
  _MText.Mainnodetxt,
  _SText.subnodetxt,
  _MText,
  _SText
}
