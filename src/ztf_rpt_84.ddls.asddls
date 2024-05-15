@EndUserText.label: 'RPT0017-R&O NSS'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_84
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt
returns
{
  Client           : mandt;
  Region           : regio;
  RegionName       : ktext;
  AccountType      : abap.char( 20 );
  ProfitCenter     : prctr;
  ProfitCenterName : ktext;
  Segment          : fb_segment;
  FiscalYear       : gjahr;
  FiscalPeriod     : poper;
  AmountinCC       : fins_vhcur12;
  CurrencyinCC     : fins_currh;

}
implemented by method
  zcl_tf_rpt_84=>get_rpt84;
