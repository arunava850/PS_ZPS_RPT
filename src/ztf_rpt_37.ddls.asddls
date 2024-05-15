@EndUserText.label: 'Report 37 - SEC Schedule'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_37
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    //    p_qtr  : abap.char(2),
    p_year : gjahr
returns
{
  Client                    : mandt;

  racct                     : racct;
  rldnr                     : fins_ledger;
  anbwa                     : anbwa;
  rbukrs                    : bukrs;
  prctr                     : prctr;
  location                  : ort01;
  PostingDate               : budat;
  hsl                       : fins_vhcur12;
//  NoofFacilities            : fins_vhcur12;
// NetRentableSquareFoot     : fins_vhcur12;
  CurrentYearEncumbrances   : fins_vhcur12;
  ICLand                    : fins_vhcur12;
  ICBuildingsandImprovement : fins_vhcur12;
  Acquisitionduringtheyear  : fins_vhcur12;
  GCAmountLand              : fins_vhcur12;
  GCAmtBuildingsandImprov   : fins_vhcur12;
  AccumulatedDepreciation   : fins_vhcur12;

  GLAccDesc                 : txt20;
}
implemented by method
  zcl_tf_rpt_37=>get_rpt37_1;
