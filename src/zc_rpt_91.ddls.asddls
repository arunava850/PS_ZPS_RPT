@AbapCatalog.sqlViewName: 'ZVRPT91NEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 91 EzStorage New'
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
define view ZC_RPT_91
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  as select from ZI_RPT_91_3
                 (p_qtr: $parameters.p_qtr , p_year: $parameters.p_year  )

{

key Mainnode,
@AnalyticsDetails.query.axis: #COLUMNS
key Subnode,
key Ledger,
key CompanyCode,
key GlAccount,
key GlAccountGroup,
key ProfitCenter,
postingdate,
Segment,
fiscalperiod,
GLAccDesc,
CurrencyinCC,
AmountinCC,
@AnalyticsDetails.query.axis: #ROWS
PRCTRDESC,
@EndUserText.label: 'Current Year Quarter'
CQtr,
//@EndUserText.label: 'Previous Year Quarter'
//CQtrPY,
//@EndUserText.label: 'Quarter Change'
//CQTRCHANGE,
@EndUserText.label: 'Current Year'
CY
//@EndUserText.label: 'Previous Year'
//PY,
//@EndUserText.label: 'Year Change'
//PYCHANGE,
//@EndUserText.label: 'Previous To Previous Year Full'
//PY2,
//@EndUserText.label: 'Previous Year Full'
//PY1,
//@EndUserText.label: 'Previous Year Change'
//PY2CHANGE


}
