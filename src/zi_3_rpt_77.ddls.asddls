@AbapCatalog.sqlViewName: 'ZI3RPT77'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R77 - Interface View (Trend KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_3_RPT_77 
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)

as select from ZI_2_RPT_77
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
    LossesPaid,
    Claims,
    ReservesAccrued,
    ReservesNonCore,
    Underwriting,
    Payroll,
    ThirdParty,
    CreditCard,    
    
// First Page KPIs - Tenant
    
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
   then AmountInGlobalCurrency end as CYQTD,
  
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR = $parameters.p_qtr
   then AmountInGlobalCurrency end as LYQTD,
  
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then AmountInGlobalCurrency end as CYYTD,
  
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then AmountInGlobalCurrency  end as LYYTD,            
 
// Second Page KPIs - Tenant

   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'LossesPaid_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then LossesPaid end as LossesPaid_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'LossesPaid_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then LossesPaid end as LossesPaid_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'LossesPaid_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then LossesPaid end as LossesPaid_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'LossesPaid_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then LossesPaid end as LossesPaid_LYYTD,
   -------------------------------------------------------------
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Claims_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then Claims end as Claims_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Claims_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then Claims end as Claims_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Claims_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then Claims end as Claims_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Claims_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then Claims end as Claims_LYYTD,
   ------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesAccrued_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then ReservesAccrued end as ReservesAccrued_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesAccrued_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then ReservesAccrued end as ReservesAccrued_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesAccrued_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then ReservesAccrued end as ReservesAccrued_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesAccrued_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then ReservesAccrued end as ReservesAccrued_LYYTD,         
   ------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesNonCore_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then ReservesNonCore end as ReservesNonCore_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesNonCore_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then ReservesNonCore end as ReservesNonCore_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesNonCore_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then ReservesNonCore end as ReservesNonCore_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ReservesNonCore_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then ReservesNonCore end as ReservesNonCore_LYYTD,          
   ------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Underwriting_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then Underwriting end as Underwriting_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Underwriting_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then Underwriting end as Underwriting_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Underwriting_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then Underwriting end as Underwriting_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Underwriting_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then Underwriting end as Underwriting_LYYTD, 
   ------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Payroll_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then Payroll end as Payroll_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Payroll_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then Payroll end as Payroll_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Payroll_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then Payroll end as Payroll_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'Payroll_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then Payroll end as Payroll_LYYTD,   
   -------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ThirdParty_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then ThirdParty end as ThirdParty_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ThirdParty_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then ThirdParty end as ThirdParty_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ThirdParty_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then ThirdParty end as ThirdParty_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'ThirdParty_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then ThirdParty end as ThirdParty_LYYTD,  
   -------------------------------------------------------------
   
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'CreditCard_CYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR  = $parameters.p_qtr
            then CreditCard end as CreditCard_CYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'CreditCard_LYQTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when LYEAR is not null and LYQTR  = $parameters.p_qtr
            then CreditCard end as CreditCard_LYQTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'CreditCard_CYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency'
   case when CYEAR is not null and CYQTR <= $parameters.p_qtr
            then CreditCard end as CreditCard_CYYTD,
            
   @AnalyticsDetails.query.axis: #ROWS
   @DefaultAggregation: #SUM
   @EndUserText.label: 'CreditCard_LYYTD'
   @Semantics.amount.currencyCode: 'GlobalCurrency' 
   case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
            then CreditCard end as CreditCard_LYYTD                            
}
