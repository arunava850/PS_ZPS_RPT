@EndUserText.label: 'RRPT0040 Operating Data SameStore'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_40
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt  : abap.clnt,
    p_month : month,
    p_qtr   : abap.char(2),
    p_year  : gjahr
returns
{
  Client            : mandt;
  Mainnode          : zmaincode;
  Subnode           : zsubnode;
  Ledger            : fins_ledger;
  CompanyCode       : bukrs;
  GlAccount         : racct;
  GlAccountGroup    : saknr;
  ProfitCenter      : prctr;
  Segment           : fb_segment;
  CalendarMonth     : calendarmonth;
  CalendarYear      : calendaryear;
  CalendarYearMonth : vdm_yearmonth;
  AmountinCC        : abap.dec(23,3);
  CurrencyinCC      : fins_currh;
  CQtr              : abap.dec(23,3);
  CQtrPY            : abap.dec(23,3);
  CY                : abap.dec(23,3);
  PY                : abap.dec(23,3);
  PY1               : abap.dec(23,3);
  PY2               : abap.dec(23,3);
  GLAccDesc         : txt20;
}
implemented by method
  zcl_tf_rpt_40=>get_rpt40;
