@AbapCatalog.sqlViewName: 'ZCPRT84'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0084 - B&O Management Fee Rpt'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_84
  as select from ZI_RPT_84
{
  @EndUserText.label: 'State'
  @AnalyticsDetails.query.axis: #ROWS
  Region,
  @EndUserText.label: 'StateName'
  @AnalyticsDetails.query.axis: #ROWS
  RegionName,
  @EndUserText.label: 'AccountType'
  @AnalyticsDetails.query.axis: #ROWS
  AccountType,
  @EndUserText.label: 'EntityType'
  @AnalyticsDetails.query.axis: #ROWS
  Segment,
  ProfitCenter,
  @EndUserText.label: 'EntityName'
  @AnalyticsDetails.query.axis: #ROWS
  ProfitCenterName,

  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
  @AnalyticsDetails.query.variableSequence : 10
  FiscalYear,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
  @AnalyticsDetails.query.variableSequence : 20
  FiscalPeriod,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Amount'
  AmountinCC,
  CurrencyinCC
}
