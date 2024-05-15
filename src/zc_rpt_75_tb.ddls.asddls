@AbapCatalog.sqlViewName: 'ZCRPT75TB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0075 Trial Bal P&L by TPP'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_75_TB
  with parameters
    @EndUserText.label: 'Company Code'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '9950'
    p_bukrs : bukrs,
    @EndUserText.label: 'Fiscal Year'
    @AnalyticsDetails.query.variableSequence : 03
    @Consumption.defaultValue: '2024'
    p_year  : gjahr
  as select from ZI_RPT_75_TB( p_ledg : '0L',
                           p_bukrs: $parameters.p_bukrs,
                           p_year:$parameters.p_year)
{
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Company Code'
  CompanyCode,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Profit Center'
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 30
  ProfitCenter,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Cost Center'
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 40
  CostCenter,

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'G/L Account Number'

  GLAccount,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'G/L Account Desc'
  GLAccountName,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Bal. C/F LC'

  hslvt,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Jan'

  hsl01,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Feb'

  hsl02,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Mar'
  hsl03,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Apr'
  hsl04,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'May'
  hsl05,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Jun'

  hsl06,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Jul'

  hsl07,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Aug'

  hsl08,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Sep'

  hsl09,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Oct'

  hsl10,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Nov'

  hsl11,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Dec'

  hsl12,

  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Year End B/L'
  YearEndBl,

  CompanyCodeCurrency


}
