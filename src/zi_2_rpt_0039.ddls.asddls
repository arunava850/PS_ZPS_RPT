@AbapCatalog.sqlViewName: 'ZI2RPT0039'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0039 Interface View ( Trend KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_RPT_0039 
with parameters

    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
    
 as select from ZI_RPT_0039  
 (P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )
 
{
   key Ledger,
   key CompanyCode,
   key FiscalYear,
   key SourceLedger,
   key AccountingDocument,
   key LedgerGLLineItem,
   key GLAccountFlowType,
   key FiscalPeriodDate,
   Facilities,
   NodeValue,
   Storage,
   Location,
   GLAccount,
   GlobalCurrency,
   PostingDate,
  LastYearDate,
   ZYEAR,
   ZMONTH,
   CCMONTH,
   LYMTH,
   L2LYMTH,
   //L2LYQTR,
   CYEAR,
   LYEAR,
   L2LYEAR,
   CQtr,
   
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
        
   case when L2LYQTR = '01' then '1'
        when L2LYQTR = '02' then '1'
        when L2LYQTR = '03' then '1'
        when L2LYQTR = '04' then '2'
        when L2LYQTR = '05' then '2'
        when L2LYQTR = '06' then '2'
        when L2LYQTR = '07' then '3'
        when L2LYQTR = '08' then '3'
        when L2LYQTR = '09' then '3'
        when L2LYQTR = '10' then '4'
        when L2LYQTR = '11' then '4'
        when L2LYQTR = '12' then '4' end as L2LYQTR,

   @Semantics.amount.currencyCode: 'GlobalCurrency'
   Revenue,
   DirExp,
   IndirExp,
   
// Revenue KPIs
   
//   @AnalyticsDetails.query.axis: #ROWS
//   @DefaultAggregation: #SUM
//   @EndUserText.label: 'REV_CYQTD'
//   @Semantics.amount.currencyCode: 'GlobalCurrency'
//   case when CYEAR is not null then Revenue end as REV_CYQTD,
//   
//   @AnalyticsDetails.query.axis: #ROWS
//   @DefaultAggregation: #SUM
//   @EndUserText.label: 'REV_LYQTD'
//   @Semantics.amount.currencyCode: 'GlobalCurrency'
//   case when LYEAR is not null and LYQTR is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
//   then Revenue end as REV_LYQTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null then Revenue end as REV_CYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
             then Revenue end as REV_LYYTD,
   
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
   
   
// Direct Expenses KPIs
   
//   @AnalyticsDetails.query.axis: #ROWS
//   @DefaultAggregation: #SUM
//   @EndUserText.label: 'DIR_CYQTD'
//   @Semantics.amount.currencyCode: 'GlobalCurrency'
//   case when CYEAR is not null and CYQTR is not null then DirExp end as DIR_CYQTD,
//   
//   @AnalyticsDetails.query.axis: #ROWS
//   @DefaultAggregation: #SUM
//   @EndUserText.label: 'DIR_LYQTD'
//   @Semantics.amount.currencyCode: 'GlobalCurrency'
//   case when LYEAR is not null and LYQTR is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
//   then DirExp end as DIR_LYQTD,
//   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'DIR_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null then DirExp  end as DIR_CYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'DIR_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
             then DirExp end as DIR_LYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'DIR_LY'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null then DirExp  end as DIR_LY,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'L2LY'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when L2LYEAR is not null then DirExp  end as DIR_L2LY,
   
   
// Indirect Expenses KPIs
   
//   @AnalyticsDetails.query.axis: #ROWS
//   @DefaultAggregation: #SUM
//   @EndUserText.label: 'IND_CYQTD'
//   @Semantics.amount.currencyCode: 'GlobalCurrency'
//   case when CYEAR is not null and CYQTR is not null then IndirExp end as IND_CYQTD,
//   
//   @AnalyticsDetails.query.axis: #ROWS
//   @DefaultAggregation: #SUM
//   @EndUserText.label: 'IND_LYQTD'
//   @Semantics.amount.currencyCode: 'GlobalCurrency'
//   case when LYEAR is not null and LYQTR is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
//   then IndirExp end as IND_LYQTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null then IndirExp  end as IND_CYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
             then IndirExp end as IND_LYYTD,  
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_LY'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null then IndirExp end as IND_LY,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_L2LY'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when L2LYEAR is not null then IndirExp  end as IND_L2LY
//   
}
