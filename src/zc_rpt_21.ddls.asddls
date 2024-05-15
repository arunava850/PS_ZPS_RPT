@AbapCatalog.sqlViewName: 'ZCRPT21'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0021 Cons Statement of Equity & NCI'
@Analytics.query: true
define view ZC_RPT_21
  with parameters
    @Consumption.defaultValue: '$'
    @Consumption.valueHelp: '_CnsldtnUnitHierDir'
    P_ConsolidationUnitHierarchy : fincs_hryid_consunit,
    @Consumption.defaultValue: '$'
    @Consumption.valueHelp: '_ProfitCenterHierDir'
    P_ConsolidationPrftCtrHier   : fincs_hryid_profitcenter,
    @Consumption.defaultValue: '$'
    @Consumption.valueHelp: '_SegmentHierDir'
    P_ConsolidationSegmentHier   : fincs_hryid_segment,
    @Semantics.businessDate.at: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate                    : vdm_v_key_date,
    @Consumption.valueHelpDefinition: [{
     entity: {
         name:    'I_CnsldtnRptgItmHierDirVH',
         element: 'ConsolidationReportingItemHier'
             }
    }]
    P_ConsolidationRptgItemHier  : fincs_rihry,
    @Consumption.valueHelpDefinition: [{
     entity: {
         name:    'I_CnsldtnRptgRuleVarVH',
         element: 'ConsolidationReportingRuleID'
             }
    }]
    P_ConsolidationRptgRuleID    : fincs_rptid

  as select from ZI_RPT_21
                 ( P_ConsolidationUnitHierarchy:    $parameters.P_ConsolidationUnitHierarchy,
                        P_ConsolidationPrftCtrHier:      $parameters.P_ConsolidationPrftCtrHier,
                        P_ConsolidationSegmentHier:      $parameters.P_ConsolidationSegmentHier,
                        P_KeyDate:                       $parameters.P_KeyDate,
                        P_ConsolidationRptgItemHier:     $parameters.P_ConsolidationRptgItemHier,
                        P_ConsolidationRptgRuleID :  $parameters.P_ConsolidationRptgRuleID )
{
  key ConsolidationLedger,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationDocumentNumber,
  key ConsolidationPostingItem,
      @Semantics.currencyCode:true
      TransactionCurrency,
      ConsolidationUnit,
      ConsolidationChartOfAccounts,
      FinancialStatementItem,
      CompanyCode,
      SubItemCategory,
      SubItem,
      AmountInTransactionCurrency,
      FiscalPeriod,
      FiscalYearPeriod,
      FiscalYearVariant,
      PeriodMode,
      PostingDate,
      ChartOfAccounts,
      GLAccount,
      CostCenter,
      ProfitCenter,
      Qtr,
      @AnalyticsDetails.query.axis: #ROWS
      @EndUserText.label: 'Reporting Item'
      ConsolidationReportingItem,
      @AnalyticsDetails.query.axis: #COLUMNS
      @EndUserText.label: 'CumalativePreferred'
      CumalativePreferred,
      @AnalyticsDetails.query.axis: #COLUMNS
      @EndUserText.label: 'CumalativeCommon'
      CumalativeCommon,
      @AnalyticsDetails.query.axis: #COLUMNS
      @EndUserText.label: 'CumalativePaidIn'
      CumalativePaidIn,

      @AnalyticsDetails.query.axis: #COLUMNS
      @EndUserText.label: 'CumalativeAccumulated'
      CumalativeAccumulated,
      @AnalyticsDetails.query.axis: #COLUMNS
      @EndUserText.label: 'AccumulatedOtherComprehensive'
      AccumulatedOtherComprehensive,
      @AnalyticsDetails.query.axis: #COLUMNS
      @EndUserText.label: 'NonControlling'
      NonControlling


}
