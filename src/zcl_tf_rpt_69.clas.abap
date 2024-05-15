CLASS zcl_tf_rpt_69 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt69 FOR TABLE FUNCTION ZTF_RPT_69.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_69 IMPLEMENTATION.
 METHOD get_rpt69
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING
      I_GLAccountLineItem SKAT CEPC CEPCT LFA1 PAYR BKPF ANLA.

*************
lt_gl_k = SELECT DISTINCT
          _gl.AccountingDocument
         FROM I_GLAccountLineItem AS _gl
         where
              _gl.Ledger      = '0L'
  and _gl.CompanyCode  = :p_bukrs
  and _gl.FiscalYear   = :p_year
  and _gl.AccountingDocumentType =  :p_rptid
  and  FinancialAccountType = 'K';


lt_gl_all = SELECT DISTINCT
               session_context('CLIENT') as Client,
               _gl.AccountingDocument,
               _gl.LedgerGLLineItem,
               _gl.LedgerFiscalYear,
               _gl.GLAccount,
               _gl.ClearingAccountingDocument,
               _gl.DocumentItemText,
               _gl.AssignmentReference,
               _gl.ControllingArea,
               _gl.Companycode,
               _gl.ChartOfAccounts,
               _gl.FixedAsset,
               _gl.MasterFixedAsset,
               _gl.ProfitCenter,
               _gl.Segment,
               _gl.FiscalYearVariant,
               _gl.FiscalYearPeriod,
               _gl.PostingDate,
               _gl.Postingkey,
               _gl.Supplier,
               _gl.ClearingDate,
               _gl.DocumentDate,
               _gl.AmountInCompanyCodeCurrency,
               _gl.CompanyCodeCurrency,
               _gl.FiscalPeriod,
               _gl.FinancialAccountType,
               _gl.AssignmentReference as WorkOrder
             FROM I_GLAccountLineItem AS _gl
             inner join :lt_gl_k as _glk
                         on _glk.AccountingDocument = _gl.AccountingDocument
            where  _gl.CompanyCode  = :p_bukrs
                  and _gl.FiscalYear   = :p_year
                  and _gl.AccountingDocumentType =  :p_rptid
                  and _gl.GLAccount  != '0000295000';

lt_gl_pk31 = Select DISTINCT
                    companyCode,
                    ClearingAccountingDocument,
                    AccountingDocument,
                    ClearingDate,
                    Supplier
                     from :lt_gl_all where PostingKey = '31';

lt_gl_ws = select DISTINCT * from :lt_gl_all where FinancialAccountType <> 'K';

 lt_gl = SELECT DISTINCT
               session_context('CLIENT') as Client,
               _gl.AccountingDocument,
               _gl.LedgerFiscalYear,
               _gl.GLAccount,
               _gl.ClearingAccountingDocument,
               _gl.DocumentItemText,
               _gl.AssignmentReference,
               _s.txt50 as GLAccountName,
               _gl.MasterFixedAsset,
               _gl.ProfitCenter,
               _ctext.LTEXT as ProfitCenterName,
               _c.regio as Region,
               _gl.Segment,
               _gl.FiscalYearVariant,
               _gl.FiscalYearPeriod,
               _gl.PostingDate,
               _gl.Postingkey,
               _glpk31.Supplier,
               _l.name1 as SupplierName,
               _p.chect as CHECT,
               _p.zaldt as zaldt,
               _glpk31.ClearingDate,
                _b.xblnr as InvoiceNumber,
               _b.bktxt as AccountingDocumentHeaderText,
*               '' as DocumentReferenceID,
               _a.sernr as SerialNumberFA,
               _gl.DocumentDate,
               _gl.AmountInCompanyCodeCurrency,
               _gl.CompanyCodeCurrency,
               _gl.FiscalPeriod,
               _gl.WorkOrder
             FROM :lt_gl_ws AS _gl
             left outer join :lt_gl_pk31 as _glpk31
                              on _glpk31.AccountingDocument = _gl.AccountingDocument
              LEFT Outer join CEPC as _c
                      on  _c.mandt  = session_context('CLIENT')
                      and   _c.prctr = _gl.ProfitCenter
                      and _c.kokrs = _gl.ControllingArea
                  LEFT Outer join CEPCT as _ctext
                      on  _ctext.mandt  = session_context('CLIENT')
                      and _ctext.spras = session_context('LOCALE_SAP')
                      and _ctext.kokrs = _gl.ControllingArea
                      and _ctext.prctr = _gl.ProfitCenter
                   LEFT Outer join LFA1 as _l
                      on _l.mandt =  session_context('CLIENT')
                      and _l.lifnr = _glpk31.supplier
                   LEFT Outer join PAYR as _p
                       on  _p.mandt = session_context('CLIENT')
                       and _p.zbukr = _glpk31.Companycode
                       and _p.vblnr = _glpk31.ClearingAccountingDocument
                       and _p.zaldt =  _glpk31.ClearingDate
                       and _p.voidr = '00'
                    LEFT Outer join BKPF as _b
                       on  _b.mandt = session_context('CLIENT')
                       and _b.BUKRS = _gl.Companycode
                       and _b.GJAHR = _gl.LedgerFiscalYear
                       and _b.belnr = _gl.AccountingDocument
                    LEFT Outer join SKAT as _s
                        on  _s.mandt = session_context('CLIENT')
                        and _s.spras = session_context('LOCALE_SAP')
                        and _s.ktopl = _gl.ChartOfAccounts
                        and _s.saknr = _gl.GLAccount
                   LEFT Outer join ANLA as _a
                         on  _a.mandt = session_context('CLIENT')
                         and _a.bukrs = _gl.Companycode
                         and _a.anln1 = _gl.MasterFixedAsset
                         and _a.anln2 = _gl.FixedAsset;


       return :lt_gl;
 endmethod.
ENDCLASS.
