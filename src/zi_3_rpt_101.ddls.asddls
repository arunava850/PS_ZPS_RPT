@AbapCatalog.sqlViewName: 'ZI3RPT101'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT101 CompositeView(Trend KPIs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_3_RPT_101
with parameters
    p_qtr           : abap.char(1),
    p_year          : abap.char(4)
    
 as select from ZI_2_RPT_101
                ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
    
{   
    key FiscalYear,
    key Ledger,
    key CompanyCode,
    key SourceLedger,
    key ZYEAR,
    key ZLYEAR,
    key ZLYMTH, 
    key ZLQUARTER,
    key ZMONTH,
    GroupAcc, 
    GLAccount,
    PostingDate,
    CustomDt,
    GlobalCurrency, 
    ProfitCenter,
    Segment,
    ThirdPartyFacilities,
    CQtr,
    CYEAR,
    LYEAR,
        
//  Trends of NewThirdPartyProgram

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NewThirdPartyProgram_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(NewThirdPartyProgram) end as NewThirdPartyProgram_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NewThirdPartyProgram_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(NewThirdPartyProgram) end as NewThirdPartyProgram_LYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NewThirdPartyProgram_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(NewThirdPartyProgram) end as NewThirdPartyProgram_CYYTD,

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NewThirdPartyProgram_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(NewThirdPartyProgram) end as NewThirdPartyProgram_LYYTD,
    
//  Trends of OnsitePropertyManagerPayroll

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OnsitePropManagerPay_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(OnsitePropertyManagerPayroll) end as OnsitePropManagerPay_CYQTD,    
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OnsitePropManagerPay_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(OnsitePropertyManagerPayroll) end as OnsitePropManagerPay_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OnsitePropManagerPay_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(OnsitePropertyManagerPayroll) end as OnsitePropManagerPay_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OnsitePropManagerPay_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(OnsitePropertyManagerPayroll) end as OnsitePropManagerPay_LYYTD,
    
//  Trends of SupervisoryPay

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SupervisoryPay_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr
         then sum(SupervisoryPay) end as SupervisoryPay_CYQTD,    
        
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SupervisoryPay_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(SupervisoryPay) end as SupervisoryPay_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SupervisoryPay_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(SupervisoryPay) end as SupervisoryPay_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SupervisoryPay_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(SupervisoryPay) end as SupervisoryPay_LYYTD,
    
//  Trends of RepairsandMaintenance

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'RepairsandMaintenance_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(RepairsandMaintenance) end as RepairsandMaintenance_CYQTD,        
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'RepairsandMaintenance_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(RepairsandMaintenance) end as RepairsandMaintenance_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'RepairsandMaintenance_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(RepairsandMaintenance) end as RepairsandMaintenance_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'RepairsandMaintenance_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(RepairsandMaintenance) end as RepairsandMaintenance_LYYTD,

//  Trends of Marketing

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Marketing_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr
         then sum(Marketing) end as Marketing_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Marketing_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(Marketing) end as Marketing_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Marketing_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(Marketing) end as Marketing_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Marketing_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(Marketing) end as Marketing_LYYTD,
    
//  Trends of CentralizedMgmtCosts

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'CentralizedMgmtCosts_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(CentralizedMgmtCosts) end as CentralizedMgmtCosts_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'CentralizedMgmtCosts_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(CentralizedMgmtCosts) end as CentralizedMgmtCosts_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'CentralizedMgmtCosts_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(CentralizedMgmtCosts) end as CentralizedMgmtCosts_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'CentralizedMgmtCosts_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(CentralizedMgmtCosts) end as CentralizedMgmtCosts_LYYTD,    
    
//  Trends of ShareBasedCompensation

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'ShareBasedCompensation_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(ShareBasedCompensation) end as ShareBasedCompensation_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'ShareBasedCompensation_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(ShareBasedCompensation) end as ShareBasedCompensation_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'ShareBasedCompensation_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(ShareBasedCompensation) end as ShareBasedCompensation_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'ShareBasedCompensation_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(ShareBasedCompensation) end as ShareBasedCompensation_LYYTD,     
    
//  Trends of Rebranding

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Rebranding_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr
         then sum(Rebranding) end as Rebranding_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Rebranding_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(Rebranding) end as Rebranding_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Rebranding_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(Rebranding) end as Rebranding_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Rebranding_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(Rebranding) end as Rebranding_LYYTD,        
    
//  Trends of OtherDirectPropertyCosts

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OtherDirectPropertyCosts_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(OtherDirectPropertyCosts) end as OtherDirectPropertyCosts_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OtherDirectPropertyCosts_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(OtherDirectPropertyCosts) end as OtherDirectPropertyCosts_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OtherDirectPropertyCosts_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(OtherDirectPropertyCosts) end as OtherDirectPropertyCosts_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'OtherDirectPropertyCosts_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(OtherDirectPropertyCosts) end as OtherDirectPropertyCosts_LYYTD,            
    
//  Trends of NOnsitePropertyManagerPayroll

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOnsitePropManagerPay_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(NOnsitePropertyManagerPayroll) end as NOnsitePropManagerPay_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOnsitePropManagerPay_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(NOnsitePropertyManagerPayroll) end as NOnsitePropManagerPay_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOnsitePropManagerPay_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(NOnsitePropertyManagerPayroll) end as NOnsitePropManagerPay_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOnsitePropManagerPay_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(NOnsitePropertyManagerPayroll) end as NOnsitePropManagerPay_LYYTD,    
    
//  Trends of NSupervisoryPay

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NSupervisoryPay_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr
         then sum(NSupervisoryPay) end as NSupervisoryPay_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NSupervisoryPay_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(NSupervisoryPay) end as NSupervisoryPay_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NSupervisoryPay_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(NSupervisoryPay) end as NSupervisoryPay_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NSupervisoryPay_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(NSupervisoryPay) end as NSupervisoryPay_LYYTD,  

//  Trends of NRepairsandMaintenance

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NRepairsandMaintenance_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(NRepairsandMaintenance) end as NRepairsandMaintenance_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NRepairsandMaintenance_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(NRepairsandMaintenance) end as NRepairsandMaintenance_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NRepairsandMaintenance_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(NRepairsandMaintenance) end as NRepairsandMaintenance_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NRepairsandMaintenance_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(NRepairsandMaintenance) end as NRepairsandMaintenance_LYYTD,  

//  Trends of NMarketing

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NMarketing_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr
         then sum(NMarketing) end as NMarketing_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NMarketing_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(NMarketing) end as NMarketing_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NMarketing_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(NMarketing) end as NMarketing_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NMarketing_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(NMarketing) end as NMarketing_LYYTD,  

//  Trends of NCentralizedMgmtCosts

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NCentralizedMgmtCosts_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr
         then sum(NCentralizedMgmtCosts) end as NCentralizedMgmtCosts_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NCentralizedMgmtCosts_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(NCentralizedMgmtCosts) end as NCentralizedMgmtCosts_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NCentralizedMgmtCosts_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(NCentralizedMgmtCosts) end as NCentralizedMgmtCosts_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NCentralizedMgmtCosts_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(NCentralizedMgmtCosts) end as NCentralizedMgmtCosts_LYYTD, 
         
//  Trends of NOtherDirectPropertyCosts

    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOtherDirectPropCosts_CYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null and CYQTR = $parameters.p_qtr 
         then sum(NOtherDirectPropertyCosts) end as NOtherDirectPropCosts_CYQTD,
         
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOtherDirectPropCosts_LYQTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR = $parameters.p_qtr
         then sum(NOtherDirectPropertyCosts) end as NOtherDirectPropCosts_LYQTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOtherDirectPropCosts_CYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when CYEAR is not null
         then sum(NOtherDirectPropertyCosts) end as NOtherDirectPropCosts_CYYTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'NOtherDirectPropCosts_LYYTD'
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr
         then sum(NOtherDirectPropertyCosts) end as NOtherDirectPropCosts_LYYTD     
}
   group by
    
    Ledger,
    CompanyCode,
    FiscalYear,
    SourceLedger,
    GroupAcc, 
    GLAccount,
    PostingDate,
    CustomDt,
    GlobalCurrency,
    ZYEAR,
    ZLYEAR,
    ZLYMTH,
    ZLQUARTER,
    ZMONTH,
    ProfitCenter,
    Segment,
    ThirdPartyFacilities,
    CQtr,
    CYEAR,
    LYEAR,
    CYQTR,
    LYQTR,
    AmountInGlobalCurrency,
    NewThirdPartyProgram,
    OnsitePropertyManagerPayroll,
    SupervisoryPay,
    CentralizedMgmtCosts,
    ShareBasedCompensation,
    Rebranding,
    OtherDirectPropertyCosts,
    NOnsitePropertyManagerPayroll,
    NSupervisoryPay,
    NCentralizedMgmtCosts,
    NOtherDirectPropertyCosts,
    RepairsandMaintenance,
    Marketing,
    NRepairsandMaintenance,
    NMarketing
    
