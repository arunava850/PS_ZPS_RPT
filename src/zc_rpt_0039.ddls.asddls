@AbapCatalog.sqlViewName: 'ZCRPT0039'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0039 Same Store Facilities by Market'
@Analytics.query: true
@VDM.viewType: #CONSUMPTION
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
define view ZC_RPT_0039 
with parameters

     p_mth: abap.char(2),
     p_qtr: abap.char(1),
     p_year: abap.char(4)    
   
as select from ZI_3_RPT_0039 (p_mth:$parameters.p_mth, p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)

{   
@Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: false}
@Consumption.filter.defaultValue: '0L'
@AnalyticsDetails.query.variableSequence : 30
@AnalyticsDetails.query.axis: #ROWS
@AnalyticsDetails.query.totals: #SHOW
@AnalyticsDetails.query.display: #KEY_TEXT
@EndUserText.label: 'Ledger'
key Ledger,
@Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
@AnalyticsDetails.query.variableSequence : 30
@AnalyticsDetails.query.axis: #ROWS
@AnalyticsDetails.query.totals: #SHOW
@AnalyticsDetails.query.display: #KEY_TEXT
@EndUserText.label: 'Company Code'
key CompanyCode,
key FiscalYear,
key SourceLedger,
key AccountingDocument,
key LedgerGLLineItem,
@Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
@AnalyticsDetails.query.variableSequence : 30
@AnalyticsDetails.query.axis: #ROWS
@AnalyticsDetails.query.totals: #SHOW
@AnalyticsDetails.query.display: #KEY_TEXT
@EndUserText.label: 'Profit Center'
ProfitCenter,
Facilities,
@Consumption.filter: {selectionType: #SINGLE, multipleSelections: true, mandatory: false}
@AnalyticsDetails.query.variableSequence : 30
@AnalyticsDetails.query.axis: #ROWS
@AnalyticsDetails.query.totals: #SHOW
@AnalyticsDetails.query.display: #KEY_TEXT
@EndUserText.label: 'Segment'
Storage,
Market,
PostingDate,
CCMONTH,
CYEAR,
CYQTR,
LYQTR,
LYEAR,
CQtr,
GroupAcc,
GLAccount,
GlobalCurrency,
@Semantics.amount.currencyCode: 'GlobalCurrency'
Revenue,
DirExp,
IndirExp,
REV_CYQTD,
REV_LYQTD,
REV_CYYTD,
REV_LYYTD,
REV_LY,
REV_L2LY,
DIR_CYQTD,
DIR_LYQTD,
DIR_CYYTD,
DIR_LYYTD,
DIR_LY,
DIR_L2LY,
IND_CYQTD,
IND_LYQTD,
IND_CYYTD,
IND_LYYTD,
IND_LY,
IND_L2LY
}                            
