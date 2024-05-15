@AbapCatalog.sqlViewName: 'ZCRPT31'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0031 Inv_In_Uncons_RE_Entities'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_31
  with parameters
    @EndUserText.label: 'Quarter'
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.defaultValue: 'Q1'
    p_qtr  : abap.char(2),
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '2024'
    p_year : gjahr
  as select from ZI_RPT_31(  p_qtr: $parameters.p_qtr , p_year: $parameters.p_year )
{

  @AnalyticsDetails.query.axis: #ROWS
  Mainnode,

  @AnalyticsDetails.query.axis: #ROWS
  Subnode,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 20
  Ledger,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 30
  CompanyCode,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 40
  @EndUserText.label: 'GLAccount'
  GlAccount,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 50
  ProfitCenter,
  CurrencyinCC,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'CQtr'
  CQtr,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'CQtrPY'
  CQtrPY,
  @EndUserText.label: 'CQtrChange'
  CQTRCHANGE,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'CY'
  CY,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'PY'
  PY,
  @EndUserText.label: 'CYChange'
  CYChange,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'PY1'
  PY1,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'PY2'
  PY2,
  @EndUserText.label: 'PYChange'
  PYCHANGE
}
