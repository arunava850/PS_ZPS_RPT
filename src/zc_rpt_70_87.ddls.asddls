@AbapCatalog.sqlViewName: 'ZVRPT7087'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tax Sales Revenue and Collection Mbym Report'

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
define view ZC_RPT_70_87
  with parameters
    p_year : gjahr,
    P_RPT : abap.char(10)
    
  as select from ZI_RPT_87
                 (p_year: $parameters.p_year)

{
key Report,
@AnalyticsDetails.query.axis: #ROWS
key CompanyCode,
key Ledger,
key CurrentYear,
key Account,
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


} where Report = :P_RPT
