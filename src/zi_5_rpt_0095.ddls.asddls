@AbapCatalog.sqlViewName: 'ZI5RPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0095-Interface View(Other StatKFs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_5_RPT_0095
with parameters
    P_FromPostingDate : fis_budat_from,  
    P_ToPostingDate   : fis_budat_to  

 as select from ZI_4_RPT_0095
 (P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )
 

{
    key HierarchyId,
    key HierarchyParentNode,
    key CompanyCode,
    key ProfitCenter,
    Facilities,
    StatGLAcc,
    StatKF,
    StatUnit,
    PostingDate,
    ZYear,
    CQuarter,
    CQtr,
    CYDate,
    CYEAR,
    LYear,
    L2LYear,
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
    case when LYear is not null and CQuarter = CQtr // and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
     then SqFt_910200 end as SKF_910200_LYQTD,  
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_LYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and CQuarter = CQtr //and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
     then SqFt_910210 end as SKF_910210_LYQTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_LYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and CQuarter = CQtr //and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
     then SqFt_910120 end as SKF_910120_LYQTD,
   
 // Last Year YTD derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
     then SqFt_910200 end as SKF_910200_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
    then SqFt_910210 end as SKF_910210_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
    then SqFt_910120 end as SKF_910120_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
     then SqFt_910230 end as SKF_910230_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
    then SqFt_910220 end as SKF_910220_LYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_LYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null and PostingDate <= DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL')
    then SqFt_910300 end as SKF_910300_LYYTD,
    
 //  Current Year QTD derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_CYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CQuarter = CQtr and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910200 end as SKF_910200_CYQTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_CYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CQuarter = CQtr and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910210 end as SKF_910210_CYQTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_CYQTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and CQuarter = CQtr and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910120 end as SKF_910120_CYQTD,
    
 //  Current Year YTD derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910200 end as SKF_910200_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910210 end as SKF_910210_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910120 end as SKF_910120_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910230 end as SKF_910230_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910220 end as SKF_910220_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_CYYTD'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when CYEAR is not null and PostingDate <= $parameters.P_ToPostingDate
    then SqFt_910300 end as SKF_910300_CYYTD,
    
 //  Last Year derivation

    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null then SqFt_910200 end as SKF_910200_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null then SqFt_910210 end as SKF_910210_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null then SqFt_910120 end as SKF_910120_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null then SqFt_910230 end as SKF_910230_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null then SqFt_910220 end as SKF_910220_LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when LYear is not null then SqFt_910300 end as SKF_910300_LY,
    
 //  Last to Last Year derivation
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910200_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYear is not null then SqFt_910200 end as SKF_910200_L2LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910210_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYear is not null then SqFt_910210 end as SKF_910210_L2LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910120_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYear is not null then SqFt_910120 end as SKF_910120_L2LY,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910230_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYear is not null then SqFt_910230 end as SKF_910230_L2LY,  
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910220_L2LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYear is not null then SqFt_910220 end as SKF_910220_L2LY,  
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'SKF_910300_LY'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when L2LYear is not null then SqFt_910300 end as SKF_910300_L2LY
    
   
} 

      
