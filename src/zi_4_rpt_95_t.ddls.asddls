@AbapCatalog.sqlViewName: 'ZI4RPT95T'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R95 - Interface view(Trends KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_4_RPT_95_T 
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)

as select from ZI_3_RPT_95_T
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
    CYQTR,
    LYQTR,
    AmountInGlobalCurrency,
    
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'CYQTD'
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  case when CYEAR is not null and CYQTR  = $parameters.p_qtr
  then AmountInGlobalCurrency end as FI_CURRENT_QTD,
  
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'LYQTD'
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  case when LYEAR is not null and LYQTR = $parameters.p_qtr
   then AmountInGlobalCurrency end as FI_LASTYR_QTD,
  
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'CYYTD'
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  case when CYEAR is not null 
            then AmountInGlobalCurrency end as FI_CURRENT_YTD,
  
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'LYYTD'
  @Semantics.amount.currencyCode: 'GlobalCurrency' 
  case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then AmountInGlobalCurrency  end as FI_LASTYR_YTD,
            
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'LY'
  @Semantics.amount.currencyCode: 'GlobalCurrency' 
  case when LYEAR is not null
            then AmountInGlobalCurrency end as FI_LASTYR,
            
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'L2LY'
  @Semantics.amount.currencyCode: 'GlobalCurrency' 
  case when L2LYEAR is not null
            then AmountInGlobalCurrency end as FI_L2LASTYR
}
