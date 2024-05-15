@AbapCatalog.sqlViewName: 'ZCSRPT40Q01'
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@Analytics.variableCheck.implementedBy: 'className:cl_fincs_query_variable_check'
@Analytics.settings.runtimeExtensibility.allowed: true
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #NOT_ALLOWED
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED
@EndUserText.label: 'Cons Analyzer with Reporting Rules 01'
define view ZC_CnsldtnRpt40Q_01
  with parameters
    @AnalyticsDetails.query.variableSequence : 10
    @Consumption.defaultValue: '$'
    @Consumption.valueHelpDefinition: {
      entity: { name:    'ZFI_TIME_PERIODS',
                element: 'FiscalYearPeriod' }
    }
    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
    @EndUserText.label: 'Fiscal Period'
    P_FISCPER   : fis_jahrper_conv,

    @AnalyticsDetails.query.variableSequence : 30
    @Consumption.derivation: { lookupEntity: 'I_CnsldtnGlobalParameter', resultElement: 'ConsolidationChartOfAccounts' }
    P_ConsolidationChartOfAccounts : fc_itclg,

    @Consumption.hidden: true
    @Consumption.derivation: { lookupEntity: 'I_CnsldtnGlobalParameter', resultElement: 'FiscalYear' } 
    P_FiscalYear                   : ryear,

    @Consumption.hidden: true
    @Consumption.derivation: { lookupEntity: 'I_CnsldtnGlobalParameter', resultElement: 'FiscalPeriod' }
    P_FiscalPeriod                 : poper,

    @Consumption.derivation: { lookupEntity: 'I_CnsldtnGlobalParameter', resultElement: 'FiscalYearVariant' }
    @Consumption.hidden: true
    @Consumption.defaultValue: 'K4'    
    P_FiscalYearVariant            : fis_periv,

    @Consumption.derivation: { lookupEntity: 'I_CnsldtnGlobalParameter', resultElement: 'ConsolidationVersion' }
    @Consumption.hidden: true
    P_ConsolidationVersion         : fc_rvers,

    @AnalyticsDetails.query.variableSequence : 70
    @Consumption.hidden: true    
    @Consumption.defaultValue: '$'
    @Consumption.valueHelpDefinition: { 
        entity: { name: 'I_CnsldtnUnitHierDirVH', element: 'ConsolidationUnitHierarchy' } 
    }
    P_ConsolidationUnitHierarchy   : fincs_hryid_consunit,

    @AnalyticsDetails.query.variableSequence : 80
    @Consumption.hidden: true    
    @Consumption.defaultValue: '$'
    @Consumption.valueHelpDefinition: { 
        entity: { name: 'I_CnsldtnProfitCenterHierDirVH', element: 'AdditionalMasterDataHierarchy' } 
    }
    P_ConsolidationPrftCtrHier     : fincs_hryid_profitcenter,
    
    @AnalyticsDetails.query.variableSequence : 90
    @Consumption.hidden: true    
    @Consumption.defaultValue: '$'
    @Consumption.valueHelpDefinition: { 
        entity: { name: 'I_CnsldtnSegmentHierDirVH', element: 'ConsolidationSegmentHierarchy' }
    }
    P_ConsolidationSegmentHier     : fincs_hryid_segment,

    @AnalyticsDetails.query.variableSequence : 100
    @Consumption.valueHelpDefinition: { 
        entity: { name: 'I_CnsldtnRptgItmHierDirVH', element: 'ConsolidationReportingItemHier' } 
    }
    @Consumption.derivation: { 
        lookupEntity: 'I_CnsldtnRptgRuleVarAssgmt',
        resultElement: 'ConsolidationReportingItemHier',
        binding: [
            { targetElement: 'ConsolidationChartOfAccounts', type: #PARAMETER, value: 'P_ConsolidationChartOfAccounts' },
            { targetElement: 'ConsolidationReportingItemHier', type: #CONSTANT, value: 'X2' }]
    }
    P_ConsolidationRptgItemHier    : fincs_rihry,

    @AnalyticsDetails.query.variableSequence : 111
    @Consumption.valueHelpDefinition: { 
        entity: { name: 'I_CnsldtnRptgRuleVarVH', element: 'ConsolidationReportingRuleID' } 
    }
    @Consumption.derivation: { 
        lookupEntity: 'P_CNSLDTNRPTGRULEIDINDEX2',
        resultElement: 'ConsolidationReportingRuleID',
        binding: [
            { targetParameter: 'P_FiscalYear', type: #PARAMETER, value: 'P_FiscalYear' },
            { targetParameter: 'P_FiscalPeriod', type: #PARAMETER, value: 'P_FiscalPeriod' },
            { targetParameter: 'P_ConsolidationVersion', type: #PARAMETER, value: 'P_ConsolidationVersion' }]
    }
    P_ConsolidationRptgRuleID      : fincs_rptid,

    @Semantics.businessDate.at: true
    @Consumption.hidden: true  
    @Environment.systemField: #SYSTEM_DATE        
    @AnalyticsDetails.query.variableSequence : 55
    @Consumption.derivation: { 
        lookupEntity: 'I_FiscalCalendarDate',
        resultElement: 'FiscalPeriodEndDate',
        binding: [ 
            { targetElement: 'FiscalYear', type: #PARAMETER, value: 'P_FiscalYear' },
            { targetElement: 'FiscalPeriod', type: #PARAMETER, value: 'P_FiscalPeriod' },
            { targetElement: 'FiscalYearVariant', type: #PARAMETER, value: 'P_FiscalYearVariant' } ]
    }
    P_KeyDate                      : vdm_v_key_date

  as select from  ZI_MATRIX_RPT_RULE_CUBE_01(
                   P_FISCPER                   : $parameters.P_FISCPER,  
                   P_ConsolidationUnitHierarchy: $parameters.P_ConsolidationUnitHierarchy,
                   P_ConsolidationPrftCtrHier: $parameters.P_ConsolidationPrftCtrHier,
                   P_ConsolidationSegmentHier: $parameters.P_ConsolidationSegmentHier,
                   P_KeyDate: $parameters.P_KeyDate,
                   P_ConsolidationRptgItemHier: $parameters.P_ConsolidationRptgItemHier,
                   P_ConsolidationRptgRuleID: $parameters.P_ConsolidationRptgRuleID,
                   P_ChartOfAccount         : $parameters.P_ConsolidationChartOfAccounts ) as MatrixCnsldtnFndnEnhcdCube
{

  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: true}
  @AnalyticsDetails.query.variableSequence : 10
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY_TEXT
  @Consumption.derivation: { lookupEntity: 'I_CnsldtnGlobalParameter',
  resultElement: 'ConsolidationVersion'
  }
  ConsolidationVersion,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  ConsolidationVersionElement,

  @AnalyticsDetails.query.axis: #FREE
  FiscalYear,

  @AnalyticsDetails.query.axis: #FREE
  FiscalPeriod,

 // @Consumption.filter: {selectionType:#RANGE, multipleSelections: true, mandatory: true}
//  @AnalyticsDetails.query.variableSequence : 40
  @Consumption.derivation: { lookupEntity: 'I_FiscalCalendarDate',
                                resultElement: 'FiscalYearPeriod',
                                binding:      [
                                                { targetElement : 'FiscalYear'        , type : #PARAMETER ,  value : 'P_FiscalYear' },
                                                { targetElement : 'FiscalPeriod'      , type : #PARAMETER ,  value : 'P_FiscalPeriod' },
                                                { targetElement : 'FiscalYearVariant' , type : #PARAMETER,   value : 'P_FiscalYearVariant' }

                                                 ]
                               }
  FiscalYearPeriod,

  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: true}
  @AnalyticsDetails.query.variableSequence : 50
  @AnalyticsDetails.query.axis: #FREE
  @Consumption.filter.defaultValue: 'PER'
  PeriodMode,

 @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: true}
 @AnalyticsDetails.query.variableSequence : 60
 @AnalyticsDetails.query.axis: #FREE
 @Consumption.derivation: { lookupEntity: 'I_CnsldtnGlobalParameter',
  resultElement: 'ConsolidationGroup'
  }
  ConsolidationGroup,

//  @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 180
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  InvestmentActivityType,


  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  ConsolidationUnitForElim,

 // @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query: {
 // variableSequence : 71,
  axis: #FREE,
  display: #KEY
  }
  ConsolidationUnit,

  @Consumption.filter: {
  hierarchyBinding : [
  { type : #PARAMETER, value : 'P_ConsolidationChartOfAccounts'},
  { type : #PARAMETER, value : 'P_ConsolidationRptgItemHier'}],
  selectionType: #HIERARCHY_NODE,
  multipleSelections: false,
  mandatory: false
  }
  @AnalyticsDetails.query: {
  variableSequence : 110,
  axis: #ROWS,
  display: #KEY_TEXT,
  displayHierarchy: #FILTER,
  hierarchyInitialLevel: 3
  }
  ConsolidationReportingItem,

//  @Consumption.filter: {
//  selectionType: #RANGE,
//  multipleSelections: true,
//  mandatory: false
//  }
//  @AnalyticsDetails.query: {
//  variableSequence : 95,
//  axis: #ROWS,
//  display: #KEY_TEXT
//  }
  @AnalyticsDetails.query: {
  axis: #FREE,
  display: #KEY_TEXT
  } 
  FinancialStatementItem,

  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
 // @AnalyticsDetails.query.variableSequence : 120
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  SubItemCategory,

  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 130
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  SubItem,
  
 // @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 140
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  PartnerConsolidationUnit,

  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 150
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY_TEXT
  PostingLevel,

  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 160
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  CurrencyConversionsDiffType,

  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 170
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  ConsolidationDocumentType,
  
 // @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 170
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.display: #KEY
  InvesteeConsolidationUnit,

  @Semantics.businessDate.at: true
  PostingDate,

  @AnalyticsDetails.query.axis: #FREE
  InvestmentActivity,
  
  @AnalyticsDetails.query.axis: #FREE
  InvestorConsolidationUnit,

  @AnalyticsDetails.query.axis: #COLUMNS
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @AnalyticsDetails.query.hidden: false
  @EndUserText.label: 'Total Amount'
  TotalAmt,
 
  @AnalyticsDetails.query.axis: #COLUMNS
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @AnalyticsDetails.query.hidden: false
  @EndUserText.label: 'Preferred Share Amount'
  PrefShareAmt,

  @AnalyticsDetails.query.axis: #COLUMNS
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @AnalyticsDetails.query.hidden: false
  @EndUserText.label: 'Common Share Amount'
  CommonShareAmt,
  
  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 200
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #SHOW
  @Consumption.hidden: true
  TransactionCurrency,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #SHOW
  LocalCurrency,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #SHOW
  GroupCurrency,

  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 220
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #SHOW
  BaseUnit,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  ChartOfAccounts,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  GLAccount,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  AssignmentReference,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CostCenter,

  @AnalyticsDetails.query.axis: #FREE
  // @AnalyticsDetails.query.totals: #HIDE
  @AnalyticsDetails.query.variableSequence : 81
  //@Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  ProfitCenter,

  @AnalyticsDetails.query.axis: #FREE
  ConsolidationPrftCtrForElim,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  FunctionalArea,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  BusinessArea,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  ControllingArea,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.variableSequence : 91
 // @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
  Segment,

  @AnalyticsDetails.query.axis: #FREE
  ConsolidationSegmentForElim,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  PartnerCostCenter,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE

  PartnerProfitCenter,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  PartnerFunctionalArea,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  PartnerBusinessArea,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  PartnerCompany,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  PartnerSegment,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  OrderID,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  Customer,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  Supplier,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  Material,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  Plant,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  FinancialTransactionType,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  WBSElementExternalID,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  Project,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  BillingDocumentType,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  SalesOrganization,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  DistributionChannel,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  OrganizationDivision,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  MaterialGroup,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  SoldProduct,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  SoldProductGroup,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CustomerGroup,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CustomerSupplierCountry,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CustomerSupplierIndustry,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  SalesDistrict,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  BillToParty,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  ShipToParty,

 // @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 195
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CnsldtnAdhocItem,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CnsldtnAdhocSet,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CnsldtnAdhocSetItem,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  MatchingReasonCode,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  OriginType,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  OriginReference,

  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  GLRecordType,
  
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE  
  ConsolidationDocumentNumber,                  //Successor should be CnsldtnGroupJrnlEntry
  
  @AnalyticsDetails.query.axis: #FREE
  @AnalyticsDetails.query.totals: #HIDE
  CnsldtnGroupJrnlEntryBundle,  

  :P_ConsolidationChartOfAccounts as ConsolidationChartOfAccounts,
  :P_ConsolidationUnitHierarchy   as ConsolidationUnitHierarchy,
  :P_ConsolidationSegmentHier     as ConsolidationSegmentHierarchy,
  :P_ConsolidationPrftCtrHier     as ConsolidationPrftCtrHierarchy,
  :P_ConsolidationRptgRuleID      as ConsolidationReportingRuleID,
  :P_ConsolidationRptgItemHier    as ConsolidationReportingItemHier,
  :P_KeyDate                      as KeyDate

}
where
  GLRecordType <> 'R'
