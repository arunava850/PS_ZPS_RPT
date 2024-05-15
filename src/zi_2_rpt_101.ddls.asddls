@AbapCatalog.sqlViewName: 'ZI2RPT101'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT101 InterfaceView(Other Time Chars-2)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_RPT_101
with parameters
    p_qtr           : abap.char(1),
    p_year          : abap.char(4)
    
 as select from ZI_RPT_101
               ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
 
{
    key FiscalYear,
    key Ledger,
    key CompanyCode,
    key SourceLedger,
    key ZYEAR,
    key ZLYEAR,
    key ZLYMTH, 
    key ZLQUARTER,
    key ZMONTH,
    GroupAcc, 
    GLAccount,
    PostingDate,
    CustomDt,
    GlobalCurrency, 
    ProfitCenter,
    Segment,
    ThirdPartyFacilities,
    CQtr,
    CYEAR,
    LYEAR,
  
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
  
// KPIs  
  
  AmountInGlobalCurrency,
  NewThirdPartyProgram,
  OnsitePropertyManagerPayroll,
  SupervisoryPay,
  RepairsandMaintenance,
  Marketing,
  CentralizedMgmtCosts,
  ShareBasedCompensation,
  Rebranding,
  OtherDirectPropertyCosts,
  NOnsitePropertyManagerPayroll,
  NSupervisoryPay,
  NRepairsandMaintenance,
  NMarketing,
  NCentralizedMgmtCosts,
  NOtherDirectPropertyCosts  
}
