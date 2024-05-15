@EndUserText.label: 'STAT Logic'
define table function ZTF_STAT_DERIV_MO

returns
{
  Client        : mandt;
  Stagr         : stagr;
  RYear         : gjahr;
  RQtr          : abap.char( 5 );
  CalendarMonth : calendarmonth;
  Rbukrs        : bukrs;
  Prctr         : prctr;
  Runit         : runit;
  MSL           : fagl_quantity;

}
implemented by method
  zcl_stat_deriv_mo=>get_msl;
