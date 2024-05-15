@AbapCatalog.sqlViewName: 'ZCRPT17RR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0017 - R&O NSS RR'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_17_RR
  with parameters
    @EndUserText.label: 'Quarter'
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.defaultValue: 'Q1'
    p_qtr  : abap.char(2),
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '2024'
    p_year : gjahr
  as select from ZI_RPT_17_RR(  p_qtr: $parameters.p_qtr , p_year: $parameters.p_year)
{
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 10
  @Consumption.filter.defaultValue: '1000'
  CompanyCode,
  ProfitCenter,
  @AnalyticsDetails.query.axis: #ROWS
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 40
  GlAccount,
  UnitinCC,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'CQtr'
  CQtr,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'CQtrPY'
  CQtrPY,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'CY'
  CY,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'PY'
  PY
}
