@AbapCatalog.sqlViewName: 'ZCRPT0018'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0018 - Consumption View (Market Rev )'
@Analytics.query: true
@VDM.viewType: #CONSUMPTION

define view ZC_RPT_0018 
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)
    
 as select from ZI_RPT_0018 
               ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
               
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
   Facilities,
   NodeValue,
   Storage,
   Location,
   @Consumption.filter: {selectionType: #RANGE, multipleSelections: true, mandatory: false}
   @AnalyticsDetails.query.variableSequence : 30
   @AnalyticsDetails.query.axis: #ROWS
   @AnalyticsDetails.query.totals: #SHOW
   @AnalyticsDetails.query.display: #KEY_TEXT
   @EndUserText.label: 'G/L Account Range'
   GLAccount,
   GroupAcc,
   GlobalCurrency,
   //LastYearDate,
   ZYEAR,
   ZMONTH,
   LYQTR,
   CYEAR,
   CYQTR,
   CQtr,
   CCMONTH,
   LYEAR,
   LYMTH,
   L2LYEAR,
   L2LYMTH,
   L2LYQTR,
   
   
// Measures   
   REV_CYMTH,
   REV_LYMTH,
   REV_L2LYMTH,
   REV_LY,
   REV_L2LY,
   REV_CYQTD,
   REV_LYQTD,
   REV_L2LYQTD,
   REV_CYYTD,
   REV_LYYTD,
   REV_L2LYYTD,
   REV_CYQ1,
   REV_CYQ2,
   REV_CYQ3,
   REV_CYQ4,
   REV_LYQ1,
   REV_LYQ2,
   REV_LYQ3,
   REV_LYQ4,
   REV_L2LYQ1,
   REV_L2LYQ2,
   REV_L2LYQ3,
   REV_L2LYQ4,
   REV_CYM1,
   REV_CYM2,
   REV_CYM3,
   REV_CYM4,
   REV_CYM5,
   REV_CYM6,
   REV_CYM7,
   REV_CYM8,
   REV_CYM9,
   REV_CYM10,
   REV_CYM11,
   REV_CYM12,
   REV_LYM1,
   REV_LYM2,
   REV_LYM3,
   REV_LYM4,
   REV_LYM5,
   REV_LYM6,
   REV_LYM7,
   REV_LYM8,
   REV_LYM9,
   REV_LYM10,
   REV_LYM11,
   REV_LYM12,
   REV_L2LYM1,
   REV_L2LYM2,
   REV_L2LYM3,
   REV_L2LYM4,
   REV_L2LYM5,
   REV_L2LYM6,
   REV_L2LYM7,
   REV_L2LYM8,
   REV_L2LYM9,
   REV_L2LYM10,
   REV_L2LYM11,
   REV_L2LYM12 
}
