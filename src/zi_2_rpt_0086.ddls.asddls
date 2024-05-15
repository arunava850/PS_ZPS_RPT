@AbapCatalog.sqlViewName: 'ZI2RPT0086'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0086 - Interface View (Trend KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_RPT_0086 
with parameters
   
     p_qtr: abap.char(1),
     p_year: abap.char(4)
    
    as select from ZI_RPT_0086 ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
      
    association [0..1] to I_CompanyCode as _CompanyCode on  $projection.Owner = _CompanyCode.CompanyCode
{
    key HierarchyId,
    key Equity,
    key Ledger,
    key CompanyCode as Owner,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,

    _CompanyCode.CompanyCodeName as CompanyCodeName,
    NodeValue,
    //GroupAcc,
    GLAccount,
    CYEAR,
    LYEAR,
    PostingDate,
    AmountInGlobalCurrency,
    GlobalCurrency,  
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Beginning Balance'
    @Semantics.amount.currencyCode: 'GlobalCurrency' 
    case when LYEAR is not null and (Equity = 'NET INCOME'                      or
                                    Equity = 'Preferred Stock (CAPITAL STOCK)' or
                                    Equity = 'APIC'                            or
                                    Equity = 'Alloc Dist + /Cont -'            or
                                    Equity = 'NON-CASH DISTRIB'                or
                                    Equity = 'PROPERTY ACQ'                    or
                                    Equity = 'CONTRIBUTION'                    or
                                    Equity = 'DISTRIBUTION'                    or
                                    Equity = 'PROPERTY DISTRIB'                or
                                    Equity = 'PSBP Cash'                       or
                                    Equity = 'Other Activity')
                                     
            then sum(AmountInGlobalCurrency)  end as BEGIN_BAL,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Net Income'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'NET INCOME'
            then AmountInGlobalCurrency end as NetIncome,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Preferred Stock'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'Preferred Stock (CAPITAL STOCK)'
            then AmountInGlobalCurrency end as PreferredStock,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'APIC'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'APIC'
            then AmountInGlobalCurrency end as APIC,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Alloc Dist+/Cont -'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'Alloc Dist + /Cont -'
            then AmountInGlobalCurrency end as AllocDistCont,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NonCash Distr'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'NON-CASH DISTRIB'
            then AmountInGlobalCurrency end as NonCashDistr,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Property Acq'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'PROPERTY ACQ' 
            then AmountInGlobalCurrency end as PropertyAcq,
            
              
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Contribution'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'CONTRIBUTION'
            then AmountInGlobalCurrency end as Contribution,
                  
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Distribution'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'DISTRIBUTION'
            then AmountInGlobalCurrency end as Distribution,            
    
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Property Distr'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'PROPERTY DISTRIB' 
            then AmountInGlobalCurrency end as PropertyDistr,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'PSBP Cash'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'PSBP Cash'
            then AmountInGlobalCurrency end as PSBPCash,
            
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Other Activity'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and Equity = 'Other Activity'
            then AmountInGlobalCurrency end as OtherActivity
            
           
}
 where Equity <> 'GL Hierarchy Equity'
 
 group by HierarchyId,
          Equity,
          Ledger,
          CompanyCode,
          FiscalYear,
          SourceLedger,
          AccountingDocument,
          LedgerGLLineItem,
          _CompanyCode.CompanyCodeName,
          NodeValue,
          GroupAcc,
          GLAccount,
          CYEAR,
          LYEAR,
          PostingDate,
          AmountInGlobalCurrency,
          GlobalCurrency
