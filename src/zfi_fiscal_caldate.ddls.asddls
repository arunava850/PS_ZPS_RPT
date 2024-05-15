@AbapCatalog.sqlViewName: 'ZFI_FISC_CALDATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
//
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Fiscal Calendar Date'
@VDM.viewType: #BASIC

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #CUSTOMIZING

@ObjectModel.representativeKey: 'CalendarDate'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view ZFI_FISCAL_CALDATE as select from I_FiscalCalendarDate  

//  association[0..*] to ZCS_FISCAL_HIER as _ZCS_FISCAL_HIER
//        on $projection.FiscalYearPeriod = _ZCS_FISCAL_HIER.FiscalYearPeriod 

{
key FiscalYearVariant,
key CalendarDate,

    FiscalYear,
    FiscalYearStartDate,
    FiscalYearEndDate,
    dats_days_between(FiscalYearStartDate, FiscalYearEndDate)+1 as NumberOfDays_Year,

// Fiscal Year - First Fiscal Year Period
    concat(LEFT(FiscalYearStartDate,4),'001')  
    as CurrFYFirstFYP,
        
// Fiscal Year - Last Fiscal Year Period
    concat(LEFT(FiscalYearEndDate,4),'012')  
    as CurrFYLastFYP,

// @ObjectModel.Hierarchy.association: '_ZCS_FISCAL_HIER'
    FiscalPeriod,
    FiscalPeriodStartDate,
    FiscalPeriodEndDate,
    dats_days_between(FiscalPeriodStartDate, FiscalPeriodEndDate)+1 as NumberOfDays,

    FiscalQuarter,
    FiscalQuarterStartDate,
    FiscalQuarterEndDate,

// Fiscal Quarter - First Fiscal Year Period
    concat(LEFT(FiscalQuarterStartDate,4),concat('0',SUBSTRING(FiscalQuarterStartDate,5,2)))  
    as CurrFQFirstFYP,

// Fiscal Quarter - First Fiscal Period
    concat('0',SUBSTRING(FiscalQuarterStartDate,5,2)) 
    as CurrFQFirstFP,

// Fiscal Quarter - Last Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalQuarterStartDate ,3,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,3,'UNCHANGED'),5,2)))  
    as CurrFQLastFYP,

// Fiscal Quarter - Last Fiscal Period
    concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,3,'UNCHANGED'),5,2))  
    as CurrFQLastFP,

    FiscalWeek,
    FiscalWeekStartDate,
    FiscalWeekEndDate,

    FiscalYearPeriod,
    FiscalYearQuarter,
    FiscalYearWeek,
    
    FiscalYearConsecutiveNumber,
    FiscalPeriodConsecutiveNumber,
    FiscalQuarterConsecutiveNumber,
    FiscalWeekConsecutiveNumber,

// Current Fiscal Year - 000 Period
    CONCAT(LEFT(FiscalPeriodStartDate,4),'000')
    as CurrFY000,

// Current Fiscal Year
    LEFT(FiscalPeriodStartDate,4)
    as CurrFY,

// Previous Fiscal Year - 000 Period
    CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4),'000')
    as PrvFY000,

// Previous Fiscal Year - 000 Period
    CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4),'012')
    as PrvFYLP,  
    // Previous Fiscal Year - 000 Period
    CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4),concat('12','01'))
    as PrvFYLPStratDT,   
     CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4),concat('-12','-31'))
    as PrvFYLPEndDT, 
       

// Previous Fiscal Year
    LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4)
    as PrvFY,

// Previous Fiscal Year 2
    LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-24,'UNCHANGED'),4)
    as PrvFY2,

// Previous Fiscal Year Period  
    CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-1,'UNCHANGED') ,4),CONCAT('0',Substring(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-1,'UNCHANGED') ,5,2)) )
    as PrvFYP,
    
// Next Fiscal Year Period  
    CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,1,'UNCHANGED') ,4),CONCAT('0',Substring(DATS_ADD_MONTHS(FiscalPeriodStartDate ,1,'UNCHANGED') ,5,2)) )
    as NextFYP,

// Fiscal Year Period - 13 Periods Back - For Rolling 13 Period Report
    CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED') ,4),CONCAT('0',Substring(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED') ,5,2)) )
    as FYPPRV13,

// Previous Quarter - Previous Fiscal Year Period Begin Date
    DATS_ADD_MONTHS(FiscalQuarterStartDate ,-1,'UNCHANGED') 
    as PrvFQLastFYPBegDate,

// Previous Quarter - Previous Fiscal Year Period Value
    concat(LEFT(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-1,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-1,'UNCHANGED'),5,2)))  
    as PrvFQLastFYP,

// Previous Quarter - Last Fiscal Period Value
    concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-1,'UNCHANGED'),5,2))  
    as PrvFQLastFP,

// Previous Quarter - First Fiscal Year Period Begin Date
    DATS_ADD_MONTHS(FiscalQuarterStartDate ,-3,'UNCHANGED') 
    as PrvFQFirstFYPBegDate,

// Previous Quarter - First Fiscal Year Period Value
    concat(LEFT(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-3,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-3,'UNCHANGED'),5,2)))  
    as PrvFQFirstFYP,

// Previous Quarter - First Fiscal Period Value
    concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-3,'UNCHANGED'),5,2))  
    as PrvFQFirstFP,

// First Quarter - First Fiscal Year Period Value
    concat(LEFT(FiscalQuarterStartDate,4),'001')  
    as CurrFYFirstQtrFirstFYP,

// First Quarter - Last Fiscal Year Period Value
    concat(LEFT(FiscalQuarterStartDate,4),'003')  
    as CurrFYFirstQtrLastFYP,

// Previous Year - Fiscal Year Period Begin Date
    DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED') 
    as PrvFYFYPBegDate,

// Previous Year - Fiscal Year Begin Date
    DATS_ADD_MONTHS(FiscalYearStartDate ,-12,'UNCHANGED') 
    as PrvFYBegDate,    

// Previous Year - Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),5,2)))
    as PrvFYFYP,

// Previous Year - First Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4),'001')
    as PrvFYFirstFYP,

// Previous Year - Quarter First Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-12,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-12,'UNCHANGED'),5,2)))
    as PrvFYQtrFirstFYP,

// Previous Year - Quarter Last Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-10,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-10,'UNCHANGED'),5,2)))
    as PrvFYQtrLastFYP,

// Previous 2 Years - Fiscal Year Period Begin Date
    DATS_ADD_MONTHS(FiscalPeriodStartDate ,-24,'UNCHANGED') 
    as Prv2FYFYPBegDate,

// Previous 2 Years - Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-24,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-24,'UNCHANGED'),5,2)))
    as Prv2FYFYP,

// Previous 2 Years - First Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-24,'UNCHANGED'),4),'001')
    as Prv2FYFirstFYP,

// Previous 2 Years - Quarter First Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-24,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-24,'UNCHANGED'),5,2)))
    as Prv2FYQtrFirstFYP,

// Previous 2 Years - Quarter Last Fiscal Year Period
    concat(LEFT(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-22,'UNCHANGED'),4),concat('0',SUBSTRING(DATS_ADD_MONTHS(FiscalQuarterStartDate ,-22,'UNCHANGED'),5,2)))
    as Prv2FYQtrLastFYP,

 // association
//    _ZCS_FISCAL_HIER  

// Fiscal Year Period From
    case when FiscalPeriod = '000'
         then '999'
         else '000'
    end
    as ADB_PRV_FPER_FM,

// Fiscal Year Period To
    case when FiscalPeriod = '000'
         then cast ('999' as abap.char( 3 ))
         else lpad( cast( cast( cast( FiscalPeriod as abap.int1 ) - 1 as abap.int1 ) as abap.char( 3 ) ) , 3, '000' )
    end
    as ADB_PRV_FPER_TO,
    
// Previous Fiscal Year last quarter first period  
    CONCAT(LEFT(DATS_ADD_MONTHS(FiscalPeriodStartDate ,-12,'UNCHANGED'),4),'010')
    as PrvFYLQFP
                  
} 

      

