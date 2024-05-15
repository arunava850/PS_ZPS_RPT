@AbapCatalog.sqlViewName: 'ZCRPT37STAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 37 - SEC Schedule STAT'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_37_STAT
  with parameters
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '2024'
    p_year : gjahr
  as select from ZI_RPT_37_STAT(   p_year: $parameters.p_year)
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
  @EndUserText.label: 'Count of Properties'
  @AnalyticsDetails.query.axis: #COLUMNS
  NoofFacilities,
  @EndUserText.label: 'Total Square Footage(ToT) '
  @AnalyticsDetails.query.axis: #COLUMNS
  NetRentableSquareFoot
}
