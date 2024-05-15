@AbapCatalog.sqlViewName: 'ZI2RPTSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stat Reports (Time Chars)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_RPT_STAT with parameters

    p_qtr           : abap.char(1),
    p_year          : abap.char(4)

 as select from ZI_RPT_STAT
               ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
{
    key HierarchyId,
    key HierarchyParentNode,
    key CompanyCode,
    key ProfitCenter,
    Counter,
    StatGLAcc,
    StatKF,
    StatUnit,
    StatYear,    
    CQuarter,
    CYDate,
    PostingDate,
    Facilities,
    Location,
    cast(CustomDt as abap.dats) as CustomDt,   

// Measures
    
    NumOfFac,
    NetRentSqFt,
    CstDevlop,
    SqFt_910200,
    SqFt_910210,
    SqFt_910120,
    SqFt_910230,
    SqFt_910220,
    SqFt_910300,
    PSAIC_930710
}
