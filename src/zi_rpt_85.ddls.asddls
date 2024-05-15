@AbapCatalog.sqlViewName: 'ZIRPT85'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0085 Sales_B&O Other Expense Report'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_85
  as select distinct from I_GLAccountLineItem

{

  key CompanyCode,
  key FiscalYear,
  key AccountingDocument,
  key LedgerGLLineItem,
      GLAccount,

      ProfitCenter,

      @Semantics.currencyCode:true
      CompanyCodeCurrency,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
      AmountInCompanyCodeCurrency,
      ControllingArea,
      FiscalPeriod,
      AccountingDocumentType,
      _ProfitCenter.Region,
      _ProfitCenter._Region._RegionText[1: Language = $session.system_language].RegionName,
      _ProfitCenter.Segment,
      _GLAcctInChartOfAccountsText[1: Language = $session.system_language].GLAccountLongName,


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
where
  Ledger = '0L'
