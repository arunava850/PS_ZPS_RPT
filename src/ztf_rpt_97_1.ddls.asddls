@EndUserText.label: 'Report 97 - Same Store Stats by Market'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_97_1
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt
returns
{
  Client       : mandt;
  ProfitCenter : prctr;
  district     : ort02;
  NoOfFacility : abap.int4;

}
implemented by method
  zcl_tf_rpt_97=>get_rpt97_nof;
