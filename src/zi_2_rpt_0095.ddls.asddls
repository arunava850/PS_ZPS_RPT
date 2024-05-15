@AbapCatalog.sqlViewName: 'ZI2RPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0095- Composite View'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_RPT_0095
with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
   
as select from ZI_RPT_0095
( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )

{
 key Ledger,
 key CompanyCode,
 key FiscalYear,
 key SourceLedger,
 key AccountingDocument,
 key LedgerGLLineItem,
 key GLAccountFlowType,
 key FiscalPeriodDate,
 GLAccount,
 HierarchyParentNode,
 Facilities,
 NodeValue,
 PostingDate,
 GlobalCurrency,
 CYEAR,
 CQtr,
 LYEAR,
 //LYQTR,
 L2LYEAR,
 AmountInGlobalCurrency,
 
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
      when LYQTR = '12' then '4' end as LYQTR
 
  
}
 
