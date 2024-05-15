@AbapCatalog.sqlViewName: 'ZCVRPT019'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0019 SameStore 5Quarter'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
@ObjectModel.representativeKey: 'mainnode'

@AbapCatalog: {
                buffering.status: #NOT_ALLOWED }

@Analytics.settings.maxProcessingEffort: #HIGH
@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata: { ignorePropagatedAnnotations: true,
             allowExtensions: true }
@ObjectModel: { supportedCapabilities: [ #ANALYTICAL_QUERY ],
                modelingPattern: #ANALYTICAL_QUERY,
                usageType: { sizeCategory: #XXL,
                             serviceQuality: #D,
                             dataClass: #MIXED } }
define view ZC_RPT_019_SS5QTR
  with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
  as select from ZI_RPT_019_SS5QTR_2
                 ( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )

{
  key counter,
  key mainnode,
  key subnode,
  key Ledger,
      @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 30
      @Consumption.filter.defaultValue: '1000'
  key
      CompanyCode,
      @AnalyticsDetails.query.axis: #COLUMNS
      @AnalyticsDetails.query.sortDirection: #DESC
  key FiscalYear,
  key SourceLedger,
  key AccountingDocument,
  key LedgerGLLineItem,
  key GLAccountFlowType,
      GLAccountGroup,
      @EndUserText.label: 'G/L Account'
      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 40
      GLAccount,
      GLAccountHierarchy,
      ProfitCenter,
      FiscalYearVariant,
      FiscalYearPeriod,
      PostingDate,
      GLAccountType,
      ChartOfAccounts,
      Plant,
      Supplier,
      Customer,
      Material,
      FinancialAccountType,
      CompanyCodeCurrency,
      AmountInCompanyCodeCurrency,
      FiscalPeriod,
      @AnalyticsDetails.query.axis: #COLUMNS
      @AnalyticsDetails.query.sortDirection: #DESC
      CQtrPostingDt,
      CMonPostingDt,
      CYrPostingDt,
      CMonDescPostingDt,
      @AnalyticsDetails.query.totals: #SHOW
      @AnalyticsDetails.query.axis: #ROWS
      MainNodeTxt,
      @AnalyticsDetails.query.axis: #ROWS
      @AnalyticsDetails.query.totals: #SHOW
      SubNodeTxt,
      _SText,
      _MText


}
