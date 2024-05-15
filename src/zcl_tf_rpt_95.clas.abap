CLASS zcl_tf_rpt_95 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_amdp_marker_hdb.
  CLASS-METHODS get_rpt95 FOR TABLE FUNCTION ZTF_RPT95.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_tf_rpt_95 IMPLEMENTATION.
METHOD get_rpt95
  BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING
          ZB_2_RPT_0095
          I_glAccountLineItem
*          ztrpt_fi_mstr
          ZI_STAT_DERIV_PDATE
          cepc
          skat
          ska1
   .
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

  lv_qtr = p_qtr;
  lv_year = p_year;
  SELECT current_date INTO lv_cdate FROM dummy;

  if     lv_qtr = 'Q1' then lv_month_to = '03' ;
  elseif lv_qtr = 'Q2' then lv_month_to = '06' ;
  elseif lv_qtr = 'Q3' then lv_month_to = '09' ;
  elseif lv_qtr = 'Q4' then lv_month_to = '12' ;
  end if ;
  if     lv_qtr = 'Q1' then lv_month_from = '01' ;
  elseif lv_qtr = 'Q2' then lv_month_from = '04' ;
  elseif lv_qtr = 'Q3' then lv_month_from = '07' ;
  elseif lv_qtr = 'Q4' then lv_month_from = '10' ;
  end if ;
  if     lv_qtr = 'Q1' then lv_date = '31' ;
  elseif lv_qtr = 'Q2' then lv_date = '30' ;
  elseif lv_qtr = 'Q3' then lv_date = '30' ;
  elseif lv_qtr = 'Q4' then lv_date = '31' ;
  end if ;
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

 lt_glitemdata1 = select distinct
     _phier.HierarchyParentNode,
     _phier.Facilities,
     _phier.NodeValue,
     _glitem.ledger,
     _glitem.CompanyCode,
     _glitem.GlAccount,
     _glitem.accountingdocument,
     _glitem.LedgerGLLineItem,
     _SKA1.bilkt                    as GLAccountGroup,
     _glitem.ProfitCenter,
    _glitem.PostingDate,
    _glitem.amountincompanycodecurrency,
    _glitem.CompanyCodeCurrency as CurrencyInCC,
    '' AS Segment,

       CASE when  _glitem.postingdate >= lv_cqtrfrom and
                    _glitem.postingdate <= lv_cqtrto
              then amountincompanycodecurrency     end as CQTR  ,
         CASE when  _glitem.postingdate >= lv_cqtrPYfrom and
                    _glitem.postingdate <= lv_cqtrPYto
              then amountincompanycodecurrency end as CQTRPY,
         CASE when  _glitem.postingdate >= lv_cyfrom and
                    _glitem.postingdate <= lv_cyto
              then amountincompanycodecurrency end as CY,
         CASE when  _glitem.postingdate >= lv_pyfrom and
                    _glitem.postingdate <= lv_pyto
              then amountincompanycodecurrency end as PY,
          CASE when  _glitem.postingdate >= lv_py1from and
                    _glitem.postingdate <= lv_py1to
              then amountincompanycodecurrency end as PY1,
         CASE when  _glitem.postingdate >= lv_py2from and
                    _glitem.postingdate <= lv_py2to
              then amountincompanycodecurrency end as PY2
*      from ztrpt_fi_mstr as _mstr
*           inner join ska1   as _SKA1 on _SKA1.mandt = _mstr.mandt and
*                                         _SKA1.bilkt between _MSTR.docfrom
*                                         and _MSTR.docto
*           inner join ZB_NSS_PROFCTR_HIER as _phier on _phier.HierarchyClass = 'PSCO'
*           inner join      cepc               as _CEPC  on  _cepc.mandt = session_context('CLIENT')
*                                               and  _CEPC.prctr   = _phier.NodeValue
*                                               and _CEPC.segment = 'PS_STORAGE'
*
*      inner join I_glitemAccountLineItem  as _glitem   on _glitem.GLAccount = _SKA1.saknr
*                                     and _glitem.postingdate between lv_fdate and lv_tdate
*                                     and substring(_glitem.postingdate,0,4) = _MSTR.zfield
*                                     and _glitem.profitCenter = _CEPC.prctr


     from ZB_2_RPT_0095 as _phier

          inner join      cepc           as _CEPC  on  _cepc.mandt = session_context('CLIENT')
                                               and  _CEPC.prctr   = _phier.NodeValue
                                               and _CEPC.segment = 'PS_STORAGE'

          inner join I_glAccountLineItem as _glitem on _glitem.postingdate between lv_fdate and lv_tdate
                                               and _phier.NodeValue = _glitem.ProfitCenter
                                               and _phier.HierarchyClass = 'PSCO'
                                               and _CEPC.prctr = _glitem.profitCenter
                                               and _glitem.Ledger            = '0L'

          inner join ska1  as _ska1   on _SKA1.saknr = _glitem.GLAccount

*    where
*      _phier.mandt = session_context('CLIENT')

*    and  _glitem.Ledger            = '0L'

******Stat logic
UNION
 select distinct
     _phier.HierarchyParentNode,
     _phier.Facilities,
     _phier.NodeValue,
     '0L'  as ledger,
     _stat.Rbukrs AS CompanyCode,
     '' AS GlAccount,
     '' AS accountingdocument,
     '' AS LedgerGLLineItem,
     _stat.Stagr                    as GLAccountGroup,
     _stat.Prctr AS ProfitCenter,
    ''  AS PostingDate,
    _stat.MSL  AS amountincompanycodecurrency,
    'USD' as CurrencyInCC,
    _CEPC.Segment,
       CASE when  _stat.postingdate >= lv_cqtrfrom and
                    _stat.postingdate <= lv_cqtrto
              then _stat.MSL     end as CQTR  ,
         CASE when  _stat.postingdate >= lv_cqtrPYfrom and
                    _stat.postingdate <= lv_cqtrPYto
              then _stat.MSL end as CQTRPY,
         CASE when  _stat.postingdate >= lv_cyfrom and
                    _stat.postingdate <= lv_cyto
              then _stat.MSL end as CY,
         CASE when  _stat.postingdate >= lv_pyfrom and
                    _stat.postingdate <= lv_pyto
              then _stat.MSL end as PY,
          CASE when  _stat.postingdate >= lv_py1from and
                    _stat.postingdate <= lv_py1to
              then _stat.MSL end as PY1,
         CASE when  _stat.postingdate >= lv_py2from and
                    _stat.postingdate <= lv_py2to
              then _stat.MSL end as PY2
*      from ztrpt_fi_mstr as _mstr
*     inner join      ZB_NSS_PROFCTR_HIER as _phier on _phier.HierarchyClass = 'PSCO'
*     inner join      cepc               as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
*                                                  and _CEPC.segment = 'PS_STORAGE'
*     inner join      ZI_STAT_DERIV_PDATE      as _stat  on  _stat.Stagr   =    _MSTR.docfrom
*                                               and _stat.Prctr   =    _CEPC.prctr
*                                               and _stat.PostingDate between lv_fdate and lv_tdate
*                                               and _MSTR.docfrom like '9%'

    from ZB_2_RPT_0095 as _phier

         inner join      cepc           as _CEPC  on  _cepc.mandt = session_context('CLIENT')
                                               and  _CEPC.prctr   = _phier.NodeValue
                                               and _CEPC.segment = 'PS_STORAGE'

         inner join     ZI_STAT_DERIV_PDATE as _stat on _stat.Prctr   =  _phier.NodeValue
                                               and _stat.PostingDate between lv_fdate and lv_tdate;



*    where
*    _stat.mandt = session_context('CLIENT');

******************************************************************************

 lt_glitemdatasum =
  select
         HierarchyParentNode,
         Facilities,
         NodeValue,
         Ledger,
         CompanyCode,
         GlAccount,
         GLAccountGroup,
         ProfitCenter,
         PostingDate,
         SUM(amountincompanycodecurrency) as AmountinCC,
         CurrencyInCC,
         Segment,
         SUM(_glitem.CQtr)      as CQtr,
         SUM(_glitem.CQtrPY)    as CQtrPY ,
         SUM(_glitem.CY)        as CY,
         SUM(_glitem.PY)        as  PY,
         SUM(_glitem.PY1)       as PY1,
         SUM(_glitem.py2)       as py2

 from :lt_glitemdata1 as _glitem
 GROUP BY
          HierarchyParentNode,
          Facilities,
          NodeValue,
          Ledger,
          CompanyCode,
          GlAccount,
          GLAccountGroup,
          ProfitCenter,
          PostingDate,
          amountincompanycodecurrency,
          CurrencyInCC,
          Segment;


  lt_final = SELECT
       session_context('CLIENT') as Client,
       _glitem.*
     from :lt_glitemdatasum
     as _glitem;

 lt_return = SELECT
              _glitem1.*,
              _skat.txt20     as GLAccDesc
       from :lt_final as _glitem1
        left outer join skat as _skat on _skat.mandt = _glitem1.Client
                                          and  _skat.spras = session_context('LOCALE_SAP')
                                             and _skat.saknr =  _glitem1.GlAccount
                                             and _skat.ktopl = 'PSUS';

       RETURN :lt_return;
ENDMETHOD.

ENDCLASS.
