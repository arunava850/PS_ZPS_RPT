@EndUserText.label: 'RPT0032 - Ancillary Operations'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_19_STAT
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_qtr  : abap.char(2),
    p_year : gjahr
returns
{
  Client       : mandt;
  Mainnode     : zmaincode;
  Subnode      : zsubnode;
  CompanyCode  : bukrs;
  ProfitCenter : prctr;
  GlAccount    : racct;
  // UnitinCC     : runit;
  Q1           : abap.dec( 23, 3 );
  Q2           : abap.dec( 23, 3 );
  Q3           : abap.dec( 23, 3 );
  Q4           : abap.dec( 23, 3 );
  Q5           : abap.dec( 23, 3 );
}
implemented by method
  zcl_tf_rpt_19=>get_rpt19_stat;
