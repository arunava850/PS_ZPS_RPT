@AbapCatalog.sqlViewName: 'ZCRPT59A'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'RPT0059 Consol TB_TRS trial balance'
@Analytics.query: true
@OData.publish: true
define view ZC_RPT_59
  with parameters

    @Consumption.derivation: { lookupEntity: 'I_CalendarDate',
        resultElement: 'FirstDayofMonthDate',
        binding: [
        { targetElement : 'CalendarDate' , type : #PARAMETER, value : 'P_ToPostingDate' } ]
       }
    P_FromPostingDate : fis_budat_from,
    @Consumption.derivation: { lookupEntity: 'I_MySessionContext',
        resultElement: 'UserLocalDate', binding: [
        { targetElement : 'UserID' , type : #SYSTEM_FIELD, value : '#USER' } ]
       }
    P_ToPostingDate   : fis_budat_to


  as select from ZI_RPT_59
                 ( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate ) as I_GLAcctBalanceCube

{
  @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: true}
  @Consumption.derivation: { lookupEntity: 'I_LedgerStdVH',
        resultElement: 'Ledger', binding: [
        { targetElement : 'IsLeadingLedger' , type : #CONSTANT, value : 'X' } ]
       }
  @AnalyticsDetails.query.variableSequence : 10
  @AnalyticsDetails.query.axis: #FREE
  Ledger,
  @AnalyticsDetails.query.axis: #ROWS
  CompanyCode,
  @AnalyticsDetails.query.axis: #ROWS
  _CompanyCode.CompanyCodeName,
  @AnalyticsDetails.query.axis: #ROWS
  GLAccount,
  @AnalyticsDetails.query.axis: #ROWS
  _GLAccountInChartOfAccounts._Text[1: Language = $session.system_language].GLAccountName,

  @EndUserText.label: 'Trading Partner'
  @AnalyticsDetails.query.axis: #ROWS
  PartnerCompany,

  ProfitCenter,
  CalendarYear,
  CalendarQuarter,
  CalendarMonth,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @AnalyticsDetails.query.axis: #COLUMNS
  AmountInCompanyCodeCurrency,


  CompanyCodeCurrency


}
