@AbapCatalog.sqlViewName: 'ZVRPT97NEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 97 New'
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
define view ZC_RPT_97
  with parameters
    p_qtr  : abap.char(2),
    p_year : gjahr
  as select from ZI_RPT_97_4
                 (p_qtr: $parameters.p_qtr , p_year: $parameters.p_year)
{

Mainnode,
@AnalyticsDetails.query.axis: #COLUMNS
Subnode,
Ledger,
CompanyCode,
GlAccount,
GlAccountGroup,
ProfitCenter,
postingdate,
Segment,

Location,
@EndUserText.label: 'Market'
@AnalyticsDetails.query.axis: #ROWS
district,
GLAccDesc,

//@EndUserText.label: 'No. of Facilities'
//NoOfFacility,
//@EndUserText.label: 'Facilities Current Year Quarter'
//CQtrF,
//@EndUserText.label: 'Facilities Previous Year Quarter'
//CQtrPYF,
//
//@EndUserText.label: 'Facilities Current Year'
//CYF,
//@EndUserText.label: 'Facilities Previous Year'
//PYF,
//
//@EndUserText.label: 'Facilities Prev To Prev Year Full'
//PY2F,
//@EndUserText.label: 'Facilities Previous Year Full'
//PY1F,

CurrencyinCC,
AmountinCC,

@EndUserText.label: 'Current Year Quarter'
CQtr,
@EndUserText.label: 'Previous Year Quarter'
CQtrPY,

@EndUserText.label: 'Current Year'
CY,
@EndUserText.label: 'Previous Year'
PY,

@EndUserText.label: 'Previous To Previous Year Full'
PY2,
@EndUserText.label: 'Previous Year Full'
PY1


    
}
