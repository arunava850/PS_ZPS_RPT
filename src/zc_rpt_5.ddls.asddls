@AbapCatalog.sqlViewName: 'ZCRPT5'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0005 GL & AP to pull G/L Cons & R&M'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_5
  with parameters
    @EndUserText.label: 'Company Code'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '1000'
    p_bukrs : bukrs,
    @EndUserText.label: 'Fiscal Year'
    @AnalyticsDetails.query.variableSequence : 03
    @Consumption.defaultValue: '2024'
    p_year  : gjahr

  as select from ZI_RPT_69(p_rptid: 'YE',
                          p_bukrs: $parameters.p_bukrs,
                          p_year:$parameters.p_year)
{

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Business Unit'
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 30
  ProfitCenter,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Business Unit Name'

  ProfitCenterName,
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
  @EndUserText.label: 'EB Job#'
  WorkOrder,



  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Document Header Text'
  AccountingDocumentHeaderText,


  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Remarks'

  DocumentItemText,



  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Posting Date'

  PostingDate,

  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Invoice Number'

  InvoiceNumber,


  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Document Date'

  DocumentDate,

  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Amount'
  AmountInCompanyCodeCurrency

}
