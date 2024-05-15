@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.sqlViewName: 'ZIRPT2'
@EndUserText.label: 'RPT002 - Tenant Ins. Collection'
@Analytics: { dataCategory: #CUBE } //, dataExtraction.enabled: true }
@VDM.viewType: #COMPOSITE
//@ObjectModel.representativeKey: 'FiscalPeriodDate'
@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.dbHints: [
                       {dbSystem: #HDB, hint: 'AGGR_TARGET("ACDOCA")'} ]
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #NOT_ALLOWED
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED
@AccessControl.personalData.blocking:#REQUIRED


define view ZI_RPT_2

  as select distinct from ZTF_RPT_2( p_clnt: $session.client )

{

  Region,
  RegionName,
  ProfitCenter,
  FiscalYear,
  FiscalPeriod,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Collection1,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  Refund,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CurrencyInCC'} }
  NetRemittance,
  @Semantics.currencyCode:true
  CurrencyinCC
}
