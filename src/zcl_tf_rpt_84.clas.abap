CLASS zcl_tf_rpt_84 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt84 FOR TABLE FUNCTION ZTF_RPT_84.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_84 IMPLEMENTATION.
 METHOD get_rpt84
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING
      I_GLAccountLineItem I_ProfitCenter I_RegionText I_ProfitCenterText.

   declare lv_year char( 4 );

   declare lv_qtr char( 2 );

*************
 lt_gl = SELECT DISTINCT
               session_context('CLIENT') as Client,
              _pc.Region,
               _regText.RegionName,
                case _gl.GLAccount
              when '0000556000' then 'Cash Basis MF'
              when '0000556010' then 'Cash to Accural'
              end as Accounttype,
               _gl.ProfitCenter,
               _pcText.ProfitCenterName,
               _pc.Segment,
               FiscalYear,
                FiscalPeriod,
              SUM(AmountInCompanyCodeCurrency) AS AmountinCC ,
              CompanyCodeCurrency as CurrencyinCC
            FROM I_GLAccountLineItem AS _gl
                 inner join I_ProfitCenter as _pc
                 on _pc.ProfitCenter = _gl.ProfitCenter
                 left outer join I_RegionText as _regText
                  on _regText.country = _pc.country
                  and _regText.Region = _pc.Region
                  and _regText.Language = session_context('LOCALE_SAP')
                left outer join I_ProfitCenterText as _pcText
                  on _pcText.Language = session_context('LOCALE_SAP')
                  and _pcText.ProfitCenter = _pc.ProfitCenter


 WHERE
       _gl.Ledger      = 'ZM'
   and ( _gl.GLAccount   = '0000556000' OR
         _gl.GLAccount   = '0000556010' )

   group by _pc.Region,
            _regText.RegionName,
            _gl.GLAccount,
            _gl.ProfitCenter,
            _pcText.ProfitCenterName,
            _pc.Segment,
            CompanyCodeCurrency,
            FiscalPeriod,
            FiscalYear,
            AssignmentReference;

 lt_pc = SELECT DISTINCT *
         from :lt_gl;

        return :lt_pc;
 endmethod.
ENDCLASS.
