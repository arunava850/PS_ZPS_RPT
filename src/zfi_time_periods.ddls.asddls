@AbapCatalog.sqlViewName: 'ZFITIMEPERD'
@AbapCatalog.compiler.compareFilter: true

@VDM.viewType: #COMPOSITE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.private:true
@ClientHandling.algorithm:#SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.dataClass: #MIXED
@ObjectModel.usageType.sizeCategory: #XL
@AccessControl.personalData.blocking: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

define view ZFI_TIME_PERIODS
  --  with parameters
  --    P_FISCPERIOD : fis_jahrper_conv

  as select distinct from I_FiscalPeriodForVariant as FP
  association [1..1] to ZFI_FISCAL_CALDATE as FCALDT on  FP.FiscalPeriodStartDate = FCALDT.CalendarDate
                                                     and FCALDT.FiscalYearVariant = 'K4'


{
      //  @ObjectModel.Hierarchy.association: '_ZCS_FISCAL_HIER'
  key FP.FiscalYearPeriod,
      FP.FiscalYearVariant,
      FP.FiscalPeriod,
      FP.FiscalYear,

      FP.FiscalPeriodStartDate,

      // Various Time Periods
      FiscalYearEndDate,

      // Fiscal Year - First Fiscal Year Period
      FCALDT.CurrFYFirstFYP,

      // Fiscal Year - Last Fiscal Year Period
      FCALDT.CurrFYLastFYP,

      FCALDT.FiscalQuarter,
      FCALDT.FiscalQuarterStartDate,
      FCALDT.FiscalQuarterEndDate,

      // Fiscal Quarter - First Fiscal Year Period
      FCALDT.CurrFQFirstFYP,

      // Fiscal Quarter - First Fiscal Period
      FCALDT.CurrFQFirstFP,

      // Fiscal Quarter - Last Fiscal Year Period
      FCALDT.CurrFQLastFYP,

      // Fiscal Quarter - Last Fiscal Period
      FCALDT.CurrFQLastFP,

      FCALDT.FiscalWeek,
      FCALDT.FiscalWeekStartDate,
      FCALDT.FiscalWeekEndDate,

      FCALDT.FiscalYearQuarter,
      FCALDT.FiscalYearWeek,

      FCALDT.FiscalYearConsecutiveNumber,
      FCALDT.FiscalPeriodConsecutiveNumber,
      FCALDT.FiscalQuarterConsecutiveNumber,
      FCALDT.FiscalWeekConsecutiveNumber,

      // Current Fiscal Year - 000 Period
      FCALDT.CurrFY000,

      // Current Fiscal Year
      FCALDT.CurrFY,

      // Previous Fiscal Year - 000 Period
      FCALDT.PrvFY000,

      // Previous Fiscal Year - last Period
      FCALDT.PrvFYLP,

      // Previous Fiscal Year
      FCALDT.PrvFY,

      // Previous Fiscal Year 2
      FCALDT.PrvFY2,

      // Previous Fiscal Year Period
      FCALDT.PrvFYP,

      // Next Fiscal Year Period
      FCALDT.NextFYP,

      // Fiscal Year Period - 13 Periods back
      FCALDT.FYPPRV13,

      // Previous Quarter - Last Fiscal Year Period Begin Date
      FCALDT.PrvFQLastFYPBegDate,

      // Previous Quarter - Last Fiscal Year Period Value
      FCALDT.PrvFQLastFYP,

      // Previous Quarter - Last Fiscal Period Value
      FCALDT.PrvFQLastFP,

      // Previous Quarter - First Fiscal Year Period Begin Date
      FCALDT.PrvFQFirstFYPBegDate,

      // Previous Quarter - First Fiscal Year Period Value
      FCALDT.PrvFQFirstFYP,

      // Previous Quarter - First Fiscal Period Value
      FCALDT.PrvFQFirstFP,

      // First Quarter - First Fiscal Year Period Value
      FCALDT.CurrFYFirstQtrFirstFYP,

      // First Quarter - Last Fiscal Year Period Value
      FCALDT.CurrFYFirstQtrLastFYP,

      // Previous Year - Fiscal Year Period Begin Date
      FCALDT.PrvFYFYPBegDate,

      // Previous Year - Fiscal Year Period
      FCALDT.PrvFYFYP,

      // Previous Year - First Fiscal Year Period
      FCALDT.PrvFYFirstFYP,

      // Previous Year - Quarter First Fiscal Year Period
      FCALDT.PrvFYQtrFirstFYP,

      // Previous Year - Quarter Last Fiscal Year Period
      FCALDT.PrvFYQtrLastFYP,

      // Previous 2 Years - Fiscal Year Period Begin Date
      FCALDT.Prv2FYFYPBegDate,

      // Previous 2 Years - Fiscal Year Period
      FCALDT.Prv2FYFYP,

      // Previous 2 Years - First Fiscal Year Period
      FCALDT.Prv2FYFirstFYP,

      // Previous 2 Years - Quarter First Fiscal Year Period
      FCALDT.Prv2FYQtrFirstFYP,

      // Previous 2 Years - Quarter Last Fiscal Year Period
      FCALDT.Prv2FYQtrLastFYP,

      FCALDT.NumberOfDays,
      FCALDT.NumberOfDays_Year,

      // Previous Fiscal Year last quarter first period
      FCALDT.PrvFYLQFP

      // association
      //    _ZCS_FISCAL_HIER
}

where
  FP.FiscalYearVariant = 'K4'
