@AbapCatalog.sqlViewName: 'ZIRPT19STAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0019 SameStore 5Quarter'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_19_STAT
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr

  as select from ZTF_RPT_19_STAT( p_clnt:$session.client , p_qtr: $parameters.p_qtr , p_year: $parameters.p_year
                              )
{
  Mainnode,
  Subnode,
  CompanyCode,
  ProfitCenter,
  GlAccount,
  //@Semantics.unitOfMeasure: true
  ///UnitinCC,
  //@Semantics.quantity.unitOfMeasure: 'UnitinCC'
  @DefaultAggregation: #SUM
  Q1,
  //@Semantics.quantity.unitOfMeasure: 'UnitinCC'
  @DefaultAggregation: #SUM
  Q2,
  //@Semantics.quantity.unitOfMeasure: 'UnitinCC'
  @DefaultAggregation: #SUM
  Q3,
  //@Semantics.quantity.unitOfMeasure: 'UnitinCC'
  @DefaultAggregation: #SUM
  Q4,
  //@Semantics.quantity.unitOfMeasure: 'UnitinCC'
  @DefaultAggregation: #SUM
  Q5
}
union select from ztrpt_fi_mstr as _MSTR

{
  key _MSTR.mainnode,
  key _MSTR.subnode,
      ''    as CompanyCode,
      ''    as ProfitCenter,
      ''    as GLAccount,
      // cast( ' ' as abap.dec( 23, 3 ) ) as UnitinCC,
      0.000 as Q1,
      0.000 as Q2,
      0.000 as Q3,
      0.000 as Q4,
      0.000 as Q5

}
where
      _MSTR.rptid   =    'RPT19'
  and _MSTR.docfrom like '9%'
