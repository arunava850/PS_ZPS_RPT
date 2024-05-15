@AbapCatalog.sqlViewName: 'ZCRPT32'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0032 - Ancillary Operations'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true


define view ZC_RPT_32
  with parameters
    @AnalyticsDetails.query.variableSequence : 01
    p_month : month,
    @EndUserText.label: 'Quarter'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: 'Q1'
    p_qtr   : abap.char(2),
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 03
    @Consumption.defaultValue: '2024'
    p_year  : gjahr


  as select from ZI_RPT_32_2( p_month: $parameters.p_month,
                            p_qtr: $parameters.p_qtr , p_year: $parameters.p_year   )
{
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.axis: #ROWS
  Mainnodetxt,
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.axis: #ROWS
  subnodetxt,
  Mainnode,
  Subnode,
  Ledger,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 30
  CompanyCode,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 40
  @EndUserText.label: 'GLAccount'
  GlAccount,
  @EndUserText.label: 'GLAccountGroup'
  GlAccountGroup,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 50
  ProfitCenter,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 60
  Segment,
  CalendarMonth,
  CalendarYear,
  CalendarYearMonth,
  PostingDate,
  //@AnalyticsDetails.query.axis: #FREE
  //AmountinCC,
  CurrencyinCC,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Current Year Quarter'
  CQtr,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Previous Year Quarter'
  CQtrPY,
  @EndUserText.label: 'Quarter Change'
  CQTRCHANGE,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Current Year'
  CY,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Previous Year'
  PY,
  @EndUserText.label: 'Year Change'
  CYChange,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Previous Year Full'
  PY1,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Previous To Previous Year Full'
  PY2,
  @EndUserText.label: 'Previous Year Change'
  PYCHANGE,
  @EndUserText.label: 'GLDesc'
  GLAccDesc
}
