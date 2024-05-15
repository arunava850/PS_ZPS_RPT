@AbapCatalog.sqlViewName: 'ZIRPT21'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consolidated Statement of Equity & NCI'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_21
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

  as select from I_MatrixConsolidationRptEnhcdC
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
      ConsolidationReportingItem,
      case
         when FiscalPeriod = '001' or
              FiscalPeriod = '002' or
              FiscalPeriod = '003'
         then 'Q1'
         when FiscalPeriod = '004' or
              FiscalPeriod = '005' or
              FiscalPeriod = '006'
         then 'Q2'
           when FiscalPeriod = '007' or
              FiscalPeriod = '008' or
              FiscalPeriod = '009'
         then 'Q3'
           when FiscalPeriod = '010' or
              FiscalPeriod = '011' or
              FiscalPeriod = '012'
         then 'Q4'
      end  as Qtr,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }

      case when
       FinancialStatementItem   = '0000300000' and
       ( SubItem = 'Z45' or
         SubItem = 'Z30' )
       then AmountInTransactionCurrency
       end as CumalativePreferred,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case when
      ( FinancialStatementItem   = '0000310000' and
        SubItem = 'Z33' or
        SubItem = 'Z41' or
        SubItem = 'Z42' or
        SubItem = 'Z31')
      then AmountInTransactionCurrency
      end  as CumalativeCommon,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case when
      ( FinancialStatementItem   = '0000320000' and
        SubItem = 'Z45' or
        SubItem = 'Z33' or
        SubItem = 'Z41' or
        SubItem = 'Z42' or
        SubItem = 'Z31' or
        SubItem = 'Z43'  or
        SubItem = 'Z44') or
      ( FinancialStatementItem   = '0000320020' ) or
      ( FinancialStatementItem   = '0000320010' and
       SubItem = 'Z50' or
       SubItem = 'Z51' or
       SubItem = 'Z54' ) or
      ( FinancialStatementItem   = '0000320030' and
       SubItem = 'Z52' or
       SubItem = 'Z53' )
      then AmountInTransactionCurrency
      end  as CumalativePaidIn,
      case when
      ( FinancialStatementItem   = '0000330000' ) or
      ( FinancialStatementItem   = '0000330010' ) or
      ( FinancialStatementItem   = '0000330020' ) or
      ( FinancialStatementItem   = '0000320040' )
       then AmountInTransactionCurrency
       end as CumalativeAccumulated,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case when
      ( FinancialStatementItem   = '0000372000' )
       then AmountInTransactionCurrency
       end as AccumulatedOtherComprehensive,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      case when
      ( FinancialStatementItem   = '0000370000' and
        SubItem = 'Z43' or
        SubItem = 'Z44' or
        SubItem = 'Z32' or
        SubItem = 'Z40' )
       then AmountInTransactionCurrency
       end as NonControlling


}

where
  (
    (
         FinancialStatementItem = '0000300000'
      or FinancialStatementItem = '0000310000'
      or FinancialStatementItem = '0000320000'
      or FinancialStatementItem = '0000320010'
      or FinancialStatementItem = '0000320020'
      or FinancialStatementItem = '0000320030'
      or FinancialStatementItem = '0000330000'
      or FinancialStatementItem = '0000330010'
      or FinancialStatementItem = '0000330020'
      or FinancialStatementItem = '0000330040'
      or FinancialStatementItem = '0000372000'
      or FinancialStatementItem = '0000370000'
    )
    and(
         SubItem                = 'Z30'
      or SubItem                = 'Z31'
      or SubItem                = 'Z32'
      or SubItem                = 'Z33'
      or SubItem                = 'Z40'
      or SubItem                = 'Z41'
      or SubItem                = 'Z42'
      or SubItem                = 'Z43'
      or SubItem                = 'Z44'
      or SubItem                = 'Z45'
      or SubItem                = 'Z50'
      or SubItem                = 'Z51'
      or SubItem                = 'Z52'
      or SubItem                = 'Z53'
      or SubItem                = 'Z54'



    )
  )
