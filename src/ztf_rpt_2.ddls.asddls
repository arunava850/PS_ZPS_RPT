@EndUserText.label: 'RPT0017-R&O NSS'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_2
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt
returns
{
  Client        : mandt;
  Region        : regio;
  RegionName    : ktext;
  ProfitCenter  : prctr;
  FiscalYear    : gjahr;
  FiscalPeriod  : poper;
  Collection1   : fins_vhcur12;
  Refund        : fins_vhcur12;
  NetRemittance : fins_vhcur12;
  CurrencyinCC  : fins_currh;

}
implemented by method
  zcl_tf_rpt_2=>get_rpt2;
