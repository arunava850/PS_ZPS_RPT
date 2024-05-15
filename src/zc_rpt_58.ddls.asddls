@AbapCatalog.sqlViewName: 'ZCRPT58'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0058-TBal Book by CCode'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_58
  with parameters
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.defaultValue: '2024'
    p_year : gjahr
  as select from ZI_RPT_58( p_year: $parameters.p_year )
{
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: false}
  @Consumption.derivation: { lookupEntity: 'I_LedgerStdVH',
        resultElement: 'Ledger', binding: [
        { targetElement : 'IsLeadingLedger' , type : #CONSTANT, value : 'X' } ]
       }
  @AnalyticsDetails.query.variableSequence : 02
  @EndUserText.label: 'Ledger'
  Ledger,
  @AnalyticsDetails.query.axis: #COLUMNS
  LedgerYear,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 10
  CompanyCode,
  @EndUserText.label: 'Account'
  @AnalyticsDetails.query.axis: #ROWS
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 20
  GlAccount,
  @EndUserText.label: 'AccountDesc'
  @AnalyticsDetails.query.axis: #ROWS
  GLAccDesc,
  AmountInCC,
  CurrencyInCC,
  @EndUserText.label: 'Trading'
  @AnalyticsDetails.query.axis: #ROWS
  TradingPartner,
  @EndUserText.label: 'NodeTxt'
  @AnalyticsDetails.query.axis: #ROWS
  NodeTxt
}
