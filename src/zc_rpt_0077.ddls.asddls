@AbapCatalog.sqlViewName: 'ZCRPT0077'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT77-Consumption View(Tenant Operations)'
@Analytics.query: true
@VDM.viewType: #CONSUMPTION

define view ZC_RPT_0077 
with parameters
    
    p_qtr: abap.char(1),
    p_year: abap.char(4)    
   
as select from ZI_3_RPT_77 ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)

{ 
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
  key FiscalYear,
  key SourceLedger,
  key AccountingDocument,
  key LedgerGLLineItem,
  Facilities,
  LedgerFiscalYear,
  GroupAcc,
  GLAccount,
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
  @AnalyticsDetails.query.variableSequence : 30
  @AnalyticsDetails.query.axis: #ROWS
  @AnalyticsDetails.query.totals: #SHOW
  @AnalyticsDetails.query.display: #KEY_TEXT
  @EndUserText.label: 'Profit Center'
  ProfitCenter,
  FunctionalArea,
  BusinessArea,
  ControllingArea,
  PostingDate,
  GlobalCurrency,
  FiscalPeriod,
  ZQUARTER,
  ZMONTH,
  ZMONTH1,
  ZYEAR,
  ZLYEAR,
  ZL2LYEAR,
  ZLYMTH,
  ZL2LYMTH,
  ZLQUARTER,
  ZL2LYQTR,
  CQtr,
  CYEAR,
  CCMONTH,
  LYEAR,
  L2LYEAR,
  CYQTR,
  LYQTR,
  AmountInGlobalCurrency,
  CYQTD,
  LYQTD,
  CYYTD,
  LYYTD,
  LossesPaid_CYQTD,
  LossesPaid_LYQTD,
  LossesPaid_CYYTD,
  LossesPaid_LYYTD,
  Claims_CYQTD,
  Claims_LYQTD,
  Claims_CYYTD,
  Claims_LYYTD,
  ReservesAccrued_CYQTD,
  ReservesAccrued_LYQTD,
  ReservesAccrued_CYYTD,
  ReservesAccrued_LYYTD,
  ReservesNonCore_CYQTD,
  ReservesNonCore_LYQTD,
  ReservesNonCore_CYYTD,
  ReservesNonCore_LYYTD,
  Underwriting_CYQTD,
  Underwriting_LYQTD,
  Underwriting_CYYTD,
  Underwriting_LYYTD,
  Payroll_CYQTD,
  Payroll_LYQTD,
  Payroll_CYYTD,
  Payroll_LYYTD,
  ThirdParty_CYQTD,
  ThirdParty_LYQTD,
  ThirdParty_CYYTD,
  ThirdParty_LYYTD,
  CreditCard_CYQTD,
  CreditCard_LYQTD,
  CreditCard_CYYTD,
  CreditCard_LYYTD
}
