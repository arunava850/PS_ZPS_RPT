@AbapCatalog.sqlViewName: 'ZCRPT2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tenant Ins. Collection by Prop/Stat'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_2
  as select from ZI_RPT_2
{
  @EndUserText.label: 'Region'
  @AnalyticsDetails.query.axis: #ROWS
  Region,
  @EndUserText.label: 'RegionName'
  @AnalyticsDetails.query.axis: #ROWS
  RegionName,
  ProfitCenter,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
  @AnalyticsDetails.query.variableSequence : 10
  FiscalYear,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
  @AnalyticsDetails.query.variableSequence : 20
  FiscalPeriod,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Collection'
  Collection1,
  @EndUserText.label: 'Refund'
  @AnalyticsDetails.query.axis: #COLUMNS
  Refund,
  @EndUserText.label: 'NetRemittance'
  @AnalyticsDetails.query.axis: #COLUMNS
  NetRemittance,
  CurrencyinCC
}
