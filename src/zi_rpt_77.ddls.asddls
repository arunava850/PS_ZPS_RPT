@AbapCatalog.sqlViewName: 'ZIRPT77'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R77 - Interface View (Time Chars)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_77
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)    
     
as select from ZI_2_RPT_76
               ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year) 
{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    Facilities,
    LedgerFiscalYear,
    GroupAcc,
    GLAccount,
    ProfitCenter,
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
    AmountInGlobalCurrency,   

   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'LossesPaid'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when GroupAcc = '0000550020' then AmountInGlobalCurrency end as LossesPaid,
   
   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'Claims'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when GroupAcc = '0000550080' then AmountInGlobalCurrency end as Claims,
   
   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'ReservesAccrued'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when ((GroupAcc >= '0000550030' and GroupAcc <= '0000550040') or
             (GroupAcc >= '0000550090' and GroupAcc <= '0000550100'))
                                      then AmountInGlobalCurrency end as ReservesAccrued,
                                      
   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'ReservesNonCore'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when GroupAcc = '0000554900' or GroupAcc = '0000554910'
              then AmountInGlobalCurrency end as ReservesNonCore,
              
   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'Underwriting'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when GroupAcc = '0000550110' or GroupAcc = '0000550140'
              then AmountInGlobalCurrency end as Underwriting,              
   
   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'Payroll'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when GroupAcc = '0000550150' or GroupAcc = '0000550160'
              then AmountInGlobalCurrency end as Payroll,
              
   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'ThirdParty'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when GroupAcc = '0000550000'
              then AmountInGlobalCurrency end as ThirdParty,
              
   @AnalyticsDetails.query.axis: #COLUMNS
   @EndUserText.label: 'CreditCard'
   @DefaultAggregation: #SUM 
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when GroupAcc = '0000550170'
              then AmountInGlobalCurrency end as CreditCard 
    
    }  where (GroupAcc >= '0000420000' and GroupAcc <= '0000554910') 
