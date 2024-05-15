@EndUserText.label: 'RPT0017-R&O NSS RR'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_17_RR
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_qtr  : abap.char(2),
    p_year : gjahr
returns
{
  Client       : mandt;
  CompanyCode  : bukrs;
  ProfitCenter : prctr;
  GlAccount    : racct;
  UnitinCC     : runit;
  CQtr         : abap.dec( 23, 3 );
  CQtrPY       : abap.dec( 23, 3 );
  CY           : abap.dec( 23, 3 );
  PY           : abap.dec( 23, 3 );
}
implemented by method
  zcl_tf_rpt_17=>get_rpt17_rr;
