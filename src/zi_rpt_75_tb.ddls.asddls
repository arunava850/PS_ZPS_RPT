@AbapCatalog.sqlViewName: 'ZIRPT75TB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0075 Trial Bal P&L by TPP'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
define view ZI_RPT_75_TB
  with parameters
    p_ledg  : fins_ledger,
    p_bukrs : bukrs,
    p_year  : gjahr
  as select from    faglflext as _gl
    left outer join skat      as _skat on  _skat.mandt = _gl.rclnt
                                       and _skat.spras = $session.system_language
                                       and _skat.ktopl = 'PSUS'
                                       and _skat.saknr = _gl.racct
{

  _gl.rbukrs                                    as CompanyCode,
  _gl.prctr                                     as ProfitCenter,
  _gl.rcntr                                     as CostCenter,
  _gl.racct                                     as GLAccount,
  _skat.txt50                                   as GLAccountName,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01                         as hsl01,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02             as hsl02,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 as hsl03,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 +
  _gl.hsl04                                     as hsl04,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 +  _gl.hsl04 +
  _gl.hsl05                                     as hsl05,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 + _gl.hsl04 +
  _gl.hsl05 +
  _gl.hsl06                                     as hsl06,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 + _gl.hsl04 +
  _gl.hsl05 + _gl.hsl06 +
  _gl.hsl07                                     as hsl07,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 + _gl.hsl04 +
  _gl.hsl05 + _gl.hsl06 + _gl.hsl07 +
  _gl.hsl08                                     as hsl08,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 + _gl.hsl04 +
  _gl.hsl05 + _gl.hsl06 + _gl.hsl07 + _gl.hsl08 +
  _gl.hsl09                                     as hsl09,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 + _gl.hsl04 +
  _gl.hsl05 + _gl.hsl06 + _gl.hsl07 + _gl.hsl08 + _gl.hsl09 +
  _gl.hsl10                                     as hsl10,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 + _gl.hsl04 +
  _gl.hsl05 + _gl.hsl06 + _gl.hsl07 + _gl.hsl08 + _gl.hsl09 +
  _gl.hsl10 +  _gl.hsl11                        as hsl11,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt + _gl.hsl01 + _gl.hsl02 + _gl.hsl03 + _gl.hsl04 +
  _gl.hsl05 + _gl.hsl06 + _gl.hsl07 + _gl.hsl08 + _gl.hsl09 +
  _gl.hsl10 +  _gl.hsl11 +  _gl.hsl12 +
     _gl.hsl13 + _gl.hsl14 + _gl.hsl15 +
     _gl.hsl16                                  as hsl12,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hslvt,
  @DefaultAggregation: #SUM
  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
  _gl.hsl01 + _gl.hsl02 + _gl.hsl03 +
   _gl.hsl04 + _gl.hsl05 + _gl.hsl06 +
   _gl.hsl07 + _gl.hsl08 + _gl.hsl09 +
   _gl.hsl10 + _gl.hsl11 + _gl.hsl12 +
   _gl.hsl13 + _gl.hsl14 + _gl.hsl15 +
   _gl.hsl16 + _gl.hslvt


                                                as YearEndBl,

  @Semantics.currencyCode:true
  _gl.rtcur                                     as CompanyCodeCurrency

}
where
      _gl.rclnt  = $session.client
  and _gl.rldnr  = :p_ledg
  and _gl.rbukrs = :p_bukrs
  and _gl.ryear  = :p_year;
