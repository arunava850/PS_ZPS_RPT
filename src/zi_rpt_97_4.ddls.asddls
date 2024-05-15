@AbapCatalog.sqlViewName: 'ZVRPT39'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rpt25'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_97_4
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr

  as select from ZTF_RPT_97( p_clnt:$session.client , p_qtr: $parameters.p_qtr , p_year: $parameters.p_year  ) as A
//  left outer join ZTF_RPT_97_1( p_clnt:$session.client , p_qtr: $parameters.p_qtr , p_year: $parameters.p_year  ) as B
//  on A.GlAccount = B.GlAccount and A.Location = B.Location and A.ProfitCenter = B.ProfitCenter
{
 Mainnode,


  Subnode,
  Ledger,
  CompanyCode,
  A.GlAccount,
  GlAccountGroup,
  A.ProfitCenter,
  postingdate,
  Segment,
  A.Location,
  A.district,
  A.GLAccDesc,
//  @DefaultAggregation: #SUM
//  B.NoOfFacility,
//  @DefaultAggregation: #SUM
//  B.CQtrF,
//  @DefaultAggregation: #SUM
//  B.CQtrPYF,
//  @DefaultAggregation: #SUM
//  B.CYF,
//  @DefaultAggregation: #SUM
//  B.PYF,
//  @DefaultAggregation: #SUM
//  B.PY1F,
//  @DefaultAggregation: #SUM
//  B.PY2F,
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
      ''                         as Postingdate,
      ''                         as Segment,
      ''                         as Location,
      ''                         as district,
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
  _MSTR.rptid = 'RPT97'


