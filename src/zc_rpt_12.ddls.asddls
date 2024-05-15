@AbapCatalog.sqlViewName: 'ZVRPT12CONS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0012- Same vs Non-Same Store'
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
define view ZC_RPT_12
  with parameters
    @EndUserText.label: 'Month'
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.defaultValue: '1'
    p_month  : month,
    
    @EndUserText.label: 'Year'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '2024'
    p_year : gjahr,
    @EndUserText.label: 'PCH(A/Y/N)'
    @AnalyticsDetails.query.variableSequence : 03
    @Consumption.defaultValue: 'A'
    p_pch  : zpch
  as select from ZI_RPT_12_2
                 (p_month: $parameters.p_month , p_year: $parameters.p_year, p_pch: $parameters.p_pch   )

{
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.axis: #ROWS
  Mainnodetxt,
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.axis: #ROWS
  subnodetxt,
  Mainnode,
  Subnode,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 40
  Ledger,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 50
  CompanyCode,
  GlAccount,
  GlAccountGroup,
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 60
  ProfitCenter,
  Segment,
  GLAccDesc,
  CurrencyinCC,
  AmountinCC,
  @EndUserText.label: 'Current Year Month'
  PY1,
  @EndUserText.label: 'Previous Year Month'
  PY2,
  @EndUserText.label: 'Month Change'
  PY2CHANGE,
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
  @EndUserText.label: 'Year Change'
  CYChange



}
