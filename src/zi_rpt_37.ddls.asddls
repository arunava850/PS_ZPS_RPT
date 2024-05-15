@AbapCatalog.sqlViewName: 'ZIRTP37'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rpt37'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_37
  with parameters
    //    p_qtr  : abap.char(2),
    p_year : gjahr

  as select from ZTF_RPT_37( p_clnt:$session.client , p_year: $parameters.p_year  )
{
  racct,
  rldnr,
  anbwa,
  rbukrs,
  prctr,
  location,
  PostingDate,
  GLAccDesc,
  @Semantics.currencyCode:true
  cast( 'USD' as abap.cuky )               as CurrencyinCC,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  hsl,
//    @DefaultAggregation: #SUM
//    @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
//  NoofFacilities,
//  @DefaultAggregation: #SUM
//  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
//  NetRentableSquareFoot,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  CurrentYearEncumbrances,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  ICLand,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  ICBuildingsandImprovement,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Acquisitionduringtheyear,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  GCAmountLand,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  GCAmtBuildingsandImprov,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  (GCAmountLand + GCAmtBuildingsandImprov) as GCTOTAL,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  AccumulatedDepreciation

}
