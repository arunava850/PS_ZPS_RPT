@EndUserText.label: 'Report 87'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_87
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    
    p_year : gjahr
returns
{
  Client         : mandt;
Report : abap.char(10);
CompanyCode   : bukrs;
Ledger   : fins_ledger;
Year   : gjahr;
Account  : racct;
AlternativeACC   : lokkt ;
FiscalPeriod  : abap.numc(7) ;
DocType  : blart ;
ProfitCenter  : prctr;
Segment  : abap.char(10);
CompanyCodeCurrency  : abap.cuky ;
Region  : regio ;
//LongText  : ltext;
Title : anred;
LongText : ltext;
period : abap.char(15);
AmountinCC   : fins_vhcur12;

  GLAccDesc      : txt20;
}
implemented by method
  zcl_tf_rpt_87=>get_rpt87;
