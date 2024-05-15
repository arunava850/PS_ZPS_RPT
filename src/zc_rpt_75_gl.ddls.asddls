@AbapCatalog.sqlViewName: 'ZCRPT75GL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0075 GL Det P&L by TPP'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_75_GL
  with parameters
    @EndUserText.label: 'Company Code'
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.defaultValue: '9950'
    p_bukrs : bukrs,
    @EndUserText.label: 'Fiscal Year'
    @AnalyticsDetails.query.variableSequence : 03
    @Consumption.defaultValue: '2024'
    p_year  : gjahr
  as select from ZI_RPT_75( p_ledg : '0L',
                           p_bukrs: $parameters.p_bukrs,
                           p_year:$parameters.p_year)
{
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Company Code'
  CompanyCode,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Posting Date'
  PostingDate,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Doc. Date'
  DocumentDate,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Doc. No.'
  AccountingDocument,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Doc. Type'
  AccountingDocumentType,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Profit Center'
  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 30
  @Consumption.valueHelpDefinition: [
    { entity:  { name:    'I_ProfitCenterStdVH',
                 element: 'ProfitCenter' }
    }]
  @ObjectModel.foreignKey.association: '_ProfitCenter'
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
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Vendor'
  Supplier,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Vendor Name'
  SupplierFullName,
  @AnalyticsDetails.query.axis: #ROWS
  @EndUserText.label: 'Created By'
  AccountingDocCreatedByUser as CreatedBy,
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Amount'
  AmountInCompanyCodeCurrency,
  CompanyCodeCurrency

}
