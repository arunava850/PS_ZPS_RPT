@AbapCatalog.sqlViewName: 'ZIRTP19STAT_2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0019 SameStore 5Quarter'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_19_2_STAT
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  // p_bukrs : bukrs
  as select from ZI_RPT_19_STAT(  p_qtr: $parameters.p_qtr , p_year: $parameters.p_year
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
  CompanyCode,
  ProfitCenter,
  GlAccount,
  // @Semantics.unitOfMeasure: true
  //UnitinCC,
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
  // @Semantics.quantity.unitOfMeasure: 'UnitinCC'
  @DefaultAggregation: #SUM
  Q5,
  _MText.Mainnodetxt,
  _SText.subnodetxt,
  _MText,
  _SText
}
