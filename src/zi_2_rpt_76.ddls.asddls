@AbapCatalog.sqlViewName: 'ZI2RPT76'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R95 - Interface view(time chars) -2'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_RPT_76 
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)    

as select from ZB_2_RPT_0095 as a right outer join ZI_RPT_95
               ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year) as b

on a.NodeValue = b.ProfitCenter
{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    a.Facilities,
    a.Segment,
    LedgerFiscalYear,
    GroupAcc,
    GLAccount,
    b.ProfitCenter,
    FunctionalArea,
    BusinessArea,
    ControllingArea,
    PostingDate,
    CustomDt,
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
    
    case when ZLYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,5,2)                   end as LYQTR,
    
    case when ZYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                   end as CYEAR,
        
    case when ZYEAR = substring(PostingDate,1,4)  
              then substring(PostingDate,5,2)                   end as CYQTR,
                  
    case when ZYEAR = substring(PostingDate,1,4)
              then substring(PostingDate,5,2)                   end as CCMONTH,
    
    case when ZLYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                   end as LYEAR,
    
    case when ZL2LYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                   end as L2LYEAR,
      
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    AmountInGlobalCurrency    

    }  where FiscalYear <> '0000' 
