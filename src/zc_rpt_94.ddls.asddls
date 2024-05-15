@AbapCatalog.sqlViewName: 'ZVRPT94CONS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0094 - G&A Table'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
@ObjectModel.representativeKey: 'mainnode'
@AbapCatalog: {
                buffering.status: #NOT_ALLOWED }

@Analytics.settings.maxProcessingEffort: #HIGH
@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata: { ignorePropagatedAnnotations: true,
             allowExtensions: true }
@ObjectModel: { supportedCapabilities: [ #ANALYTICAL_QUERY ],
                modelingPattern: #ANALYTICAL_QUERY,
                usageType: { sizeCategory: #XXL,
                             serviceQuality: #D,
                             dataClass: #MIXED } }
define view ZC_RPT_94
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
  as select from ZI_RPT_94
                 ( p_month: $parameters.p_month,
                            p_qtr: $parameters.p_qtr , p_year: $parameters.p_year   )

{
      //      @AnalyticsDetails.query.axis: #COLUMNS
      //  key Mainnode,
      //  key Subnode,
  key Ledger,
  key CompanyCode,
      @AnalyticsDetails.query.axis: #ROWS
  key GlAccount,
      //  key GlAccountGroup,
  key ProfitCenter,
      Segment,
      CalendarMonth,
      CalendarYear,
      CalendarYearMonth,
      GLAccDesc,
      CurrencyinCC,
      AmountinCC,
      @EndUserText.label: 'Current Year Quarter'
      CQtr,
      @EndUserText.label: 'Previous Year Quarter'
      CQtrPY,
      @EndUserText.label: 'Quarter Change'
      CQTRCHANGE,
      @EndUserText.label: 'Current Year'
      CY,
      @EndUserText.label: 'Previous Year'
      PY,
      //PY1,
      //PY2,
      @EndUserText.label: 'Year Change'
      PYCHANGE

}
