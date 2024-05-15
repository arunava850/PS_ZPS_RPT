@EndUserText.label: 'RPT0012- Same vs Non-Same Store'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_12
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_month  : month,
    p_year : gjahr,
    p_pch  : zpch
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
  AmountinCC     : abap.dec(23,3);
  CurrencyinCC   : fins_currh;
  CQtr           : abap.dec(23,3);
  CQtrPY         : abap.dec(23,3);
  CY             : abap.dec(23,3);
  PY             : abap.dec(23,3);
  PY1            : abap.dec(23,3);
  PY2            : abap.dec(23,3);
  GLAccDesc      : txt20;
}
implemented by method
  zcl_tf_rpt_12=>get_rpt12;
