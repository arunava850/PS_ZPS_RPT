@AbapCatalog.sqlViewName: 'ZCRPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0095-Developed and Expanded Facilities'
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

define view ZC_RPT_0095 
with parameters
    
     p_mth: abap.char(2),
     p_qtr: abap.char(1),
     p_year: abap.char(4)
   
as select from ZI_4_RPT_95
               ( p_mth:$parameters.p_mth, p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)

{
 @Consumption.filter: {selectionType: #SINGLE, multipleSelections: false, mandatory: false}
 @Consumption.filter.defaultValue: '0L'
 @AnalyticsDetails.query.variableSequence : 30
 @AnalyticsDetails.query.axis: #ROWS
 @AnalyticsDetails.query.totals: #SHOW
 @AnalyticsDetails.query.display: #KEY_TEXT
 @EndUserText.label: 'Ledger'
 key Ledger,
 key CompanyCode,
 key FiscalYear,
 key SourceLedger,
 key AccountingDocument,
 key LedgerGLLineItem,

 Facilities,
 ProfitCenter,
 PostingDate,
 ZLYMTH,
 CCMONTH,
 CYQTR,
 LYQTR,
 GlobalCurrency,
 GroupAcc,
 GLAccount,
 @Semantics.amount.currencyCode: 'GlobalCurrency'
 FI_CURRENT_QTD,
 FI_LASTYR_QTD,
 FI_CURRENT_YTD, 
 FI_LASTYR_YTD,
 FI_LASTYR,
 FI_L2LASTYR
 
}
 