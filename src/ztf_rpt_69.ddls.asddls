@EndUserText.label: 'RPT0017-R&O NSS'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function ZTF_RPT_69
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt  : abap.clnt,
    p_rptid : blart,
    p_bukrs : bukrs,
    p_year  : gjahr

returns
{
  Client                       : mandt;
  AccountingDocument           : belnr_d;
  LedgerFiscalYear             : gjahr;
  GLAccount                    : racct;
  ClearingAccountingDocument   : augbl;
  DocumentItemText             : sgtxt;
  AssignmentReference          : dzuonr;
  GLAccountName                : txt50;
  MasterFixedAsset             : anln1;
  ProfitCenter                 : prctr;
  ProfitCenterName             : ltext;
  Region                       : regio;
  Segment                      : fb_segment;
  FiscalYearVariant            : periv;
  FiscalYearPeriod             : jahrper;
  PostingDate                  : budat;
  PostingKey                   : bschl;
  Supplier                     : lifnr;
  SupplierName                 : name1_gp;
  CHECT                        : chect;
  zaldt                        : dzaldt;
  ClearingDate                 : augdt;
  InvoiceNumber                : xblnr1;
  AccountingDocumentHeaderText : bktxt;
  SerialNumberFA               : am_sernr;
  DocumentDate                 : bldat;
  AmountInCompanyCodeCurrency  : fins_vhcur12;
  CompanyCodeCurrency          : fins_currh;
  FiscalPeriod                 : poper;
  WorkOrder                    : dzuonr;


}
implemented by method
  zcl_tf_rpt_69=>get_rpt69;
