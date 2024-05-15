@AbapCatalog.sqlViewName: 'ZI2RPT39'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0039 Interface View ( Trend KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_2_RPT_39 
with parameters
     
     p_qtr: abap.char(1),
     p_year: abap.char(4)
    
 as select from ZI_RPT_39 
               ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
 
{
   key Ledger,
   key CompanyCode,
   key FiscalYear,
   key SourceLedger,
   key AccountingDocument,
   key LedgerGLLineItem,
   Facilities,
   NodeValue,
   Storage,
   Market,
   Location,
   ProfitCenter,
   GroupAcc,
   GLAccount,
   GlobalCurrency,
   PostingDate,
   CustomDt,
   ZYEAR,
   ZMONTH,
   CCMONTH,
   LYMTH,
   L2LYMTH,
   CYEAR,
   LYEAR,
   L2LYEAR,
   CQtr,
   
   case when CYQTR = '01' then '1'
        when CYQTR = '02' then '1'
        when CYQTR = '03' then '1'
        when CYQTR = '04' then '2'
        when CYQTR = '05' then '2'
        when CYQTR = '06' then '2'
        when CYQTR = '07' then '3'
        when CYQTR = '08' then '3'
        when CYQTR = '09' then '3'
        when CYQTR = '10' then '4'
        when CYQTR = '11' then '4'
        when CYQTR = '12' then '4' end as CYQTR,
    
   
   case when LYQTR = '01' then '1'
        when LYQTR = '02' then '1'
        when LYQTR = '03' then '1'
        when LYQTR = '04' then '2'
        when LYQTR = '05' then '2'
        when LYQTR = '06' then '2'
        when LYQTR = '07' then '3'
        when LYQTR = '08' then '3'
        when LYQTR = '09' then '3'
        when LYQTR = '10' then '4'
        when LYQTR = '11' then '4'
        when LYQTR = '12' then '4' end as LYQTR,
        
   case when L2LYQTR = '01' then '1'
        when L2LYQTR = '02' then '1'
        when L2LYQTR = '03' then '1'
        when L2LYQTR = '04' then '2'
        when L2LYQTR = '05' then '2'
        when L2LYQTR = '06' then '2'
        when L2LYQTR = '07' then '3'
        when L2LYQTR = '08' then '3'
        when L2LYQTR = '09' then '3'
        when L2LYQTR = '10' then '4'
        when L2LYQTR = '11' then '4'
        when L2LYQTR = '12' then '4' end as L2LYQTR,

   @Semantics.amount.currencyCode: 'GlobalCurrency'
   Revenue,
   DirExp,
   IndirExp
   
}
