CLASS zcl_tf_rpt_58 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt58 FOR TABLE FUNCTION ZTF_RPT_58.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_58 IMPLEMENTATION.

 METHOD get_rpt58
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  I_GLAccountLineItem
    skat
    zb_altgl_hier
    ZB_HIER_NODE_TEXT.
*     hrrp_node hrrp_nodet
  declare lv_year char( 4 );
  declare lv_month char( 2 );
  declare lv_cdate date;
  declare lv_fdate "$ABAP.type( fis_budat_from )";
  declare lv_tdate "$ABAP.type( fis_budat_to )";


* Get all G/L data
 lt_gldata = select distinct
session_context('CLIENT') as Client,
     _gl.ledger,
     _gl.CompanyCode,
     _gl.FiscalYear,
     _gl.GlAccount,
    sum(_gl.amountincompanycodecurrency)  as AmountInCC,
     _gl.CompanyCodeCurrency as CurrencyInCC,
     _gl.Partnercompany as TradingPartner,
     Concat( _gl.ledger, _gl.FiscalYear ) as LedgerYear
     from I_GLAccountLineItem
     as _gl
     where ( _gl.FiscalYear = :p_year or _gl.FiscalYear = :p_year - 1 )
      and  _gl.GlAccount in ( select nodevalue from zb_altgl_hier )
      and _gl.ledger in ( '0L', 'ZT', '2L ' )
   group by
               _gl.ledger,
               _gl.CompanyCode,
               _gl.FiscalYear,
               _gl.GlAccount,
               _gl.CompanyCodeCurrency,
               _gl.Partnercompany,
               Concat( _gl.ledger, _gl.FiscalYear );



* Getting G/L Text
 lt_return = SELECT DISTINCT
              session_context('CLIENT') as Client,
              LedgerYear as LedgerYear,
              CompanyCode,
              GlAccount,
              AmountInCC,
              CurrencyInCC,
              TradingPartner,

              _skat.txt20     as GLAccDesc,
              _ntxt.nodetxt as NodeTxt
       from :lt_gldata as _gl
        left outer join skat as _skat on _skat.mandt = _gl.Client
                                          and  _skat.spras = session_context('LOCALE_SAP')
                                             and _skat.saknr =  _gl.GlAccount
                                             and _skat.ktopl = 'PSUS'
        left outer join ZB_HIER_NODE_TEXT( 'H109/PSUS/ALT_GL' )
                        as _ntxt  on _ntxt.leafvalue = _gl.GlAccount;


       RETURN :lt_return;
ENDMETHOD.
ENDCLASS.
