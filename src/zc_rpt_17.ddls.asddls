@AbapCatalog.sqlViewName: 'ZCRPT17A'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0017 - R&O NSS'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_17
  with parameters
    @EndUserText.label: 'Quarter'
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.defaultValue: 'Q1'
    p_qtr  : abap.char(2),
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '2024'
    p_year : gjahr
  as select from ZI_RPT_17(  p_qtr: $parameters.p_qtr , p_year: $parameters.p_year)

{
  @EndUserText.label: 'State'
  @AnalyticsDetails.query.axis: #ROWS
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 10
  State,
  @EndUserText.label: 'Profit Center'
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 20
  ProfitCenter,
  //COPByGL,
  @EndUserText.label: 'Count of Properties'
  @AnalyticsDetails.query.axis: #COLUMNS
  COPByPC,
  @EndUserText.label: 'Total Square Footage(ToT) '
  @AnalyticsDetails.query.axis: #COLUMNS
  TotalSqFoot
}
