@AbapCatalog.sqlViewName: 'ZVRPT70CONS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 70 Tax Sales Revenue MBYM Report'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
@ObjectModel.representativeKey: 'mainnode'
//@ObjectModel.usageType.serviceQuality: #A
//@ObjectModel.usageType.sizeCategory: #S
//@ObjectModel.usageType.dataClass: #CUSTOMIZING
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
define view ZC_RPT_70
  with parameters
    p_year : gjahr
  as select from ZI_RPT_70_1
                 (p_year: $parameters.p_year  )

{
@AnalyticsDetails.query.axis: #ROWS
CompanyCode,
Ledger,
CurrentYear,
Account,
AlternativeACC,
FiscalPeriod,
DocType,
ProfitCenter,
Segment,
CompanyCodeCurrency,
Region,
Title,
LongText,
@AnalyticsDetails.query.axis: #COLUMNS
period,
@AnalyticsDetails.query.axis: #COLUMNS
AmountinCC,
GLAccDesc



}
