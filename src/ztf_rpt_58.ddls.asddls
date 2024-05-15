@EndUserText.label: 'RPT0058-TBal Book by CCode'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_58
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_year : gjahr
returns
{
  Client         : mandt;
  LedgerYear     : abap.char( 7 );
  CompanyCode    : bukrs;
  GlAccount      : racct;
  AmountInCC     : fins_vhcur12;
  CurrencyInCC   : fins_currh;
  TradingPartner : rassc;
  GLAccDesc      : txt20;
  NodeTxt        : nodetxt;
}
implemented by method
  zcl_tf_rpt_58=>get_rpt58;
