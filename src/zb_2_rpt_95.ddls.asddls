@AbapCatalog.sqlViewName: 'ZB2RPT95'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT95 Second Basic view'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZB_2_RPT_95
with parameters
     p_qtr: abap.char(1),
     p_year: abap.char(4)
     
 as select from ZB_RPT_95
                ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
 
{
    key Ledger,
    key CompanyCode,
    key FiscalYear,
    key SourceLedger,
    key AccountingDocument,
    key LedgerGLLineItem,
    LedgerFiscalYear,
    GroupAcc,
    GLAccount,
    ProfitCenter,
    FunctionalArea,
    BusinessArea,
    ControllingArea,
    PostingDate,
    GlobalCurrency,
    AmountInGlobalCurrency,
    FiscalPeriod,
    cast(CustomDt as abap.dats) as CustomDt
}
