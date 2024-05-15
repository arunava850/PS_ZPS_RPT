@AbapCatalog.sqlViewName: 'ZI2RPT0038'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0038 Interface View(Other Stat KFs)'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_2_RPT_0038
with parameters

     p_qtr: abap.char(1),
     p_year: abap.char(4)
    
 as select from ZI_5_RPT_STAT
                ( p_qtr:$parameters.p_qtr, p_year:$parameters.p_year)
                                        
{

     key HierarchyId,
     key Facilities,
     key CompanyCode,
     key ProfitCenter,
     key HierarchyParentNode,
     StatGLAcc,
     StatKF,
     StatUnit,
    // ZYear,
     CYEAR,
     CQuarter,
     CYDate,
     LYEAR,
     L2LYEAR,
     PostingDate,
     Location,
     Counter,    
    
 //  Current Year YTD derivation
  
    @DefaultAggregation: #SUM
    @EndUserText.label: 'No.of Facilities(SS,Developed,Acquired)'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when (CYEAR is not null and CYQTR  = $parameters.p_qtr) and
    (Facilities = 'Same Store' or Facilities = 'Recent Acquisition' or Facilities = 'Recent Developed')
    then SqFt_910220 end as SKF_910220_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'No. of Expanded & Other NSS Faciltiies'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when (CYEAR is not null and CYQTR  = $parameters.p_qtr) and
    (Facilities = 'Recent Expansion' or Facilities = 'Damaged and Other')
    then SqFt_910210 end as SKF_910210_CYYTD,
    
    @DefaultAggregation: #SUM
    @EndUserText.label: 'No. of Storage Facilities'
    @Semantics.quantity.unitOfMeasure: 'StatUnit'
    case when (CYEAR is not null and CYQTR  = $parameters.p_qtr) then Counter end as SKF_910230_CYYTD
}
  
 where HierarchyId = 'H106/PSCO/PS_SS'  and
       (Facilities = 'Recent Expansion'  or 
       Facilities = 'Damaged and Other'  or 
       Facilities = 'Same Store'         or 
       Facilities = 'Recent Acquisition' or 
       Facilities = 'Recent Developed' ) and                                     
       (StatGLAcc = '910210' or
       StatGLAcc = '910220' or
       StatGLAcc = '910230'  )
       

      
