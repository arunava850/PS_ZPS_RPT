CLASS zclrpt_97t DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.

  CLASS-METHODS get_rpt97t FOR TABLE FUNCTION ZTF_RPT_97t.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclrpt_97t IMPLEMENTATION.

METHOD get_rpt97t
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  ztrpt_fi_mstr
    skat  cepc  ZI_STAT_DERIV_PDATE ZB_SS_PROFCTR_HIER ZB_2_RPT_0039.
  declare lv_year char( 4 );
  declare lv_qtryear char( 6 );
  declare lv_qtr char( 2 );
  declare lv_date char( 2 );
  declare lv_month char( 2 );
  declare lv_month_to char( 2 );
  declare lv_month_from char( 2 );
  declare lv_cdate date;
  declare lv_fdate "$ABAP.type( fis_budat_from )";
  declare lv_tdate "$ABAP.type( fis_budat_to )";
  declare lv_cqtrfrom "$ABAP.type( fis_budat_from )";
  declare lv_cqtrto "$ABAP.type( fis_budat_to )";
  declare lv_cqtrPYfrom "$ABAP.type( fis_budat_from )";
  declare lv_cqtrPYto "$ABAP.type( fis_budat_to )";
  declare lv_cyfrom "$ABAP.type( fis_budat_from )";
  declare lv_cyto "$ABAP.type( fis_budat_to )";
  declare lv_pyfrom "$ABAP.type( fis_budat_from )";
  declare lv_pyto "$ABAP.type( fis_budat_to )";
  declare lv_py1from "$ABAP.type( fis_budat_from )";
  declare lv_py1to "$ABAP.type( fis_budat_to )";
  declare lv_py2from "$ABAP.type( fis_budat_from )";
  declare lv_py2to "$ABAP.type( fis_budat_to )";

**********RPT97***************
  lv_qtr = p_qtr;
  lv_year = p_year;
  SELECT current_date INTO lv_cdate FROM dummy;

  if lv_qtr = 'Q1'     then lv_month_to = '03' ;
  elseif lv_qtr = 'Q2' then lv_month_to = '06';
  elseif lv_qtr = 'Q3' then lv_month_to = '09';
  elseif lv_qtr = 'Q4' then lv_month_to = '12';
  end if;
  if lv_qtr = 'Q1'     then lv_month_from = '01' ;
  elseif lv_qtr = 'Q2' then lv_month_from = '04';
  elseif lv_qtr = 'Q3' then lv_month_from = '07';
  elseif lv_qtr = 'Q4' then lv_month_from = '10';
  end if;
  if lv_qtr = 'Q1'     then lv_date = '31' ;
  elseif lv_qtr = 'Q2' then lv_date = '30';
  elseif lv_qtr = 'Q3' then lv_date = '30';
  elseif lv_qtr = 'Q4' then lv_date = '31';
  end if;
  lv_fdate = concat(lv_year-2, concat( '01' , '01' ) );
  lv_tdate = concat(lv_year, concat( lv_month_to, lv_date ) );

* Qtr Comparison
 lv_cqtrfrom = concat(lv_year, concat( lv_month_from, '01' ) );
 lv_cqtrto =   concat(lv_year, concat( lv_month_to, lv_date ) );

 lv_cqtrPYfrom = concat(lv_year - 1 , concat( lv_month_from, '01' ) );
 lv_cqtrPYto =   concat(lv_year - 1 , concat( lv_month_to, lv_date ) );

* Year Comparison
 lv_cyfrom = concat(lv_year, concat( '01', '01' ) );
 lv_cyto =   concat(lv_year, concat( lv_month_to, lv_date ) );

 lv_pyfrom = concat(lv_year - 1 , concat( '01', '01' ) );
 lv_pyto =   concat(lv_year - 1 , concat( lv_month_to, lv_date ) );

* Previous Year Comparison
 lv_py1from = concat(lv_year - 1 , concat( '01', '01' ) );
 lv_py1to =   concat(lv_year - 1 , concat( '12', '31' ) );

 lv_py2from =  concat(lv_year - 2 , concat( '01', '01' ) );
 lv_py2to =   concat(lv_year - 2 , concat( '12', '31' ) );


****************************************** NEW CODE CHANGES 31032024 *******************************************
lt_gldata1 =
*select distinct
*     _MSTR.mainnode,
*     _MSTR.subnode,
*     _gl.ledger,
*     _gl.CompanyCode,
*     _gl.GlAccount,
*     _gl.accountingdocument,
*     _gl.LedgerGLLineItem,
*     _SKA1.bilkt                    as GLAccountGroup,
*     _gl.ProfitCenter,
*    _gl.PostingDate,
*    _gl.amountincompanycodecurrency,
*    _gl.CompanyCodeCurrency as CurrencyInCC,
*    _CEPC.Segment,
*      h1.Facilities,
*    h1.NodeValue as NodeValue,
*    h1.Storage,
*    h1.Location,
*   cast( 1 as INT ) as NoOfFacility,
*       CASE when  _gl.postingdate >= lv_cqtrfrom and
*                    _gl.postingdate <= lv_cqtrto
*              then amountincompanycodecurrency     end as CQTR  ,
*         CASE when  _gl.postingdate >= lv_cqtrPYfrom and
*                    _gl.postingdate <= lv_cqtrPYto
*              then amountincompanycodecurrency end as CQTRPY,
*         CASE when  _gl.postingdate >= lv_cyfrom and
*                    _gl.postingdate <= lv_cyto
*              then amountincompanycodecurrency end as CY,
*         CASE when  _gl.postingdate >= lv_pyfrom and
*                    _gl.postingdate <= lv_pyto
*              then amountincompanycodecurrency end as PY,
*          CASE when  _gl.postingdate >= lv_py1from and
*                    _gl.postingdate <= lv_py1to
*              then amountincompanycodecurrency end as PY1,
*         CASE when  _gl.postingdate >= lv_py2from and
*                    _gl.postingdate <= lv_py2to
*              then amountincompanycodecurrency end as PY2
*      from ztrpt_fi_mstr as _mstr
*           inner join ska1   as _SKA1 on _SKA1.bilkt BETWEEN  _MSTR.docfrom AND _MSTR.docto
*                                      and _SKA1.mandt = session_context('CLIENT')
*
*      inner join ZB_SS_PROFCTR_HIER as _phier on _phier.HierarchyClass = 'PSCO'
*      inner join            cepc  as _CEPC on _CEPC.mandt = session_context('CLIENT')
*                                           and  _CEPC.prctr = _phier.NodeValue
*                                           and _CEPC.segment = 'PS_STORAGE'
*      inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _SKA1.saknr
*                                     and _gl.postingdate between lv_fdate and lv_tdate
*                                     and _gl.profitCenter = _CEPC.prctr
*      inner join ZB_2_RPT_0039 as h1 on _CEPC.prctr = h1.NodeValue
*    where
*     _mstr.mandt = session_context('CLIENT')
*
*  and  _MSTR.rptid           = 'RPT97'
*  and  _gl.Ledger            = '0L'
*
*  UNION
 select distinct
*     _MSTR.mainnode,
*     _MSTR.subnode,
*     '0L'  as ledger,
*     _stat.Rbukrs AS CompanyCode,
     _stat.Stagr AS GlAccount,
*     '' AS accountingdocument,
*     '' AS LedgerGLLineItem,
*     _stat.Stagr                    as GLAccountGroup,
     _stat.Prctr AS ProfitCenter,
*    _stat.PostingDate  AS PostingDate,
*    _stat.MSL  AS amountincompanycodecurrency,
*    'USD' as CurrencyInCC,
*    _CEPC.Segment,
*    h1.Facilities,
*    h1.NodeValue as NodeValue,
*    h1.Storage,
    h1.Location,
   cast( 1 as INT ) as NoOfFacility
*       CASE when  _stat.postingdate >= lv_cqtrfrom and
*                    _stat.postingdate <= lv_cqtrto
*              then _stat.MSL     end as CQTR  ,
*         CASE when  _stat.postingdate >= lv_cqtrPYfrom and
*                    _stat.postingdate <= lv_cqtrPYto
*              then _stat.MSL end as CQTRPY,
*         CASE when  _stat.postingdate >= lv_cyfrom and
*                    _stat.postingdate <= lv_cyto
*              then _stat.MSL end as CY,
*         CASE when  _stat.postingdate >= lv_pyfrom and
*                    _stat.postingdate <= lv_pyto
*              then _stat.MSL end as PY,
*          CASE when  _stat.postingdate >= lv_py1from and
*                    _stat.postingdate <= lv_py1to
*              then _stat.MSL end as PY1,
*         CASE when  _stat.postingdate >= lv_py2from and
*                    _stat.postingdate <= lv_py2to
*              then _stat.MSL end as PY2
      from ztrpt_fi_mstr as _mstr

     inner join      ZI_STAT_DERIV_PDATE      as _stat  on  _stat.Stagr   =    _MSTR.docfrom
                                              and _stat.PostingDate between lv_fdate and lv_tdate
                                               and _MSTR.docfrom like '9%'
      inner join      ZB_SS_PROFCTR_HIER as _phier on _phier.HierarchyClass = 'PSCO'
                                                   and _phier.nodevalue = _stat.prctr
     inner join      cepc               as _CEPC  on  _CEPC.prctr   = _stat.prctr
                                                 and _CEPC.segment = 'PS_STORAGE'
                                                  and _CEPC.mandt = session_context('CLIENT')
     inner join ZB_2_RPT_0039 as h1 on _CEPC.prctr = h1.NodeValue
    where
     _mstr.mandt = session_context('CLIENT')
     and _stat.mandt = session_context('CLIENT')

  and  _MSTR.rptid           = 'RPT97';
******************************************************************************
 lt_gldatasum =
  select
*  Mainnode,
*         Subnode,
*         Ledger,
*         CompanyCode,
         GlAccount,
*        GLAccountGroup,
         ProfitCenter,
*         POSTINGDATE,
*         Segment,
         Location,
         sum( NoOfFacility ) as NoOfFacility
*         SUM(amountincompanycodecurrency) as AmountinCC,
*         CurrencyInCC,
*         SUM(_gl.CQtr) as CQtr,
*         SUM(_gl.CQtrPY) as CQtrPY ,
*         SUM(_gl.CY) as CY,
*         SUM(_gl.PY) as  PY,
*         SUM(_gl.PY1) as PY1,
*         SUM(_gl.py2) as py2

 from :lt_gldata1 as _gl
 GROUP BY
*  Mainnode,
*          Subnode,
*          Ledger,
*          CompanyCode,
          GlAccount,
*        GLAccountGroup,
          ProfitCenter,
*          postingdate,
*          Segment,
          Location
*          CurrencyInCC
          ;


  lt_final = SELECT
       session_context('CLIENT') as Client,

       _gl.*
     from :lt_gldatasum
     as _gl  ;

 lt_return = SELECT
              _gl.*,
              _skat.txt20     as GLAccDesc
       from :lt_final as _gl
        left outer join skat as _skat on _skat.mandt = _gl.Client
                                          and  _skat.spras = session_context('LOCALE_SAP')
                                             and _skat.saknr =  _gl.GlAccount
                                             and _skat.ktopl = 'PSUS';

       RETURN :lt_return;
ENDMETHOD.

ENDCLASS.
