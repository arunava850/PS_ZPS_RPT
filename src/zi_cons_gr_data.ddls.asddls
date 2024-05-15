@AbapCatalog.sqlViewName: 'ZCONSGRDATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consolidated GR Data'
// Analytics Query

define view ZI_CONS_GR_DATA
  with parameters
    P_FISCPER : fis_jahrper_conv,
    P_MODE    : abap.char(3),
    P_HIER    : fincs_ithry
  as select from ZI_CONS_GR_QTD_ACDOCU (P_FISCPER : $parameters.P_FISCPER,P_MODE: $parameters.P_MODE,P_HIER:    $parameters.P_HIER) as A
    join         ZI_CONS_GR_YTD_ACDOCU (P_FISCPER : $parameters.P_FISCPER,P_MODE: $parameters.P_MODE,P_HIER:    $parameters.P_HIER) as B on  A.FinancialStatementItem = B.FinancialStatementItem
                                                                                                                                         and A.report_mode            = B.record_mode
                                                                                                                                         and                                                   //VEL Fixed it on Last Day
                                                                                                                                             A.ConsolidationVersion   = B.ConsolidationVersion //VEL Fixed it on Last Day
{
  key A.FsItemHierarchy,
  key A.ConsolidationLedger,
  key A.ConsolidationDimension,
  key A.ConsolidationChartOfAccounts,
  key A.Company,
  key A.ConsolidationUnit,
  key A.FinancialStatementItem,
      A.ConsolidationVersion,
      A.GroupCurrency,
      A.ConsolidationGroup,
      A.CompanyCode,
      A.FiscalYearVariant,
      A.GLRecordType,
      A.report_mode,
      A.CY_QTD_AmountInGC,
      A.PY_QTD_AmountInGC,
      B.CY_YTD_AmountInGC,
      B.PY_YTD_AmountInGC,
      A.PY2YTD_AmountInGC,
      (A.CY_QTD_AmountInGC-A.PY_QTD_AmountInGC) as QTD_Change,
      (B.CY_YTD_AmountInGC-B.PY_YTD_AmountInGC) as YTD_Change
}
