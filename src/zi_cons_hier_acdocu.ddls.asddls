@AbapCatalog.sqlViewName: 'ZICONHIERACDOCU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consolidation View with Hierarchy'
define view ZI_CONS_HIER_ACDOCU
with parameters
P_HIER     : fincs_ithry
as select from 
     I_CnsldtnGroupJrnlEntryItem as c  
join ZI_GR_MATRIX_HIER  as d on                            d.short_hryid   = $parameters.P_HIER
                                                       and d.nodecls       = c.ConsolidationChartOfAccounts
                                                       and d.hrynode       = c.FinancialStatementItem
join I_CnsldtnVersion as e on c.ConsolidationVersion  = e.ConsolidationVersion                                                    
{
  key d.short_hryid as FsItemHierarchy,  
  key d.hryvalfrom,
  key d.hryvalto,    
  key c.ConsolidationLedger,
  key ConsolidationDimension,
  key ConsolidationChartOfAccounts,  
  key FiscalYearPeriod,
  key Company,
  key ConsolidationUnit,
  key FinancialStatementItem, 
      GLRecordType,
      c.ConsolidationVersion,
      e.FiscalYearVariant,
      TransactionCurrency,
      LocalCurrency,
      c.GroupCurrency,
      BaseUnit,
      FiscalYear,
      FiscalPeriod,
      DocumentCategory,
      PartnerConsolidationUnit,
      ConsolidationGroup,
      CompanyCode,
      ConsolidationDocumentType,
      sum(AmountInTransactionCurrency) as AmountInTransactionCurrency,
      sum(AmountInLocalCurrency) as AmountInLocalCurrency,
      sum(AmountInGroupCurrency) as AmountInGroupCurrency,
      sum(QuantityInBaseUnit) as QuantityInBaseUnit    
}
where
d.short_hryid      = $parameters.P_HIER
group by
      d.short_hryid,
      d.hryvalfrom,
      d.hryvalto,    
      c.ConsolidationLedger,
      ConsolidationDimension,
      ConsolidationChartOfAccounts,  
      FiscalYearPeriod,
      Company,
      ConsolidationUnit,
      FinancialStatementItem, 
      GLRecordType,
      c.ConsolidationVersion,
      e.FiscalYearVariant,
      TransactionCurrency,
      LocalCurrency,
      c.GroupCurrency,
      BaseUnit,
      FiscalYear,
      FiscalPeriod,
      DocumentCategory,
      PartnerConsolidationUnit,
      ConsolidationGroup,
      CompanyCode,
      ConsolidationDocumentType
