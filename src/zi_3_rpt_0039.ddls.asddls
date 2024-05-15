@AbapCatalog.sqlViewName: 'ZI3RPT0039'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0039 Interface View ( Trend KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_3_RPT_0039 
with parameters

     p_mth: abap.char(2),
     p_qtr: abap.char(1),
     p_year: abap.char(4)
    
as select from ZI_2_RPT_39 
              (p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)

{

key Ledger,
key CompanyCode,
key FiscalYear,
key SourceLedger,
key AccountingDocument,
key LedgerGLLineItem,
Facilities,
ProfitCenter,
Storage,
Market,
PostingDate,
CCMONTH,
CYEAR,
CYQTR,
LYQTR,
LYEAR,
LYMTH,
CQtr,
GroupAcc,
GLAccount,
GlobalCurrency,
@Semantics.amount.currencyCode: 'GlobalCurrency'
Revenue,
DirExp,
IndirExp,

// Revenue KPIs

   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR = $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then Revenue end as REV_CYQTD,
 
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR = $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then Revenue end as REV_LYQTD,
       
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then Revenue end as REV_CYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'REV_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr and CCMONTH <= $parameters.p_mth
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
       
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'DIR_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr and CCMONTH <= $parameters.p_mth
         then DirExp end as DIR_CYQTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'DIR_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR = $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then DirExp end as DIR_LYQTD,
        
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'DIR_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then DirExp  end as DIR_CYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'DIR_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr and CCMONTH <= $parameters.p_mth
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
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR = $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then IndirExp end as IND_CYQTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR = $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then IndirExp end as IND_LYQTD,
        
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr and CCMONTH <= $parameters.p_mth
        then IndirExp  end as IND_CYYTD,
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'IND_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr and CCMONTH <= $parameters.p_mth
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
   
} where Market is not null
