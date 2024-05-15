@AbapCatalog.sqlViewName: 'ZCPRT57'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0057-Consol TB by Month'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_57
  with parameters

    p_fisprd : jahrper

  as select from ZI_RPT_57( p_fisprd: $parameters.p_fisprd )
{
  //  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  //  @Consumption.filter.defaultValue: '0L'
  //  @AnalyticsDetails.query.variableSequence : 10
  Ledger,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @Consumption.filter.defaultValue: '1000'
  @AnalyticsDetails.query.variableSequence : 10
  CompanyCode,
  FiscalYear,
  @EndUserText.label: 'Account'
  @AnalyticsDetails.query.axis: #ROWS
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  //  @Consumption.filter.defaultValue: '0L'
  @AnalyticsDetails.query.variableSequence : 20
  GlAccount,
  @EndUserText.label: 'AccountDesc'
  @AnalyticsDetails.query.axis: #ROWS
  GLAccDesc,

  CurrencyInCC,
  @EndUserText.label: 'Amount'
  @AnalyticsDetails.query.axis: #COLUMNS
  AmountInCC,
  @EndUserText.label: 'Trading'
  @AnalyticsDetails.query.axis: #ROWS
  TradingPartner,
  // PostingDate,
  @EndUserText.label: 'TimeLine'
  @AnalyticsDetails.query.axis: #COLUMNS
  @AnalyticsDetails.query.sortDirection: #DESC
  FiscalYearPer,

  @EndUserText.label: 'NodeTxt'
  @AnalyticsDetails.query.axis: #ROWS
  NodeTxt


}
