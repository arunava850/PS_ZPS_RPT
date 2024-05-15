@AbapCatalog.sqlViewName: 'ZIVRPT70'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rpt70'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_70_1
  with parameters
 
    p_year : gjahr

  as select from ZTF_RPT_70( p_clnt:$session.client ,p_year: $parameters.p_year  )
 
{
CompanyCode,
Ledger,
Year as CurrentYear,
Account,
AlternativeACC,
FiscalPeriod,
DocType,
ProfitCenter,
Segment,
@Semantics.currencyCode:true
CompanyCodeCurrency,
Region,
Title,
LongText,
period,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
AmountinCC,
GLAccDesc

}
