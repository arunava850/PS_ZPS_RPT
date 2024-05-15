@AbapCatalog.sqlViewName: 'ZI5RPTSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stat Reports (Time Chars)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_5_RPT_STAT with parameters

    p_qtr           : abap.char(1),
    p_year          : abap.char(4)

 as select from ZI_4_RPT_STAT
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
//   CustomDt,
//   ZQUARTER,
//   ZMONTH,
//   ZMONTH1,
//   ZYEAR,
//   ZLYEAR,
//   ZL2LYEAR,
//   ZLYMTH,
//   ZL2LYMTH,
//   ZLQUARTER,
//   ZL2LYQTR,
//   CQtr,
     CYEAR,
//   CCMONTH,
     LYEAR,
     L2LYEAR,
   
    case when CYQTR = '01' then '1'
         when CYQTR = '02' then '1'
         when CYQTR = '03' then '1'
         when CYQTR = '04' then '2'
         when CYQTR = '05' then '2'
         when CYQTR = '06' then '2'
         when CYQTR = '07' then '3'
         when CYQTR = '08' then '3'
         when CYQTR = '09' then '3'
         when CYQTR = '10' then '4'
         when CYQTR = '11' then '4'
         when CYQTR = '12' then '4' end as CYQTR,
      
    case when LYQTR = '01' then '1'
         when LYQTR = '02' then '1'
         when LYQTR = '03' then '1'
         when LYQTR = '04' then '2'
         when LYQTR = '05' then '2'
         when LYQTR = '06' then '2'
         when LYQTR = '07' then '3'
         when LYQTR = '08' then '3'
         when LYQTR = '09' then '3'
         when LYQTR = '10' then '4'
         when LYQTR = '11' then '4'
         when LYQTR = '12' then '4' end as LYQTR,
   
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
  where StatYear <= $parameters.p_year
