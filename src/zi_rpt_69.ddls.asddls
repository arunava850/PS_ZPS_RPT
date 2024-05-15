@AbapCatalog.sqlViewName: 'ZIRPT69'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GL & AP to pull G/L Cons & R&M(TF)'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_69
  with parameters
    p_rptid : blart,
    p_bukrs : bukrs,
    p_year  : gjahr
  as select from ZTF_RPT_69(p_clnt : $session.client,
                             p_rptid : $parameters.p_rptid,
                            p_bukrs: $parameters.p_bukrs,
                            p_year:$parameters.p_year)
{
  AccountingDocument,
  LedgerFiscalYear,
  GLAccount,
  ClearingAccountingDocument,
  DocumentItemText,
  AssignmentReference,
  GLAccountName,
  MasterFixedAsset,
  ProfitCenter,
  ProfitCenterName,
  Region,
  Segment,
  FiscalYearVariant,
  FiscalYearPeriod,
  PostingDate,
  PostingKey,
  Supplier,
  SupplierName,
  CHECT,
  zaldt,
  ClearingDate,
  InvoiceNumber,
  AccountingDocumentHeaderText,
  SerialNumberFA,
  DocumentDate,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  AmountInCompanyCodeCurrency,
  @Semantics.currencyCode:true
  CompanyCodeCurrency,
  FiscalPeriod,
  WorkOrder
}
