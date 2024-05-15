@AbapCatalog.sqlViewName: 'ZIRPT57CALMSTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED

//@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'RPT0057-Calendar Master'
define view ZI_RPT_57_Cal_Mstr
  with parameters

    p_fisprd : jahrper
  as select distinct from I_CalendarDate


{

  $session.client                                                             as client,
  cast( ''  as abap.char( 2 ))                                                as Ledger,
  cast( ''  as abap.char( 4 ))                                                as CompanyCode,
  CalendarYear                                                                as FiscalYear,
  cast( ''  as abap.char( 10 ))                                               as GlAccount,
  cast( 'USD'  as abap.cuky( 5 ))                                             as CurrencyInCC,
  cast( 0  as abap.curr( 23, 2 ))                                             as AmountInCC,
  cast( ''  as abap.char( 6 ))                                                as TradingPartner,
  cast(concat(CalendarYear, concat( '0', CalendarMonth ) ) as abap.char( 7 )) as FiscalYearPer,
  cast( ''  as abap.char( 20 ))                                               as GLAccDesc,
  cast( ''  as abap.char( 50 ))                                               as NodeTxt
}

where
      CalendarYear  =  SUBSTRING($parameters.p_fisprd, 1 , 4)
  and CalendarMonth <= SUBSTRING($parameters.p_fisprd, 6 , 2)
  or  CalendarYear  = left(dats_add_months(
                      cast(concat(SUBSTRING($parameters.p_fisprd, 1 , 4), concat( '01', '01' ) )
                      as abap.dats),
                    // cast($session.system_date as abap.dats),
                      -12, 'FAIL'), 4)
