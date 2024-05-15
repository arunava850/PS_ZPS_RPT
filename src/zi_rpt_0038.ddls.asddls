@AbapCatalog.sqlViewName: 'ZIRPT0038'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0038-Interface View(Stat KF Derivation)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_0038
with parameters
    P_FromPostingDate : fis_budat_from,  
    P_ToPostingDate   : fis_budat_to  

as select from ZI_3_RPT_0095
(P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )

 as a inner join ZI_STAT_DERIV_PDATE as b on  a.ProfitCenter =  b.Prctr                                                                                          

{
 key a.HierarchyId,
 key a.HierarchyParentNode,
 key a.CompanyCode,
 key a.ProfitCenter,
 a.StatGLAcc,
 a.StatKF,
 a.StatUnit,
 a.ZYear,
 a.CYEAR,
 a.CQuarter,
 a.CYDate,
 a.ZMONTH,
 a.LYear,
 a.L2LYear,
 a.PostingDate,
 a.Facilities,
 a.Location,
 b.Stagr,
 b.RYear,
 b.RQtr,
 b.Rbukrs,
 b.Prctr,
 b.Runit,
 b.MSL,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Square foot 910210'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910210' and a.Facilities = 'Recent Expansion' or a.Facilities = 'Damaged and Other' 
  then  b.MSL end as SqFt_910210,
  
  @AnalyticsDetails.query.axis: #COLUMNS  
  @EndUserText.label: 'Square foot 910220'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910220' and a.Facilities = 'Same Store' or a.Facilities = 'Recent Acquisition' or a.Facilities = 'Recent Developed'
  then b.MSL end as SqFt_910220,
  
  @AnalyticsDetails.query.axis: #COLUMNS  
  @EndUserText.label: 'Square foot 910230'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910230' then b.MSL end as SqFt_910230,
  
  a.Counter as NumberofFacilities
}
 where a.HierarchyId = 'H106/PSCO/PS_SS'  and
       (a.Facilities = 'Recent Expansion'   or 
       a.Facilities = 'Damaged and Other'  or 
       a.Facilities = 'Same Store'         or 
       a.Facilities = 'Recent Acquisition' or 
       a.Facilities = 'Recent Developed')  and
       (b.Stagr = '910210' or
       b.Stagr = '910220' or
       b.Stagr = '910230' )      
       

 
