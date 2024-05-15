CLASS zcl_tf_rpt_2 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt2 FOR TABLE FUNCTION ZTF_RPT_2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_2 IMPLEMENTATION.
 METHOD get_rpt2
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING
      I_GLAccountLineItem I_ProfitCenter I_RegionText .

   declare lv_year char( 4 );

   declare lv_qtr char( 2 );

*************
 lt_gl = SELECT DISTINCT
              PostingKey,
              SUM(AmountInCompanyCodeCurrency) AS AmountInCompanyCodeCurrency,
              CompanyCodeCurrency,
              FiscalPeriod,
              FiscalYear,
              cast ( TRIM( LEADING '0' from AssignmentReference ) as "$ABAP.type( PRCTR )") as ProfitCenter
            FROM I_GLAccountLineItem AS _gl
 WHERE
       _gl.Ledger      = '0L'
   and _gl.CompanyCode = '7100'
   and _gl.GLAccount   = '0000200140'
   and _gl.PostingKey != ''
   and _gl.AssignmentReference != ''

   group by PostingKey,
            CompanyCodeCurrency,
            FiscalPeriod,
            FiscalYear,
            AssignmentReference;

 lt_pc = SELECT DISTINCT
          ControllingArea,
          ProfitCenter,
          TRIM( LEADING '0' FROM ProfitCenter) as Assignment,
          _pc.Region,
          _reg.RegionName

          from I_ProfitCenter as _pc inner join I_RegionText as _reg
               on _reg.Country = _pc.Country
               and _reg.region = _pc.region
               and _reg.Language = session_context('LOCALE_SAP');


 lt_gl1 =
         SELECT
           CASE WHEN PostingKey = '50'
        THEN (AmountInCompanyCodeCurrency * -1 )  END as Collection1,
        CASE when PostingKey = '40'
        then AmountInCompanyCodeCurrency END          as Refund,
          CompanyCodeCurrency,
              FiscalPeriod,
              FiscalYear,
             _gl.ProfitCenter,
             _pc.Region,
             _pc.RegionName

             from :lt_gl as _gl inner join :lt_pc as _pc on _pc.Assignment = _gl.ProfitCenter;

             lt_gl2 =
             select
             Region,
             RegionName ,
             ProfitCenter,
             FiscalYear,
             FiscalPeriod,
             Sum( Collection1 ) as Collection1,
             Sum( Refund ) as Refund,
             CompanyCodeCurrency
             from :lt_gl1
             group by
             Region,
             RegionName,
             ProfitCenter,
             FiscalYear,
             FiscalPeriod,
             CompanyCodeCurrency;

             lt_gl3 =
             select
                          session_context('CLIENT') as Client,
*             cast ( Client as "$ABAP.type( MANDT )" ) as Client,
*             Client,
             Region,
             RegionName ,
             ProfitCenter,
             FiscalYear,
             FiscalPeriod,
             Collection1,
             Refund,
             case when Collection1 is not null and Refund is not null then  ( Collection1  - Refund )
                  when Collection1 is not null and Refund is null then Collection1
                  when Collection1 is null and Refund is not null then ( -1 * Refund )
                  else 0
                  end as NetRemittance,

             CompanyCodeCurrency as CurrencyinCC
             from :lt_gl2;




        return :lt_gl3;
 endmethod.
ENDCLASS.
