@EndUserText.label: 'Report 37 - SEC Schedule STAT'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_37_STAT
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_year : gjahr
returns
{
  Client                : mandt;
  State                 : bezei20;
  ProfitCenter          : prctr;
  NoofFacilities        : abap.int8;
  NetRentableSquareFoot : abap.dec( 23, 3 );

}
implemented by method
  zcl_tf_rpt_37=>get_rpt37_stat;
