@AbapCatalog.sqlViewName: 'ZCRPT0038'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0038 -Consumption View'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
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
                             
define view ZC_RPT_0038
with parameters

     p_qtr: abap.char(1),
     p_year: abap.char(4)  
    
 as select from ZI_2_RPT_0038
               (  p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
 
{
key HierarchyId,
key Facilities,
@Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
@AnalyticsDetails.query.variableSequence : 30
@AnalyticsDetails.query.axis: #ROWS
@AnalyticsDetails.query.totals: #SHOW
@AnalyticsDetails.query.display: #KEY_TEXT
@EndUserText.label: 'Company Code'
key CompanyCode,
key ProfitCenter,
Location,
StatGLAcc,
StatKF,
StatUnit,
CYEAR,
CQuarter,
CYDate,

@EndUserText.label: 'No. of Expanded & Other NSS Faciltiies'
SKF_910210_CYYTD,
@EndUserText.label: 'No.of Facilities(SS,Developed,Acquired)'
SKF_910220_CYYTD,
@EndUserText.label: 'No. of Storage Facilities'
SKF_910230_CYYTD
}
