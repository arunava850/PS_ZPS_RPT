@AbapCatalog.sqlViewName: 'ZCRPT19STAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0019 SameStore 5Quarter STAT'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_19_STAT
  with parameters
    @EndUserText.label: 'Quarter'
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.defaultValue: 'Q1'
    p_qtr  : abap.char(2),
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '2024'
    p_year : gjahr
  //    @EndUserText.label: 'CompanyCode'
  //    @AnalyticsDetails.query.variableSequence : 03
  //    @Consumption.defaultValue: '1000'
  //
  //    p_bukrs : bukrs
  as select from ZI_RPT_19_2_STAT(  p_qtr: $parameters.p_qtr , p_year: $parameters.p_year
                 //                             p_bukrs: $parameters.p_bukrs
                             )
{
  //@AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.axis: #ROWS
  Mainnodetxt,
  //@AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.axis: #ROWS
  subnodetxt,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 40
  GlAccount,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 50
  ProfitCenter,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 10
  @Consumption.filter.defaultValue: '1000'
  CompanyCode,
  //UnitinCC,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Q1'
  Q1,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Q2'
  Q2,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Q3'
  Q3,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Q4'
  Q4,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Q5'
  Q5


}
