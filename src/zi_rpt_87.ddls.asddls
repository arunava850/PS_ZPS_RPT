@AbapCatalog.sqlViewName: 'ZIVRPT87'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0087 Interface View Tax Sales Collection'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_87
  with parameters
 
    p_year : gjahr

  as select from ZTF_RPT_87( p_clnt:$session.client ,p_year: $parameters.p_year  )
 
{
client,
Report,
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
union

select from t247 as _M 

{
$session.client as Client,
'' as Report,
'' as CompanyCode,
'' as Ledger,
cast( '0000' as abap.numc( 4 )) as CurrentYear,
'' as Account,
'' as AlternativeACC,
cast( '0000000' as abap.numc( 7 )) as FiscalPeriod,
'' as DocType,
'' as ProfitCenter,
'' as Segment,
@Semantics.currencyCode:true
cast( 'USD' as abap.cuky ) as CompanyCodeCurrency,
'' as Region,
'' as Title,
'' as LongText,
concat( CONCAT( _M.mnr ,_M.ktx) , concat( '-', ( $parameters.p_year)) ) as Period,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
0 as AmountinCC,
'' as GLAccDesc




} 

where 
 _M.spras = 'E'
