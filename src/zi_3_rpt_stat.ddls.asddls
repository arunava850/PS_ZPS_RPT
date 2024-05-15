@AbapCatalog.sqlViewName: 'ZI3RPTSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stat Reports (Time Chars)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_3_RPT_STAT with parameters

    p_qtr           : abap.char(1),
    p_year          : abap.char(4)

 as select from ZI_2_RPT_STAT
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
    CustomDt,
    
    case substring(CustomDt,5,2) when  '01' then '1'
             when  '02' then '1'
              when  '03' then '1'
              when  '04' then '2'
              when  '05' then '2'
              when  '06' then '2'
              when  '07' then '3'
              when  '08' then '3'
              when  '09' then '3'
              when  '10' then '4'
              when  '11' then '4'
              when  '12' then '4'
               else ''
                 end                               as ZQUARTER,
   substring(CustomDt,5,2)      as ZMONTH,
   
   case substring(CustomDt,5,2) when  '01' then 'Jan'
                 when  '02' then 'Feb'
                  when  '03' then 'Mar'
                  when  '04' then 'Apr'
                  when  '05' then 'May'
                  when  '06' then 'Jun'
                  when  '07' then 'Jul'
                  when  '08' then 'Aug'
                  when  '09' then 'Sep'
                  when  '10' then 'Oct'
                  when  '11' then 'Nov'
                  when  '12' then 'Dec'
                   else ''
                     end                          as ZMONTH1,
                     
   substring(CustomDt,1,4)     as ZYEAR,
   
   substring(DATS_ADD_DAYS(CustomDt,-365,'NULL'),1,4) as ZLYEAR,
   substring(DATS_ADD_DAYS(CustomDt,-730,'NULL'),1,4) as ZL2LYEAR,
   
   substring(DATS_ADD_DAYS(CustomDt,-365,'NULL'),5,2) as ZLYMTH,
   substring(DATS_ADD_DAYS(CustomDt,-730,'NULL'),5,2) as ZL2LYMTH,
   
   case substring(DATS_ADD_DAYS(CustomDt,-365,'NULL'),5,2) 
                  when  '01' then '1'
                  when  '02' then '1'
                  when  '03' then '1'
                  when  '04' then '2'
                  when  '05' then '2'
                  when  '06' then '2'
                  when  '07' then '3'
                  when  '08' then '3'
                  when  '09' then '3'
                  when  '10' then '4'
                  when  '11' then '4'
                  when  '12' then '4'
                   else '' end                             as ZLQUARTER,
                   
   case substring(DATS_ADD_DAYS(CustomDt,-730,'NULL'),5,2) 
                  when  '01' then '1'
                  when  '02' then '1'
                  when  '03' then '1'
                  when  '04' then '2'
                  when  '05' then '2'
                  when  '06' then '2'
                  when  '07' then '3'
                  when  '08' then '3'
                  when  '09' then '3'
                  when  '10' then '4'
                  when  '11' then '4'
                  when  '12' then '4'
                   else '' end                             as ZL2LYQTR,      
    
    
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
