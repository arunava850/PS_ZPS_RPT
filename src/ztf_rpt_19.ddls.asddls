@EndUserText.label: 'RPT0032 - Ancillary Operations1'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_19
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_qtr  : abap.char(2),
    p_year : gjahr
  //    p_bukrs : bukrs
returns
{
  Client         : mandt;
  Mainnode       : zmaincode;
  Subnode        : zsubnode;
  Ledger         : fins_ledger;
  CompanyCode    : bukrs;
  GlAccount      : racct;
  GlAccountGroup : saknr;
  ProfitCenter   : prctr;
  Segment        : fb_segment;
  AmountinCC     : fins_vhcur12;
  CurrencyinCC   : fins_currh;
  Q1             : fins_vhcur12;
  Q2             : fins_vhcur12;
  Q3             : fins_vhcur12;
  Q4             : fins_vhcur12;
  Q5             : fins_vhcur12;
  GLAccDesc      : txt20;
}
implemented by method
  zcl_tf_rpt_19=>get_rpt19;
