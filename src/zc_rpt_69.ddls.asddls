@AbapCatalog.sqlViewName: 'ZCRPT69'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0069 GL & AP to pull G/L Cons & R&M'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_69
  with parameters
    @EndUserText.label: 'Company Code'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '1000'
    p_bukrs : bukrs,
    @EndUserText.label: 'Fiscal Year'
    @AnalyticsDetails.query.variableSequence : 03
    @Consumption.defaultValue: '2024'
    p_year  : gjahr

  as select from ZI_RPT_69(p_rptid: 'YR',
                           p_bukrs: $parameters.p_bukrs,
                           p_year:$parameters.p_year)
{

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Business Type'
  Segment,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Business Unit'
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 30
  ProfitCenter,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Business Unit Name'

  ProfitCenterName,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'State'

  Region,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'State'
  GLAccount,

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Account Description'
  GLAccountName,

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Supplier'
  Supplier,

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Supplier Name'
  SupplierName,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Document Number'

  AccountingDocument,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Cheque No.'
  CHECT,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Cheque Dt'
  zaldt,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Work Order'
  WorkOrder,

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Journal Header Desc'
  AccountingDocumentHeaderText,

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'General Line Desc'

  DocumentItemText,


  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Asset Number'
  MasterFixedAsset,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Serial Number'

  SerialNumberFA,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Month'
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 40
  FiscalPeriod,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'GL Date'

  DocumentDate,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Invoice Number'

  InvoiceNumber,


  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Payment Document'

  ClearingAccountingDocument,

  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Amount'
  AmountInCompanyCodeCurrency

}
