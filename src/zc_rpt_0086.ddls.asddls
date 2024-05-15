@AbapCatalog.sqlViewName: 'ZCRPT0086'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0086 - Equity roll-forward for the year'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true

define view ZC_RPT_0086
with parameters

     p_qtr: abap.char(1),
     p_year: abap.char(4)    
    
    as select from ZI_2_RPT_0086 ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
    
{ 
  key HierarchyId,
  key Equity,
  key Ledger,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  key Owner,
  key FiscalYear,
  key SourceLedger,
  key AccountingDocument,
  key LedgerGLLineItem,
  CompanyCodeName,
  NodeValue,
  GLAccount,
  CYEAR,
  LYEAR,
  PostingDate,
  AmountInGlobalCurrency,
  GlobalCurrency,
  BEGIN_BAL,
  NetIncome,
  PreferredStock,
  APIC,
  AllocDistCont,
  NonCashDistr,
  PropertyAcq,
  Contribution,
  Distribution,
  PropertyDistr,
  PSBPCash,
  OtherActivity
}
