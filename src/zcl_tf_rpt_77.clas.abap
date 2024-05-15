CLASS zcl_tf_rpt_77 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_amdp_marker_hdb.
  CLASS-METHODS get_rpt77 FOR TABLE FUNCTION ZTF_RPT_77.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_77 IMPLEMENTATION.

METHOD get_rpt77
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  I_GLAccountLineItem ztrpt_fi_mstr
    skat ska1 ZB_SS_PC_HIER_77 cepc
    .
  declare lv_year char( 4 );
  declare lv_qtryear char( 6 );
  declare lv_qtr char( 2 );
  declare lv_VAR char( 1 );
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

**********RPT77***************
  lv_qtr = p_qtr;
  lv_year = p_year;
  lv_VAR = 'A';
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

lt_gldata1 = select distinct
     _MSTR.mainnode,
     _MSTR.subnode,
     _gl.ledger,
     _gl.CompanyCode,
     _gl.GlAccount,
     _gl.accountingdocument,
     _gl.LedgerGLLineItem,
     _SKA1.bilkt                    as GLAccountGroup,
     _gl.ProfitCenter,
    _gl.PostingDate,
    _gl.amountincompanycodecurrency,
    _gl.CompanyCodeCurrency as CurrencyInCC,
    _gl.segment AS Segment,
    _phier.HierarchyParentNode AS NODE,
       CASE when  _gl.postingdate >= lv_cqtrfrom and
                    _gl.postingdate <= lv_cqtrto
              then amountincompanycodecurrency     end as CQTR  ,
         CASE when  _gl.postingdate >= lv_cqtrPYfrom and
                    _gl.postingdate <= lv_cqtrPYto
              then amountincompanycodecurrency end as CQTRPY,
         CASE when  _gl.postingdate >= lv_cyfrom and
                    _gl.postingdate <= lv_cyto
              then amountincompanycodecurrency end as CY,
         CASE when  _gl.postingdate >= lv_pyfrom and
                    _gl.postingdate <= lv_pyto
              then amountincompanycodecurrency end as PY,
          CASE when  _gl.postingdate >= lv_py1from and
                    _gl.postingdate <= lv_py1to
              then amountincompanycodecurrency end as PY1,
         CASE when  _gl.postingdate >= lv_py2from and
                    _gl.postingdate <= lv_py2to
              then amountincompanycodecurrency end as PY2
      from ztrpt_fi_mstr as _mstr
      left outer join ZB_SS_PC_HIER_77 as _phier on _phier.HierarchyClass = 'PSCO'
                                 and _phier.HierarchyParentNode = _mstr.zfield
           inner join ska1   as _SKA1 on _SKA1.mandt = session_context('CLIENT') and _SKA1.bilkt between _MSTR.docfrom and _MSTR.docto
           inner join cepc   as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
                                       and _cepc.mandt = session_context('CLIENT')
           inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _SKA1.saknr
                                     and _gl.postingdate between lv_fdate and lv_tdate
                                     and _gl.profitcenter = _CEPC.prctr
   where
_mstr.mandt = session_context('CLIENT') and
 _MSTR.rptid           = 'RPT771' and _MSTR.counter BETWEEN '1' and '7'
 and  _gl.Ledger       = '0L'


UNION

select distinct
     _MSTR.mainnode,
     _MSTR.subnode,
     _gl.ledger,
     _gl.CompanyCode,
     _gl.GlAccount,
     _gl.accountingdocument,
     _gl.LedgerGLLineItem,
     _SKA1.bilkt                    as GLAccountGroup,
     _gl.ProfitCenter,
    _gl.PostingDate,
    _gl.amountincompanycodecurrency,
    _gl.CompanyCodeCurrency as CurrencyInCC,
    _gl.segment AS Segment,
    _phier.HierarchyParentNode AS NODE,
       CASE when  _gl.postingdate >= lv_cqtrfrom and
                    _gl.postingdate <= lv_cqtrto
              then amountincompanycodecurrency     end as CQTR  ,
         CASE when  _gl.postingdate >= lv_cqtrPYfrom and
                    _gl.postingdate <= lv_cqtrPYto
              then amountincompanycodecurrency end as CQTRPY,
         CASE when  _gl.postingdate >= lv_cyfrom and
                    _gl.postingdate <= lv_cyto
              then amountincompanycodecurrency end as CY,
         CASE when  _gl.postingdate >= lv_pyfrom and
                    _gl.postingdate <= lv_pyto
              then amountincompanycodecurrency end as PY,
          CASE when  _gl.postingdate >= lv_py1from and
                    _gl.postingdate <= lv_py1to
              then amountincompanycodecurrency end as PY1,
         CASE when  _gl.postingdate >= lv_py2from and
                    _gl.postingdate <= lv_py2to
              then amountincompanycodecurrency end as PY2
      from ztrpt_fi_mstr as _mstr
      LEFT OUTER join ZB_SS_PC_HIER_77 as _phier on _phier.HierarchyClass = 'PSCO'

           inner join ska1   as _SKA1 on _SKA1.mandt = session_context('CLIENT') and _SKA1.bilkt between _MSTR.docfrom and _MSTR.docto
           inner join cepc   as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
                                       and _cepc.mandt = session_context('CLIENT')
*           AND _cepc.PRCTR = _mstr.zfield
           inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _SKA1.saknr
                                     and _gl.postingdate between lv_fdate and lv_tdate
                                     and _gl.profitcenter = _mstr.zfield


   where
_mstr.mandt = session_context('CLIENT') and
 _MSTR.rptid           = 'RPT771' and _MSTR.counter BETWEEN '8' and '10'
 and  _gl.Ledger       = '0L'



 union

 select distinct
     _MSTR.mainnode,
     _MSTR.subnode,
     _gl.ledger,
     _gl.CompanyCode,
     _gl.GlAccount,
     _gl.accountingdocument,
     _gl.LedgerGLLineItem,
     _SKA1.bilkt                    as GLAccountGroup,
     _gl.ProfitCenter,
    _gl.PostingDate,
    _gl.amountincompanycodecurrency,
    _gl.CompanyCodeCurrency as CurrencyInCC,
    _gl.segment AS Segment,
    _phier.HierarchyParentNode AS NODE,
       CASE when  _gl.postingdate >= lv_cqtrfrom and
                    _gl.postingdate <= lv_cqtrto
              then amountincompanycodecurrency     end as CQTR  ,
         CASE when  _gl.postingdate >= lv_cqtrPYfrom and
                    _gl.postingdate <= lv_cqtrPYto
              then amountincompanycodecurrency end as CQTRPY,
         CASE when  _gl.postingdate >= lv_cyfrom and
                    _gl.postingdate <= lv_cyto
              then amountincompanycodecurrency end as CY,
         CASE when  _gl.postingdate >= lv_pyfrom and
                    _gl.postingdate <= lv_pyto
              then amountincompanycodecurrency end as PY,
          CASE when  _gl.postingdate >= lv_py1from and
                    _gl.postingdate <= lv_py1to
              then amountincompanycodecurrency end as PY1,
         CASE when  _gl.postingdate >= lv_py2from and
                    _gl.postingdate <= lv_py2to
              then amountincompanycodecurrency end as PY2
      from ztrpt_fi_mstr as _mstr
      left outer join ZB_SS_PC_HIER_77 as _phier on _phier.HierarchyClass = 'PSCO'
                                 and _phier.HierarchyParentNode = _mstr.zfield
           inner join ska1   as _SKA1 on _SKA1.mandt = session_context('CLIENT') and _SKA1.bilkt between _MSTR.docfrom and _MSTR.docto
           inner join cepc   as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
                                           and _cepc.mandt = session_context('CLIENT')
           inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _SKA1.saknr
                                     and _gl.postingdate between lv_fdate and lv_tdate
                                     and _gl.profitcenter = _CEPC.prctr
   where
_mstr.mandt = session_context('CLIENT') and
 _MSTR.rptid           = 'RPT771' and _MSTR.counter BETWEEN '11' and '17'
 and  _gl.Ledger       = '0L'


UNION

select distinct
     _MSTR.mainnode,
     _MSTR.subnode,
     _gl.ledger,
     _gl.CompanyCode,
     _gl.GlAccount,
     _gl.accountingdocument,
     _gl.LedgerGLLineItem,
     _SKA1.bilkt                    as GLAccountGroup,
     _gl.ProfitCenter,
    _gl.PostingDate,
    _gl.amountincompanycodecurrency,
    _gl.CompanyCodeCurrency as CurrencyInCC,
    _gl.segment AS Segment,
    _phier.HierarchyParentNode AS NODE,
       CASE when  _gl.postingdate >= lv_cqtrfrom and
                    _gl.postingdate <= lv_cqtrto
              then amountincompanycodecurrency     end as CQTR  ,
         CASE when  _gl.postingdate >= lv_cqtrPYfrom and
                    _gl.postingdate <= lv_cqtrPYto
              then amountincompanycodecurrency end as CQTRPY,
         CASE when  _gl.postingdate >= lv_cyfrom and
                    _gl.postingdate <= lv_cyto
              then amountincompanycodecurrency end as CY,
         CASE when  _gl.postingdate >= lv_pyfrom and
                    _gl.postingdate <= lv_pyto
              then amountincompanycodecurrency end as PY,
          CASE when  _gl.postingdate >= lv_py1from and
                    _gl.postingdate <= lv_py1to
              then amountincompanycodecurrency end as PY1,
         CASE when  _gl.postingdate >= lv_py2from and
                    _gl.postingdate <= lv_py2to
              then amountincompanycodecurrency end as PY2
      from ztrpt_fi_mstr as _mstr
      LEFT OUTER join ZB_SS_PC_HIER_77 as _phier on _phier.HierarchyClass = 'PSCO'

           inner join ska1   as _SKA1 on _SKA1.mandt = session_context('CLIENT') and _SKA1.bilkt between _MSTR.docfrom and _MSTR.docto
           inner join cepc   as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
                                         and _cepc.mandt = session_context('CLIENT')
*           AND _cepc.PRCTR = _mstr.zfield
           inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _SKA1.saknr
                                     and _gl.postingdate between lv_fdate and lv_tdate
                                     and _gl.profitcenter = _mstr.zfield


   where
_mstr.mandt = session_context('CLIENT') and
 _MSTR.rptid           = 'RPT771' and _MSTR.counter BETWEEN '18' and '20'
 and  _gl.Ledger       = '0L'

 ;


 lt_gldatasum =
  select Mainnode,
         Subnode,
         Ledger,
         CompanyCode,
         GlAccount,
         GLAccountGroup,
         ProfitCenter,
         Segment,
         NODE,
         SUM(amountincompanycodecurrency) as AmountinCC,
         CurrencyInCC,
         SUM(_gl.CQtr) as CQtr,
         SUM(_gl.CQtrPY) as CQtrPY ,
         SUM(_gl.CY) as CY,
         SUM(_gl.PY) as  PY,
         SUM(_gl.PY1) as PY1,
         SUM(_gl.py2) as py2
 from :lt_gldata1 as _gl
 GROUP BY Mainnode,
          Subnode,
          Ledger,
          CompanyCode,
          GlAccount,
          GLAccountGroup,
          ProfitCenter,
          Segment,
          NODE,
          CurrencyInCC;


  lt_final = SELECT
       session_context('CLIENT') as Client,
       _gl.*
     from :lt_gldatasum
     as _gl;

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
