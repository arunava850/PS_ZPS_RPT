@AbapCatalog.sqlViewName: 'ZVRPT37CONS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 37 SEC Schedule III'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
@ObjectModel.representativeKey: 'mainnode'
//@ObjectModel.usageType.serviceQuality: #A
//@ObjectModel.usageType.sizeCategory: #S
//@ObjectModel.usageType.dataClass: #CUSTOMIZING
@AbapCatalog: {
                buffering.status: #NOT_ALLOWED }

@Analytics.settings.maxProcessingEffort: #HIGH
@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata: { ignorePropagatedAnnotations: true,
             allowExtensions: true }
@ObjectModel: { supportedCapabilities: [ #ANALYTICAL_QUERY ],
                modelingPattern: #ANALYTICAL_QUERY,
                usageType: { sizeCategory: #XXL,
                             serviceQuality: #D,
                             dataClass: #MIXED } }
define view ZC_RPT_37
  with parameters

    p_year : gjahr
  as select from ZI_RPT_37
                 ( p_year: $parameters.p_year  )

{
  key racct,
  key rldnr,
  key anbwa,
  key rbukrs,
  key prctr,
      @AnalyticsDetails.query.axis: #ROWS
  key location,
      PostingDate,
      GLAccDesc,
      CurrencyinCC,
      hsl,
//      @EndUserText.label: 'No. Of Facilities'
//      NoofFacilities,
//      @EndUserText.label: 'Net Rentable Square Foot'
//      NetRentableSquareFoot,
      @EndUserText.label: 'Current Year Encumbrances'
      CurrentYearEncumbrances,
      @EndUserText.label: 'Initial Cost-Land'
      ICLand,
      @EndUserText.label: 'Initial Cost-Buildings and Improvement'
      ICBuildingsandImprovement,
      @EndUserText.label: 'Acquisition during the year'
      Acquisitionduringtheyear,
      @EndUserText.label: 'Gross Carrying Amount-Land'
      GCAmountLand,
      @EndUserText.label: 'Gross Carrying-Buildings and Improvement'
      GCAmtBuildingsandImprov,
      @EndUserText.label: 'Gross Carrying-TOTAL'
      GCTOTAL,

      @EndUserText.label: 'Accumulated Depreciation'
      AccumulatedDepreciation





}
