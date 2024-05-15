@AbapCatalog.sqlViewName: 'ZI3RPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0095-Interface View(Stat KF Derivation)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_3_RPT_0095
with parameters
   P_FromPostingDate : fis_budat_from,  
   P_ToPostingDate   : fis_budat_to  
    

as select from ZB_2_RPT_0095 as a right outer join ZI_STAT_DERIV_PDATE as b 
                                         on  a.ProfitCenter = b.Prctr 

{
key a.HierarchyId,
key a.HierarchyParentNode,
key b.Rbukrs as CompanyCode,
key b.Prctr  as ProfitCenter,
case when b.Prctr is not null and b.Stagr = '910230' then 1 else 0 end as Counter,
b.Stagr      as StatGLAcc,
b.MSL        as StatKF,
b.Runit      as StatUnit,
b.RYear      as ZYear,
case when b.RYear = substring($parameters.P_ToPostingDate,1,4) 
              then b.RYear                      end as CYEAR,

case b.RQtr when 'March' then '1'
            when 'June'  then '2'
            when 'Sep'   then '3'
            when 'Dec'   then '4' end as CQuarter,
cast(Concat(b.RYear,'0101') as abap.dats) as CYDate,

substring($parameters.P_ToPostingDate,5,2)      as ZMONTH,

case when b.RYear <> substring($parameters.P_ToPostingDate,1,4) then b.RYear end as LYear,

case when b.RYear = substring($parameters.P_ToPostingDate,1,4) and  b.RYear <> substring($parameters.P_ToPostingDate,1,4)
     then b.RYear end as L2LYear,

cast(b.postingdate as abap.dats) as PostingDate,
a.Facilities,
a.Location,

  @AnalyticsDetails.query.axis: #COLUMNS    
  @EndUserText.label: 'Number of Facilities'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910230' then  b.MSL end as NumOfFac,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Net rentable square feet(in thousands)'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910220' then  b.MSL end as NetRentSqFt,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Costs to develop (in thousands)'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910300' then  b.MSL end as CstDevlop,  
 
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Square foot 910200'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910200' then b.MSL end as SqFt_910200,
  
  @AnalyticsDetails.query.axis: #COLUMNS
  @EndUserText.label: 'Square foot 910210'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910210' then  b.MSL end as SqFt_910210,
  
  @AnalyticsDetails.query.axis: #COLUMNS  
  @EndUserText.label: 'Square foot 910120'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910120' then b.MSL end as SqFt_910120,
  
  @AnalyticsDetails.query.axis: #COLUMNS  
  @EndUserText.label: 'Square foot 910230'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910230' then b.MSL end as SqFt_910230,
  
  @AnalyticsDetails.query.axis: #COLUMNS  
  @EndUserText.label: 'Square foot 910220'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910220' then b.MSL end as SqFt_910220,
  
  @AnalyticsDetails.query.axis: #COLUMNS  
  @EndUserText.label: 'Square foot 910300'
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'StatUnit'
  case when b.Stagr = '910300' then b.MSL end as SqFt_910300
}
