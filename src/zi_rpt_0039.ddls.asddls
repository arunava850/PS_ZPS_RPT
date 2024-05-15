@AbapCatalog.sqlViewName: 'ZIRPT0039'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developed & Expanded with Prof Hier'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_0039
with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
    
as select from ZB_RPT_0095 (P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate ) as a
//left outer join I_CalendarDate as f  on f.CalendarDate = $parameters.P_ToPostingDate

left outer join ZB_2_RPT_0039 as b on a.ProfitCenter = b.NodeValue

{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    key GLAccountFlowType,
    key FiscalPeriodDate,
    b.Facilities,
    b.NodeValue as NodeValue,
    b.Storage,
    b.Location,
    GLAccount,
    PostingDate,
    GlobalCurrency,
    LastYearDate,    
    ZQUARTER,
    ZLQUARTER,
    ZMONTH,
    ZMONTH1,
    ZYEAR,
    ZLYEAR,
    ZL2LYEAR,
    ZLYMTH,
    ZL2LYMTH,
    ZL2LYQTR,
    
    case when ZMONTH = '01' then '1'
         when ZMONTH = '02' then '1'
         when ZMONTH = '03' then '1'
         when ZMONTH = '04' then '2'
         when ZMONTH = '05' then '2'
         when ZMONTH = '06' then '2'
         when ZMONTH = '07' then '3'
         when ZMONTH = '08' then '3'
         when ZMONTH = '09' then '3'
         when ZMONTH = '10' then '4'
         when ZMONTH = '11' then '4'
         when ZMONTH = '12' then '4' end as CQtr,
      
    case when ZLYEAR = substring(PostingDate,1,4) //and ZMONTH >= substring(PostingDate,5,2)
              then substring(PostingDate,5,2)                                            end as LYQTR,
    
    case when ZYEAR = substring(PostingDate,1,4) 
              then substring($parameters.P_ToPostingDate,1,4)                            end as CYEAR,
        
    case when ZYEAR = substring(PostingDate,1,4) //and ZMONTH >= substring(PostingDate,5,2)
              then substring(PostingDate,5,2)                                            end as CYQTR,
              
    case when ZYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,5,2)                                            end as CYMTH,
                  
    case when ZYEAR = substring(PostingDate,1,4) //and ZMONTH = substring(PostingDate,5,2)
              then substring(PostingDate,5,2)                                            end as CCMONTH,
    
    case when ZLYEAR = substring(PostingDate,1,4) //then substring(PostingDate,1,4) end as LYEAR,
              then substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),1,4) end as LYEAR,
    
    case when ZLYEAR = substring(PostingDate,1,4) and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
              then substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),1,8) end as LYDATE,
              
    case when ZLYEAR = substring(PostingDate,1,4) and ZLYMTH = substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),5,2)
              //then substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),5,2) end as LYMTH,
              then substring(PostingDate,5,2)                                            end as LYMTH,
    
    case when ZL2LYEAR = substring(PostingDate,1,4)  
              //then substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-730,'NULL'),1,4) end as L2LYEAR,
              then substring(PostingDate,1,4)                                            end as L2LYEAR,
              
    case when ZL2LYEAR = substring(PostingDate,1,4) //and ZL2LYMTH = substring(PostingDate,5,2)
              //then substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-730,'NULL'),5,2) end as L2LYMTH, 
              then substring(PostingDate,5,2)                                            end as L2LYMTH,
              
    case when ZL2LYEAR = substring(PostingDate,1,4) //and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-730,'NULL')
              then substring(PostingDate,5,2)                                            end as L2LYQTR,
     
// Revenue KPIs derivation
          
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Revenue'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when a.GLAccount >= '0000400000' and a.GLAccount <= '0000402030' then a.AmountInGlobalCurrency end as Revenue,
    
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Direct Expenses'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when a.GLAccount >= '0000500000' and a.GLAccount <= '0000506330' then a.AmountInGlobalCurrency end as DirExp,
    
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Direct Expenses'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when a.GLAccount >= '0000510000' and a.GLAccount <= '0000530000' then a.AmountInGlobalCurrency end as IndirExp
      
    } where a.GLAccount >= '0000400000' and a.GLAccount <= '0000530000'
           
           
           
           
