@EndUserText.label: 'Report 70-'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_70
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    
    p_year : gjahr
returns
{
  Client         : mandt;

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
  zcl_tf_rpt_70=>get_rpt70;
