@EndUserText.label: 'RPT0057 _ Consol TB by Month'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_57
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt   : abap.clnt,
    p_fisprd : jahrper
returns
{
  Client         : mandt;
  Ledger         : fins_ledger;
  CompanyCode    : bukrs;
  FiscalYear     : gjahr;
  GlAccount      : racct;
  AmountInCC     : fins_vhcur12;
  CurrencyInCC   : fins_currh;
  TradingPartner : rassc;
  //PostingDate    : budat;
  FiscalYearPer  : abap.char( 7 );
  GLAccDesc      : txt20;
  NodeTxt        : nodetxt;

}
implemented by method
  zcl_tf_rpt_57=>get_rpt57;
