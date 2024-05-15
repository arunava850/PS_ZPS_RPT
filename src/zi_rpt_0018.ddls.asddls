 @AbapCatalog.sqlViewName: 'ZIRPT0018'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0018 Interface View (ACDOCA & ProfCtr)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_0018 
with parameters
    
     p_qtr: abap.char(1),
     p_year: abap.char(4)
    
 as select from ZI_2_RPT_39 
                ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)

{
   key Ledger,
   key CompanyCode,
   key FiscalYear,
   Facilities,
   NodeValue,
   Storage,
   Location,  
   GroupAcc,
   GLAccount,
   PostingDate,
   CustomDt,
   GlobalCurrency,
   //LastYearDate,
   ZYEAR,
   ZMONTH,
   LYQTR,
   CYEAR,
   CYQTR,
   CQtr,
   CCMONTH,
   LYEAR,
   LYMTH,
   L2LYEAR,
   L2LYMTH,
   L2LYQTR,
   Revenue,
   
  
// Month Trend derivation
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYMTH'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CCMONTH = substring(CustomDt,5,2) and CYEAR is not null then Revenue end as REV_CYMTH,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYMTH'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYMTH = ZMONTH and LYEAR is not null then Revenue end as REV_LYMTH,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYMTH'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when L2LYMTH =  ZMONTH and L2LYEAR is not null then Revenue end as REV_L2LYMTH,
 
// Year Trend derivation
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LY'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null then Revenue  end as REV_LY,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'L2LY'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when L2LYEAR is not null then Revenue  end as REV_L2LY,
   
// QTD Trend derivation

   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR is not null then Revenue end as REV_CYQTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR = $parameters.p_qtr
   then Revenue end as REV_LYQTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when L2LYEAR is not null and L2LYQTR = $parameters.p_qtr
   then Revenue end as REV_L2LYQTD,
   
// YTD Trend derivation

   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null then Revenue end as REV_CYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
             then Revenue end as REV_LYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when L2LYEAR is not null and L2LYQTR <= $parameters.p_qtr 
             then Revenue end as REV_L2LYYTD,
   
// YearQuarter Trend derivation   
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYQ1'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CYQTR when '1' then Revenue end as REV_CYQ1,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYQ2'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CYQTR when '2' then Revenue end as REV_CYQ2,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYQ3'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CYQTR when '3' then Revenue end as REV_CYQ3,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYQ4'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CYQTR when '4' then Revenue end as REV_CYQ4,
   
   --------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYQ1'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYQTR = '1' //and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL') 
   then Revenue end as REV_LYQ1,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYQ2'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYQTR = '2' //and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
   then Revenue end as REV_LYQ2,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYQ3'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYQTR = '3' //and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
   then Revenue end as REV_LYQ3,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYQ4'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYQTR = '4' //and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
   then Revenue end as REV_LYQ4,
   
   ----------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYQ1'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYQTR when '1' then Revenue end as REV_L2LYQ1,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYQ2'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYQTR when '2' then Revenue end as REV_L2LYQ2,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYQ3'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYQTR when '3' then Revenue end as REV_L2LYQ3,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYQ4'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYQTR when '4' then Revenue end as REV_L2LYQ4,
   
 // YearMonth Trend derivation   
 
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM1'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '01' then Revenue end as REV_CYM1, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM2'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '02' then Revenue end as REV_CYM2, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM3'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '03' then Revenue end as REV_CYM3, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM4'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '04' then Revenue end as REV_CYM4, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM5'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '05' then Revenue end as REV_CYM5, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM6'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '06' then Revenue end as REV_CYM6, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM7'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '07' then Revenue end as REV_CYM7, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM8'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '08' then Revenue end as REV_CYM8, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM9'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '09' then Revenue end as REV_CYM9, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM10'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '10' then Revenue end as REV_CYM10, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM11'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '11' then Revenue end as REV_CYM11, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYM12'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case CCMONTH when '12' then Revenue end as REV_CYM12,
   
   -------------------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM1'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '01' then Revenue end as REV_LYM1, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM2'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '02' then Revenue end as REV_LYM2, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM3'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '03' then Revenue end as REV_LYM3, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM4'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '04' then Revenue end as REV_LYM4, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM5'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '05' then Revenue end as REV_LYM5, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM6'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '06' then Revenue end as REV_LYM6, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM7'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '07' then Revenue end as REV_LYM7, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM8'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '08' then Revenue end as REV_LYM8, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM9'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '09' then Revenue end as REV_LYM9, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM10'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '10' then Revenue end as REV_LYM10, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM11'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '11' then Revenue end as REV_LYM11, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYM12'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case LYMTH when '12' then Revenue end as REV_LYM12,
   
   ---------------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM1'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '01' then Revenue end as REV_L2LYM1, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM2'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '02' then Revenue end as REV_L2LYM2, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM3'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '03' then Revenue end as REV_L2LYM3, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM4'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '04' then Revenue end as REV_L2LYM4, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM5'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '05' then Revenue end as REV_L2LYM5, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM6'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '06' then Revenue end as REV_L2LYM6, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM7'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '07' then Revenue end as REV_L2LYM7, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM8'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '08' then Revenue end as REV_L2LYM8, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM9'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '09' then Revenue end as REV_L2LYM9, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM10'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '10' then Revenue end as REV_L2LYM10, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM11'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '11' then Revenue end as REV_L2LYM11, 
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_L2LYM12'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case L2LYMTH when '12' then Revenue end as REV_L2LYM12
   
}
