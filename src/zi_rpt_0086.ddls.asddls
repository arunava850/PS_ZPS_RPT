@AbapCatalog.sqlViewName: 'ZIRPT0086'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0086 - Interface View(ACDOCA & ProfCtr)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_0086 
with parameters
    
     p_qtr: abap.char(1),
     p_year: abap.char(4)

as select from ZB_RPT_0086 as a inner join ZI_RPT_95 ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year) as b

on a.NodeValue = b.GLAccount
{
   key HierarchyId,
   key Equity,
   key Ledger,
   key CompanyCode,
   key FiscalYear,
   key SourceLedger,
   key AccountingDocument,
   key LedgerGLLineItem,
   NodeValue,
   b.GroupAcc,
   b.GLAccount,
   b.PostingDate,
   b.GlobalCurrency,
     
   case when b.ZYEAR = substring(b.PostingDate,1,4) 
              then substring(PostingDate,1,4) end as          CYEAR,
              
   case when b.ZLYEAR = substring(b.PostingDate,1,4) 
              then substring(PostingDate,1,4) end as          LYEAR,
        
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   
   b.AmountInGlobalCurrency
     
    
} where b.GroupAcc <> ''
