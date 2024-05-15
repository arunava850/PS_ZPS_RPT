@AbapCatalog.sqlViewName: 'ZI6RPTSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stat Reports (Time Chars)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_6_RPT_STAT with parameters

    p_qtr           : abap.char(1),
    p_year          : abap.char(4)

 as select from ZI_5_RPT_STAT
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
//   LYEAR,
//   L2LYEAR,
//   CYQTR,
//   LYQTR,
   NumOfFac,
   NetRentSqFt,
   CstDevlop,
   SqFt_910200,
   SqFt_910210,
   SqFt_910120,
   SqFt_910230,
   SqFt_910220,
   SqFt_910300,
   
// Derivation of Square Foot Occupancy & Annual Contract rent per Sf Measures
 // Last Year QTD derivation
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_LYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and CQuarter = $parameters.p_qtr
     then SqFt_910200 end as SKF_910200_LYQTD,  
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_LYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and CQuarter = $parameters.p_qtr
     then SqFt_910210 end as SKF_910210_LYQTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_LYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and CQuarter = $parameters.p_qtr
     then SqFt_910120 end as SKF_910120_LYQTD,
     
    @DefaultAggregation: #SUM
    @EndUserText.label: 'PSAIC_930710_LYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and CQuarter = $parameters.p_qtr
     then PSAIC_930710 end as PSAIC_930710_LYQTD,
   
 // Last Year YTD derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
     then SqFt_910200 end as SKF_910200_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
    then SqFt_910210 end as SKF_910210_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
    then SqFt_910120 end as SKF_910120_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
     then SqFt_910230 end as SKF_910230_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
    then SqFt_910220 end as SKF_910220_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
    then SqFt_910300 end as SKF_910300_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'PSAIC_930710_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null and LYQTR <= $parameters.p_qtr 
    then PSAIC_930710 end as PSAIC_930710_LYYTD,
    
 //  Current Year QTD derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_CYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CQuarter = $parameters.p_qtr 
    then SqFt_910200 end as SKF_910200_CYQTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_CYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CQuarter = $parameters.p_qtr
    then SqFt_910210 end as SKF_910210_CYQTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_CYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CQuarter = $parameters.p_qtr
    then SqFt_910120 end as SKF_910120_CYQTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'PSAIC_930710_CYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CQuarter = $parameters.p_qtr
    then PSAIC_930710 end as PSAIC_930710_CYQTD,
    
 //  Current Year YTD derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CYQTR <= $parameters.p_qtr
    then SqFt_910200 end as SKF_910200_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CYQTR <= $parameters.p_qtr
    then SqFt_910210 end as SKF_910210_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CYQTR <= $parameters.p_qtr
    then SqFt_910120 end as SKF_910120_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CYQTR <= $parameters.p_qtr
    then SqFt_910230 end as SKF_910230_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CYQTR <= $parameters.p_qtr 
    then SqFt_910220 end as SKF_910220_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CYQTR <= $parameters.p_qtr
    then SqFt_910300 end as SKF_910300_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'PSAIC_930710_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CYQTR <= $parameters.p_qtr
    then PSAIC_930710 end as PSAIC_930710_CYYTD,
    
 //  Last Year derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null then SqFt_910200 end as SKF_910200_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null then SqFt_910210 end as SKF_910210_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null then SqFt_910120 end as SKF_910120_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null then SqFt_910230 end as SKF_910230_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null then SqFt_910220 end as SKF_910220_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYEAR is not null then SqFt_910300 end as SKF_910300_LY,
    
 //  Last to Last Year derivation
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYEAR is not null then SqFt_910200 end as SKF_910200_L2LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYEAR is not null then SqFt_910210 end as SKF_910210_L2LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYEAR is not null then SqFt_910120 end as SKF_910120_L2LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYEAR is not null then SqFt_910230 end as SKF_910230_L2LY,  
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYEAR is not null then SqFt_910220 end as SKF_910220_L2LY,  
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYEAR is not null then SqFt_910300 end as SKF_910300_L2LY
       
}
 
