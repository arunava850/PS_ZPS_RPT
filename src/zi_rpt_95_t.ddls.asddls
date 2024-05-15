@AbapCatalog.sqlViewName: 'ZIRPT95T'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R95 - Interface view(time chars)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_95_T
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)
     
 as select from ZB_2_RPT_95_T
  ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    LedgerFiscalYear,
    GLAccount,
    ProfitCenter,
    FunctionalArea,
    BusinessArea,
    ControllingArea,
    PostingDate,
    GlobalCurrency,
    AmountInGlobalCurrency,
    FiscalPeriod,
    CustomDt,    
    
    case substring(CustomDt,5,2) when  '01' then '1'
             when  '02' then '1'
              when  '03' then '1'
              when  '04' then '2'
              when  '05' then '2'
              when  '06' then '2'
              when  '07' then '3'
              when  '08' then '3'
              when  '09' then '3'
              when  '10' then '4'
              when  '11' then '4'
              when  '12' then '4'
               else ''
                 end                               as ZQUARTER,
   substring(CustomDt,5,2)      as ZMONTH,
   
   case substring(CustomDt,5,2) when  '01' then 'Jan'
                 when  '02' then 'Feb'
                  when  '03' then 'Mar'
                  when  '04' then 'Apr'
                  when  '05' then 'May'
                  when  '06' then 'Jun'
                  when  '07' then 'Jul'
                  when  '08' then 'Aug'
                  when  '09' then 'Sep'
                  when  '10' then 'Oct'
                  when  '11' then 'Nov'
                  when  '12' then 'Dec'
                   else ''
                     end                          as ZMONTH1,
                     
   substring(CustomDt,1,4)     as ZYEAR,
   
   substring(DATS_ADD_DAYS(CustomDt,-365,'NULL'),1,4) as ZLYEAR,
   substring(DATS_ADD_DAYS(CustomDt,-730,'NULL'),1,4) as ZL2LYEAR,
   
   substring(DATS_ADD_DAYS(CustomDt,-365,'NULL'),5,2) as ZLYMTH,
   substring(DATS_ADD_DAYS(CustomDt,-730,'NULL'),5,2) as ZL2LYMTH,
   
   case substring(DATS_ADD_DAYS(CustomDt,-365,'NULL'),5,2) 
                  when  '01' then '1'
                  when  '02' then '1'
                  when  '03' then '1'
                  when  '04' then '2'
                  when  '05' then '2'
                  when  '06' then '2'
                  when  '07' then '3'
                  when  '08' then '3'
                  when  '09' then '3'
                  when  '10' then '4'
                  when  '11' then '4'
                  when  '12' then '4'
                   else '' end                             as ZLQUARTER,
                   
   case substring(DATS_ADD_DAYS(CustomDt,-730,'NULL'),5,2) 
                  when  '01' then '1'
                  when  '02' then '1'
                  when  '03' then '1'
                  when  '04' then '2'
                  when  '05' then '2'
                  when  '06' then '2'
                  when  '07' then '3'
                  when  '08' then '3'
                  when  '09' then '3'
                  when  '10' then '4'
                  when  '11' then '4'
                  when  '12' then '4'
                   else '' end                             as ZL2LYQTR            
    
}
