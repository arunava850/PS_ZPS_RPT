@EndUserText.label: 'RPT0032 - Ancillary Operation'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_32
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
  PostingDate       : budat;
  AmountinCC        : fins_vhcur12;
  CurrencyinCC      : fins_currh;
  CQtr              : fins_vhcur12;
  CQtrPY            : fins_vhcur12;
  CY                : fins_vhcur12;
  PY                : fins_vhcur12;
  PY1               : fins_vhcur12;
  PY2               : fins_vhcur12;
  GLAccDesc         : txt20;
}
implemented by method
  zcl_tf_rpt_32=>get_rpt32;
