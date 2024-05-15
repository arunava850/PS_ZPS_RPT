@AbapCatalog.sqlViewName: 'ZIRPT39'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developed & Expanded with Prof Hier'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_39
with parameters
     
     p_qtr: abap.char(1),
     p_year: abap.char(4)
    
as select from ZI_RPT_95 ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year) as a

left outer join ZB_2_RPT_0039 as b on a.ProfitCenter = b.NodeValue
                                      

{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    b.Facilities,
    b.NodeValue as NodeValue,
    b.Storage,
    b.Market,
    b.Location,
    b.District,
    a.ProfitCenter,
    GroupAcc,
    GLAccount,
    PostingDate,
    CustomDt,
    GlobalCurrency,
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
      
    case when ZLYEAR = substring(PostingDate,1,4)
              then substring(PostingDate,5,2)                                            end as LYQTR,
    
    case when ZYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                                            end as CYEAR,
        
    case when ZYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,5,2)                                            end as CYQTR,
                  
    case when ZYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,5,2)                                            end as CCMONTH,
    
    case when ZLYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                                            end as LYEAR,
              
    case when ZLYEAR = substring(PostingDate,1,4) and ZLYMTH = substring(PostingDate,5,2)
              then substring(PostingDate,5,2)                                            end as LYMTH,
    
    case when ZL2LYEAR = substring(PostingDate,1,4)  
              then substring(PostingDate,1,4)                                            end as L2LYEAR, 
              
    case when ZL2LYEAR = substring(PostingDate,1,4) and ZL2LYMTH = substring(PostingDate,5,2)
              then substring(PostingDate,5,2)                                            end as L2LYMTH,
              
    case when ZL2LYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,5,2)                                            end as L2LYQTR,
     
// Revenue KPIs derivation
          
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Revenue'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when a.GroupAcc >= '0000400000' and a.GroupAcc <= '0000402030' then a.AmountInGlobalCurrency end as Revenue,
    
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Direct Expenses'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when a.GroupAcc >= '0000500000' and a.GroupAcc <= '0000506330' then a.AmountInGlobalCurrency end as DirExp,
    
    @AnalyticsDetails.query.axis: #COLUMNS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Indirect Expenses'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when a.GroupAcc >= '0000510000' and a.GroupAcc <= '0000530000' then a.AmountInGlobalCurrency end as IndirExp
      
    } where a.GroupAcc >= '0000400000' and a.GroupAcc <= '0000530000'
           
           
           
           
