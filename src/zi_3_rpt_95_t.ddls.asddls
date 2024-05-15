@AbapCatalog.sqlViewName: 'ZI3RPT95T'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R95 - Interface view(time chars) -3'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_3_RPT_95_T 
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)

as select from ZI_2_RPT_95_T
( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
               

{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    LedgerFiscalYear,
    Facilities,
    GLAccount,
    ProfitCenter,
    FunctionalArea,
    BusinessArea,
    ControllingArea,
    PostingDate,
    GlobalCurrency,
    FiscalPeriod,
    ZQUARTER,
    ZMONTH,
    ZMONTH1,
    ZYEAR,
    ZLYEAR,
    ZL2LYEAR,
    ZLYMTH,
    ZL2LYMTH,
    ZLQUARTER,
    ZL2LYQTR,
    CQtr,
    CYEAR,
    CCMONTH,
    LYEAR,
    L2LYEAR,
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
    AmountInGlobalCurrency
} 
   where //CQtr       <= $parameters.p_qtr and
         FiscalYear <= $parameters.p_year 
        
