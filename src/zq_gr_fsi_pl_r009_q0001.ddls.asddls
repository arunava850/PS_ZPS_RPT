@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
// SQL View Name
@AbapCatalog.sqlViewName: 'ZQGRCPLR09_Q1'
// Query Name
@EndUserText.label: 'RPT0009 - Consolidated P&L'

// Analytics Query
@VDM.viewType: #CONSUMPTION
@Analytics.query: true

// Perform Auth Check
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY

// Other Parameters
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #NOT_ALLOWED
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED
@Analytics.settings.maxProcessingEffort: #HIGH

// Publish OData
@OData.publish: true

define view ZQ_GR_FSI_PL_R009_Q0001
  with parameters

    // Language - Hidden Variable
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_LANGUAGE
    P_Language : sylangu,

    // Chart of Accounts - Hidden Variable
    @EndUserText.label: 'Consolidation Chart of Accounts'
    @AnalyticsDetails.query.variableSequence : 30
    @Consumption.defaultValue: 'PS'
    P_COA      : fincs_itclg,

    //  FS Item prompt
    @AnalyticsDetails.query.variableSequence : 60
    // @Consumption.defaultValue: '$'
    @Consumption.valueHelpDefinition: {
      entity: { name:    'I_FinStmntItmHierDir',
                element: 'FinancialStatementItemHier' }
    }
    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
    @EndUserText.label: 'FS Item Hierarchy'
    P_HIER     : fincs_ithry,

    // Financial Period prompt
    @AnalyticsDetails.query.variableSequence : 10
    //  @Consumption.defaultValue: '$'
    @Consumption.valueHelpDefinition: {
      entity: { name:    'ZFI_TIME_PERIODS',
                element: 'FiscalYearPeriod' }
    }
    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
    @EndUserText.label: 'Fiscal Period'
    P_FISCPER  : fis_jahrper_conv,

    // Report Run Mode
    @AnalyticsDetails.query.variableSequence : 50
    @Consumption.defaultValue: 'MTD'
    @Consumption.valueHelpDefinition: {
      entity: { name:    'ZI_GR_RPTMODE_LOV',
                element: 'RptMode' }
    }
    @EndUserText.label: 'Period Mode'
    P_MODE     : abap.char(3)

  as select from ZC_GR_ITM_FSI_CUBE
                 ( P_FISCPER: $parameters.P_FISCPER,
                   P_MODE:    $parameters.P_MODE,
                   P_HIER:    $parameters.P_HIER )

  //  association [1..1] to I_FinStmntItmHierDir  as _FinStmntItmHierDir  on  _FinStmntItmHierDir.ConsolidationChartOfAccounts = $parameters.P_COA and
  //                                                                          _FinStmntItmHierDir.FinancialStatementItemHier   = $parameters.P_HIER

{
      @EndUserText.label: 'FS Item Hierarchy'
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY_TEXT
  key FsItemHierarchy,

      @EndUserText.label: 'Cons. Ledger'
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY
      @AnalyticsDetails.query.resultValuesSource: #DIMENSION
      //    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
      @AnalyticsDetails.query.variableSequence : 2
  key ConsolidationLedger,

      _Ledger._Text[1: Language = $parameters.P_Language].ConsolidationLedgerName                as ConsolidationLedgerName,
      _Dimension._Text[1: Language = $parameters.P_Language].ConsolidationDimensionMdmText       as ConsolidationDimenName,

      @EndUserText.label: 'Cons. Version'
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY
      @AnalyticsDetails.query.resultValuesSource: #DIMENSION
      @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: true}
      @AnalyticsDetails.query.variableSequence : 20
      ConsolidationVersion,
      _Version._Text[1: Language = $parameters.P_Language].ConsolidationVersionText              as ConsolidationVersionName,

      @EndUserText.label: 'Fiscal Year Variant'
      @Semantics.fiscal.yearVariant: true
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY
      FiscalYearVariant,

      @EndUserText.label: 'Consolidation Unit'
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY_TEXT
      //    @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 5
      ConsolidationUnit,
      _CnsldtnUnit._Text[1: Language = $parameters.P_Language].ConsolidationUnitMdmText          as ConsolidationUnitName,


      @EndUserText.label: 'Cons. Chart Of Accts'
      //    @AnalyticsDetails.query.variableSequence : 60
      @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: true}
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY_TEXT
      ConsolidationChartOfAccounts,
      _ChartOfAccounts._Text[1: Language = $parameters.P_Language].ConsolidationChartOfAcctsText as ConsolidationChartOfAcctsName,

      @EndUserText.label: 'FS Item'
      @AnalyticsDetails.query.totals: #HIDE
      @AnalyticsDetails.resultValuesSource: #DIMENSION
      @Consumption.filter: {
      hierarchyBinding : [
                        { type : #PARAMETER, value : 'P_COA'},
                        { type : #PARAMETER, value : 'P_HIER'}],
      selectionType: #HIERARCHY_NODE,
      multipleSelections: true,
      mandatory:          false
      }
      @AnalyticsDetails.query: {
      variableSequence :  70,
      axis:               #ROWS,
      display:            #KEY_TEXT,
      displayHierarchy:   #FILTER,
      hierarchyInitialLevel: 2
      }
      FinancialStatementItem,

      @EndUserText.label: 'Cons. Group'
      @AnalyticsDetails.query.variableSequence : 40
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY_TEXT
      @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: true}
      ConsolidationGroup,
      _CnsldtnGroup._Text[1: Language = $parameters.P_Language].ConsolidationGroupMediumText     as ConsolidationGroupName,

      @EndUserText.label: 'Company Code'
      @AnalyticsDetails.query.axis: #FREE
      @AnalyticsDetails.query.display: #KEY_TEXT
      //      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 6
      CompanyCode,
      _CompanyCode.CompanyCodeName,

      @EndUserText.label: 'Report Run Mode'
      report_mode,

      @EndUserText.label: 'Group Currency'
      @Semantics.currencyCode:true
      GroupCurrency,

      @AnalyticsDetails.query.axis: #COLUMNS
      @Consumption.hidden: false
      @EndUserText.label: 'CY QTD Amount in Group Currency'
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode:'GroupCurrency'
      CY_QTD_AmountInGC,

      @AnalyticsDetails.query.axis: #COLUMNS
      @Consumption.hidden: false
      @EndUserText.label: 'PY QTD Amount in Group Currency'
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode:'GroupCurrency'
      PY_QTD_AmountInGC,

      @AnalyticsDetails.query.axis: #COLUMNS
      @Consumption.hidden: false
      @EndUserText.label: 'CY YTD Amount in Group Currency'
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode:'GroupCurrency'
      CY_YTD_AmountInGC,

      @AnalyticsDetails.query.axis: #COLUMNS
      @Consumption.hidden: false
      @EndUserText.label: 'PY YTD Amount in Group Currency'
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode:'GroupCurrency'
      PY_YTD_AmountInGC,

      @AnalyticsDetails.query.axis: #COLUMNS
      @Consumption.hidden: false
      @EndUserText.label: 'PY2 YTD Amount in Group Currency'
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode:'GroupCurrency'
      PY2YTD_AmountInGC
}
where
      ConsolidationChartOfAccounts =  :P_COA
  and FiscalYearVariant            =  'K4'
  and GLRecordType                 <> 'R'
