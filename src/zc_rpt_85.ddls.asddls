@AbapCatalog.sqlViewName: 'ZCRPT85'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0085 Sales_B&O Other Expense Report'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_85
  as select distinct from ZI_RPT_85
{
      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: true}
      @AnalyticsDetails.query.variableSequence : 20
  key CompanyCode,
      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 20
  key FiscalYear,
      ProfitCenter,
      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 50
      @EndUserText.label: 'Doc Type'
      @AnalyticsDetails.query.axis: #ROWS
      AccountingDocumentType,

      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 60
      Region,
      RegionName,
      @EndUserText.label: 'Entity Type'
      @AnalyticsDetails.query.axis: #ROWS
      Segment,

      CompanyCodeCurrency,

      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 40
      @EndUserText.label: 'Period'
      @AnalyticsDetails.query.axis: #ROWS
      FiscalPeriod,
      @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
      @AnalyticsDetails.query.variableSequence : 30
      @EndUserText.label: 'Account'
      @AnalyticsDetails.query.axis: #ROWS
      GLAccount,
      @EndUserText.label: 'Account Desc'
      @AnalyticsDetails.query.axis: #ROWS
      GLAccountLongName,


      @EndUserText.label: 'Amount'
      @AnalyticsDetails.query.axis: #COLUMNS

      AmountInCompanyCodeCurrency,
      ControllingArea,

      /* Associations */
      _AccountingDocumentTypeText,
      _AccountingDocumentType,
      _CompanyCode,
      _CompanyCodeCurrency,
      _CompanyCodeText,
      _FiscalYear,
      _GLAccountInCompanyCode,
      _GLAccountText,
      _ProfitCenter
}
