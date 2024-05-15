@AbapCatalog.sqlViewName: 'ZIRPT101'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT101 Interface View(ACDOCA & Porf Ctr)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_101 with parameters
    p_qtr           : abap.char(1),
    p_year          : abap.char(4) 
    
as select from ZI_RPT_95 
              ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year) as a

inner join cepc as b on a.ProfitCenter = b.prctr and
                                 (b.segment = 'PS_3PC' or
                                 b.segment = 'PS_3PUC')
                                 
inner join cepct as c on b.prctr = c.prctr and
                         b.kokrs = c.kokrs
                  
{
    
    key a.FiscalYear,
    key a.Ledger,
    key a.CompanyCode,
    key a.SourceLedger,
    key a.ZYEAR,
    key a.ZLYEAR,
    key a.ZLYMTH, 
    key a.ZLQUARTER,
    key a.ZMONTH,
    a.GroupAcc,
    a.GLAccount,
    a.PostingDate,
    a.CustomDt,
    a.GlobalCurrency, 
    b.prctr   as ProfitCenter,
    b.segment as Segment,
    c.ltext   as ThirdPartyFacilities,
    
    
    case when a.ZMONTH = '01' then '1'
         when a.ZMONTH = '02' then '1'
         when a.ZMONTH = '03' then '1'
         when a.ZMONTH = '04' then '2'
         when a.ZMONTH = '05' then '2'
         when a.ZMONTH = '06' then '2'
         when a.ZMONTH = '07' then '3'
         when a.ZMONTH = '08' then '3'
         when a.ZMONTH = '09' then '3'
         when a.ZMONTH = '10' then '4'
         when a.ZMONTH = '11' then '4'
         when a.ZMONTH = '12' then '4' end as CQtr, 
    
    case when a.ZLYEAR = substring(a.PostingDate,1,4) 
              then substring(a.PostingDate,5,2)        end as LYQTR,
    
    case when a.ZYEAR = substring(a.PostingDate,1,4) 
              then substring(a.PostingDate,1,4)        end as CYEAR,
        
    case when a.ZYEAR = substring(a.PostingDate,1,4)  
              then substring(a.PostingDate,5,2)        end as CYQTR, 
              
    case when ZLYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)          end as LYEAR,
              
  
  
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
    a.AmountInGlobalCurrency,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'NewThirdPartyProgram'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency' 
  case when (a.GroupAcc >= '0000427000' and a.GroupAcc <= '0000427030') and
            b.segment = 'PS_3PC' then sum(a.AmountInGlobalCurrency) end as NewThirdPartyProgram,
            
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'OnsitePropertyManagerPayroll'
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  case when (a.GroupAcc >= '0000500200' and a.GroupAcc <= '0000500510') and
            b.segment = 'PS_3PUC' then sum(a.AmountInGlobalCurrency) end as OnsitePropertyManagerPayroll,
            
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'SupervisoryPay'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'         
  case when (a.GroupAcc >= '0000510000' and a.GroupAcc <= '0000510050') or a.GroupAcc = '0000556100' and 
            b.segment = 'PS_3PC' then sum(a.AmountInGlobalCurrency) end as SupervisoryPay,
            
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'RepairsandMaintenance'
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GlobalCurrency' 
  case when (a.GroupAcc >= '0000500700' and a.GroupAcc <= '0000501950') and
            b.segment = 'PS_3PUC' then sum(a.AmountInGlobalCurrency) end as RepairsandMaintenance, 
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Marketing'
  @DefaultAggregation: #SUM  
  @Semantics.amount.currencyCode: 'GlobalCurrency'         
  case when ((a.GroupAcc >= '0000505500' and a.GroupAcc <= '0000505560')  and b.segment = 'PS_3PUC') or  
            (a.GroupAcc = '0000556650' and b.segment = 'PS_3PC')
            then sum(a.AmountInGlobalCurrency) end as Marketing,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'CentralizedMgmtCosts'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'          
  case when ((a.GroupAcc >= '0000510500' and a.GroupAcc <= '0000510870') and b.segment = 'PS_3PUC' )or  
            (a.GroupAcc = '0000556250' and b.segment = 'PS_3PC')
             then sum(a.AmountInGlobalCurrency) end as CentralizedMgmtCosts, 
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'ShareBasedCompensation'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'         
  case when a.GroupAcc = '0000556800'  and  b.segment = 'PS_3PC'
                                  then sum(a.AmountInGlobalCurrency) end as ShareBasedCompensation,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Rebranding'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'                               
  case when a.GroupAcc = '0000557100' and b.segment = 'PS_3PC' 
                                  then sum(a.AmountInGlobalCurrency) end as Rebranding,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'OtherDirectPropertyCosts'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'                                
  case when ((a.GroupAcc >= '0000506000' and a.GroupAcc <= '0000506330') and b.segment = 'PS_3PUC') or
            ((a.GroupAcc = '0000556600'  or a.GroupAcc = '0000556700'  or a.GroupAcc = '0000556710') and b.segment = 'PS_3PC') 
            then sum(a.AmountInGlobalCurrency) end as OtherDirectPropertyCosts,
            
 // Note-A KPIs
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'NoteA-OnsitePropertyManagerPayroll'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency' 
  case when (a.GroupAcc >= '0000500200' and a.GroupAcc <= '0000500510') and
            b.segment = 'PS_3PUC' then sum(a.AmountInGlobalCurrency) end as NOnsitePropertyManagerPayroll,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'NoteA-SupervisoryPay'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'         
  case when ((a.GroupAcc >= '0000510000' and a.GroupAcc <= '0000510050') and b.segment = 'PS_3PUC') 
       then sum(a.AmountInGlobalCurrency) end as NSupervisoryPay,
            
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'NoteA-RepairsandMaintenance'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  case when (a.GroupAcc >= '0000500700' and a.GroupAcc <= '0000501950') and
            b.segment = 'PS_3PUC' then sum(a.AmountInGlobalCurrency) end as NRepairsandMaintenance, 
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'NoteA-Marketing'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'          
  case when (a.GroupAcc >= '0000505500' and a.GroupAcc <= '0000505560') and
            b.segment = 'PS_3PUC' then sum(a.AmountInGlobalCurrency) end as NMarketing, 
            
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'NoteA-CentralizedMgmtCosts'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'          
  case when (a.GroupAcc >= '0000510500' and a.GroupAcc <= '0000510870') and
            b.segment = 'PS_3PUC' then sum(a.AmountInGlobalCurrency) end as NCentralizedMgmtCosts,
            
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'NoteA-OtherDirectPropertyCosts'
  @DefaultAggregation: #SUM 
  @Semantics.amount.currencyCode: 'GlobalCurrency'                                
  case when (a.GroupAcc >= '0000506000' and a.GroupAcc <= '0000506330') and
            b.segment = 'PS_3PUC' then sum(a.AmountInGlobalCurrency)  end as NOtherDirectPropertyCosts          
}   
             
  where (a.GroupAcc >= '0000427000' and a.GroupAcc <= '0000427030') or
        (a.GroupAcc >= '0000500200' and a.GroupAcc <= '0000500510') or
        (a.GroupAcc >= '0000510000' and a.GroupAcc <= '0000510050') or
        (a.GroupAcc = '0000556100')                                 or
        (a.GroupAcc >= '0000500700' and a.GroupAcc <= '0000501950') or
        (a.GroupAcc >= '0000505500' and a.GroupAcc <= '0000505560') or
        (a.GroupAcc = '0000556650')                                 or
        (a.GroupAcc >= '0000510500' and a.GroupAcc <= '0000510870') or
        (a.GroupAcc = '0000556250')                                 or
        (a.GroupAcc = '0000556800')                                 or
        (a.GroupAcc = '0000557100')                                 or
        (a.GroupAcc >= '0000506000' and a.GroupAcc <= '0000506330') or
        (a.GroupAcc = '0000556600')                                 or
        (a.GroupAcc = '0000556700')                                 or
        (a.GroupAcc = '0000556710')    

group by
    a.Ledger,
    a.CompanyCode,
    a.FiscalYear,
    a.SourceLedger,
    a.GroupAcc,
    a.GLAccount,
    a.PostingDate,
    a.CustomDt,
    a.GlobalCurrency, 
    a.ZYEAR,
    a.ZLYEAR,
    a.ZLYMTH, 
    a.ZLQUARTER,
    a.ZMONTH,                                  
    b.prctr,
    b.segment,
    c.ltext,
    a.AmountInGlobalCurrency
