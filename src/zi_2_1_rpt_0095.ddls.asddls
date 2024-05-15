@AbapCatalog.sqlViewName: 'ZI21RPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0095 Composite view (Trend KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_1_RPT_0095 
with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
    
    as select from ZI_2_RPT_0095
    ( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )
    
    { key Ledger,
      key CompanyCode,
      key FiscalYear,
      key SourceLedger,
      key AccountingDocument,
      key LedgerGLLineItem,
      key GLAccountFlowType,
      key FiscalPeriodDate,
      GLAccount,
      HierarchyParentNode,
      Facilities,
      NodeValue,
      PostingDate,
      GlobalCurrency,
      CYEAR,
      CQtr,
      LYEAR,
      L2LYEAR,
      CYQTR,
      LYQTR,
      
      
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'CYQTD'
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  case when CYEAR is not null and CYQTR = CQtr 
  then AmountInGlobalCurrency end as FI_CURRENT_QTD,
  
  @AnalyticsDetails.query.axis: #ROWS
  @DefaultAggregation: #SUM
  @EndUserText.label: 'LYQTD'
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  case when LYEAR is not null and LYQTR = CQtr
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
  case when LYEAR is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL') 
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
