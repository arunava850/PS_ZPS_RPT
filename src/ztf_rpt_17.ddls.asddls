@EndUserText.label: 'RPT0017-R&O NSS'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_17
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_qtr  : abap.char(2),
    p_year : gjahr
returns
{
  Client       : mandt;
  State        : bezei20;
  ProfitCenter : prctr;
  COPByGL      : abap.int8;
  COPByPC      : abap.int8;
  TotalSqFoot  : abap.dec( 23, 3 );

}
implemented by method
  zcl_tf_rpt_17=>get_rpt17;
