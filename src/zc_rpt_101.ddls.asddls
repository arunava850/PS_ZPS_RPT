@AbapCatalog.sqlViewName: 'ZCRPT101'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT101 ConsumptionView(Prop Mgmt Operations)'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true

define view ZC_RPT_101 
with parameters
    p_qtr           : abap.char(1),
    p_year          : abap.char(4)
    
    
as select from ZI_3_RPT_101
              ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
    
{
    key FiscalYear,
    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: false}
    @Consumption.filter.defaultValue: '0L'
    @AnalyticsDetails.query.variableSequence : 30
    @AnalyticsDetails.query.axis: #ROWS
    @AnalyticsDetails.query.totals: #SHOW
    @AnalyticsDetails.query.display: #KEY_TEXT
    @EndUserText.label: 'Ledger'
    key Ledger,
    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
    @AnalyticsDetails.query.variableSequence : 30
    @AnalyticsDetails.query.axis: #ROWS
    @AnalyticsDetails.query.totals: #SHOW
    @AnalyticsDetails.query.display: #KEY_TEXT
    @EndUserText.label: 'Company Code'
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
    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
    @AnalyticsDetails.query.variableSequence : 30
    @AnalyticsDetails.query.axis: #ROWS
    @AnalyticsDetails.query.totals: #SHOW
    @AnalyticsDetails.query.display: #KEY_TEXT
    @EndUserText.label: 'Profit Center' 
    ProfitCenter,
    Segment,
    ThirdPartyFacilities,
    CQtr,
    CYEAR,
    LYEAR,

// Measures

   NewThirdPartyProgram_CYQTD,
   NewThirdPartyProgram_LYQTD,
   NewThirdPartyProgram_CYYTD,
   NewThirdPartyProgram_LYYTD,
   OnsitePropManagerPay_CYQTD,
   OnsitePropManagerPay_LYQTD,
   OnsitePropManagerPay_CYYTD,
   OnsitePropManagerPay_LYYTD,
   SupervisoryPay_CYQTD,
   SupervisoryPay_LYQTD,
   SupervisoryPay_CYYTD,
   SupervisoryPay_LYYTD,
   RepairsandMaintenance_CYQTD,
   RepairsandMaintenance_LYQTD,
   RepairsandMaintenance_CYYTD,
   RepairsandMaintenance_LYYTD,
   Marketing_CYQTD,
   Marketing_LYQTD,
   Marketing_CYYTD,
   Marketing_LYYTD,
   CentralizedMgmtCosts_CYQTD,
   CentralizedMgmtCosts_LYQTD,
   CentralizedMgmtCosts_CYYTD,
   CentralizedMgmtCosts_LYYTD,
   ShareBasedCompensation_CYQTD,
   ShareBasedCompensation_LYQTD,
   ShareBasedCompensation_CYYTD,
   ShareBasedCompensation_LYYTD,
   Rebranding_CYQTD,
   Rebranding_LYQTD,
   Rebranding_CYYTD,
   Rebranding_LYYTD,
   OtherDirectPropertyCosts_CYQTD,
   OtherDirectPropertyCosts_LYQTD,
   OtherDirectPropertyCosts_CYYTD,
   OtherDirectPropertyCosts_LYYTD,
   NOnsitePropManagerPay_CYQTD,
   NOnsitePropManagerPay_LYQTD,
   NOnsitePropManagerPay_CYYTD,
   NOnsitePropManagerPay_LYYTD,
   NSupervisoryPay_CYQTD,
   NSupervisoryPay_LYQTD,
   NSupervisoryPay_CYYTD,
   NSupervisoryPay_LYYTD,
   NRepairsandMaintenance_CYQTD,
   NRepairsandMaintenance_LYQTD,
   NRepairsandMaintenance_CYYTD,
   NRepairsandMaintenance_LYYTD,
   NMarketing_CYQTD,
   NMarketing_LYQTD,
   NMarketing_CYYTD,
   NMarketing_LYYTD,
   NCentralizedMgmtCosts_CYQTD,
   NCentralizedMgmtCosts_LYQTD,
   NCentralizedMgmtCosts_CYYTD,
   NCentralizedMgmtCosts_LYYTD,
   NOtherDirectPropCosts_CYQTD,
   NOtherDirectPropCosts_LYQTD,
   NOtherDirectPropCosts_CYYTD,
   NOtherDirectPropCosts_LYYTD 
}
