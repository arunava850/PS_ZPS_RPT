@AbapCatalog.sqlViewName: 'ZI4RPTSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stat Reports (Time Chars)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_4_RPT_STAT with parameters

    p_qtr           : abap.char(1),
    p_year          : abap.char(4)

 as select from ZI_3_RPT_STAT
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
   
   case when ZMONTH = '01' then '1'
         when ZMONTH = '02' then '1'
         when ZMONTH = '03' then '1'
         when ZMONTH = '04' then '2'
         when ZMONTH = '05' then '2'
         when ZMONTH = '06' then '2'
         when ZMONTH = '07' then '3'
         when ZMONTH = '08' then '3'
         when ZMONTH = '09' then '3'
         when ZMONTH = '10' then '4'
         when ZMONTH = '11' then '4'
         when ZMONTH = '12' then '4' end as CQtr, 
    
    case when ZLYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,5,2)                   end as LYQTR,
    
    case when ZYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                   end as CYEAR,
        
    case when ZYEAR = substring(PostingDate,1,4)  
              then substring(PostingDate,5,2)                   end as CYQTR,
                  
    case when ZYEAR = substring(PostingDate,1,4)
              then substring(PostingDate,5,2)                   end as CCMONTH,
    
    case when ZLYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                   end as LYEAR,
    
    case when ZL2LYEAR = substring(PostingDate,1,4) 
              then substring(PostingDate,1,4)                   end as L2LYEAR,
   
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
