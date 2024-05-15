@AbapCatalog.sqlViewName: 'ZIRPT19'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0019 SameStore 5Quarter'
define view ZI_RPT_19
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  // p_bukrs : bukrs

  as select from ZTF_RPT_19( p_clnt:$session.client , p_qtr: $parameters.p_qtr , p_year: $parameters.p_year
                 //                             p_bukrs: $parameters.p_bukrs
                              )
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
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AmountinCC,
  @Semantics.currencyCode:true
  CurrencyinCC,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Q1,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Q2,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Q3,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Q4,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Q5,
  GLAccDesc
}
union select from ztrpt_fi_mstr as _MSTR

{
  key _MSTR.mainnode,
  key _MSTR.subnode,
      ''                         as Ledger,
      ''                         as CompanyCode,
      ''                         as GLAccount,
      ''                         as GLAccountGroup,
      ''                         as ProfitCenter,
      ''                         as Segment,
      0                          as AmountinCC,
      cast( 'USD' as abap.cuky ) as CurrencyinCC,
      0                          as Q1,
      0                          as Q2,
      0                          as Q3,
      0                          as Q4,
      0                          as Q5,
      ''                         as GLAccDesc

}
where
      _MSTR.rptid   = 'RPT19'
  and _MSTR.docfrom not like '9%'
