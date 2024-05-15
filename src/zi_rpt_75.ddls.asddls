@AbapCatalog.sqlViewName: 'ZIRPT75'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0075 P&L by Third Party Property'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_75
  with parameters
    p_ledg  : fins_ledger,
    p_bukrs : bukrs,
    p_year  : gjahr
  as select from I_GLAccountLineItem as _gl
{

  _gl.CompanyCode,
  _gl.PostingDate,
  _gl.DocumentDate,
  _gl.AccountingDocument,
  _gl.AccountingDocumentType,
  _gl.Supplier,
  _gl._Supplier.SupplierFullName,
  _gl.ProfitCenter,
  _gl.CostCenter,
  _gl.GLAccount,
  _GLAccountInChartOfAccounts._Text[1: Language = $session.system_language].GLAccountName,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.AmountInCompanyCodeCurrency,
  @Semantics.currencyCode:true
  _gl.CompanyCodeCurrency,
  case _gl.CalendarMonth
  when '01'  then '01Jan'
  when '02'  then '02Feb'
  when '03'  then '03Mar'
  when '04'  then '04Apr'
  when '05'  then '05May'
  when '06'  then '06Jun'
  when '07'  then '07Jul'
  when '08'  then '08Aug'
  when '09'  then '09Sep'
  when '10'  then '10Oct'
  when '11'  then '11Nov'
  when '12'  then '12Dec'
  end as CalMonth,
  _gl.AccountingDocCreatedByUser
  //  ControllingArea,
  //  _ProfitCenter
}
where
      _gl.Ledger       =  :p_ledg
  and _gl.CompanyCode  =  :p_bukrs
  and _gl.FiscalYear   =  :p_year
  and _gl.FiscalPeriod <> '000';
