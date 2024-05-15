@EndUserText.label: 'STAT Logic'
define table function ZTF_STAT_DERIV

returns
{
  Client : mandt;
  Stagr  : stagr;
  RYear  : gjahr;
  RQtr   : abap.char( 5 );
  Rbukrs : bukrs;
  //  Rcntr  : kostl;
  Prctr  : prctr;
  Runit  : runit;
  MSL    : fagl_quantity;

}
implemented by method
  zcl_stat_deriv=>get_msl;
