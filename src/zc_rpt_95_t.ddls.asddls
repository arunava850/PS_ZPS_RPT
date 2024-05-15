@AbapCatalog.sqlViewName: 'ZCRPT95T'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R95 - Consumption View'
@Analytics.query: true
@VDM.viewType: #CONSUMPTION
//@Analytics.dataCategory: #CUBE
//@VDM.viewType: #COMPOSITE

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

define view ZC_RPT_95_T
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)

 as select from ZI_4_RPT_95_T
                ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
 
{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    LedgerFiscalYear,
    Facilities,
    @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
    @AnalyticsDetails.query.variableSequence : 30
    @AnalyticsDetails.query.axis: #ROWS
    @AnalyticsDetails.query.totals: #SHOW
    @AnalyticsDetails.query.display: #KEY_TEXT
    @EndUserText.label: 'G/L Account Range'
    GLAccount,
    ProfitCenter,
    FunctionalArea,
    BusinessArea,
    ControllingArea,
    PostingDate,
    GlobalCurrency,
    FiscalPeriod,
    ZQUARTER,
    ZMONTH,
    ZMONTH1,
    ZYEAR,
    ZLYEAR,
    ZL2LYEAR,
    ZLYMTH,
    ZL2LYMTH,
    ZLQUARTER,
    ZL2LYQTR,
    CQtr,
    CYEAR,
    CCMONTH,
    LYEAR,
    L2LYEAR,
    CYQTR,
    LYQTR,
    //AmountInGlobalCurrency,
    @Semantics.amount.currencyCode: 'GlobalCurrency'
    FI_CURRENT_QTD,
    FI_LASTYR_QTD,
    FI_CURRENT_YTD,
    FI_LASTYR_YTD,
    FI_LASTYR,
    FI_L2LASTYR
}
