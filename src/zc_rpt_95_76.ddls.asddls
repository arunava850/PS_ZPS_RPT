@AbapCatalog.sqlViewName: 'ZCRPT9576'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0095/76 -Consumption View(Statisticals)'
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
                             
define view ZC_RPT_95_76
 with parameters
 
    p_qtr           : abap.char(1),
    p_year          : abap.char(4) 
    
 as select from ZI_6_RPT_STAT
               ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
{

key Facilities,
key HierarchyId,
key HierarchyParentNode,
key CompanyCode,
key ProfitCenter,
StatGLAcc,
StatKF,
StatUnit,
CQuarter,
CYEAR,
NumOfFac,
NetRentSqFt,
CstDevlop,
SqFt_910200,
SqFt_910210,
SqFt_910120,
SKF_910200_LYQTD,
SKF_910210_LYQTD,
SKF_910120_LYQTD,
SKF_910200_LYYTD,
SKF_910210_LYYTD,
SKF_910120_LYYTD,
SKF_910230_LYYTD,
SKF_910220_LYYTD,
SKF_910300_LYYTD,
SKF_910200_CYQTD,
SKF_910210_CYQTD,
SKF_910120_CYQTD,
SKF_910200_CYYTD,
SKF_910210_CYYTD,
SKF_910120_CYYTD,
SKF_910230_CYYTD,
SKF_910220_CYYTD,
SKF_910300_CYYTD,
PSAIC_930710_CYQTD,
PSAIC_930710_LYQTD,
PSAIC_930710_CYYTD,
PSAIC_930710_LYYTD,
SKF_910200_LY,
SKF_910210_LY,
SKF_910120_LY,
SKF_910230_LY,
SKF_910220_LY,
SKF_910300_LY,
SKF_910200_L2LY,
SKF_910210_L2LY,
SKF_910120_L2LY,
SKF_910230_L2LY,
SKF_910220_L2LY,
SKF_910300_L2LY
}
