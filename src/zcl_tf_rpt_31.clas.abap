CLASS zcl_tf_rpt_31 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt31 FOR TABLE FUNCTION ZTF_RPT_31.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_31 IMPLEMENTATION.

 METHOD get_rpt31
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  P_CnsldtnGroupJrnlEntrItm ztrpt_fi_mstr.
*    skat ska1 .
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

**********RPT32***************
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

lt_gldata1 = select distinct
     _MSTR.mainnode,
     _MSTR.subnode,
     _cl.ConsolidationLedger as Ledger,
     _cl.CompanyCode,
     _cl.GlAccount,
     _cl.CnsldtnGroupJrnlEntry as Accountingdocument,
     _cl.CnsldtnGroupJrnlEntryItem as LedgerGLLineItem,
     _cl.ProfitCenter,
    _cl.PostingDate,
    _cl.AmountInLocalCurrency as amountincompanycodecurrency,
    _cl.LocalCurrency as CurrencyInCC,
       CASE when concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) >= lv_cqtrfrom and
                    concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) <= lv_cqtrto
              then _cl.AmountInLocalCurrency     end as CQTR,
      CASE when concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) >= lv_cqtrPYfrom and
                    concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) <= lv_cqtrPYto
              then _cl.AmountInLocalCurrency     end as CQTRPY,
     CASE when concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) >= lv_cyfrom and
                    concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) <= lv_cyto
              then _cl.AmountInLocalCurrency     end as CY,
     CASE when concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) >= lv_py1from and
                    concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) <= lv_pyto
              then _cl.AmountInLocalCurrency     end as PY,
    CASE when concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) >= lv_py1from and
                    concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) <= lv_py1to
              then _cl.AmountInLocalCurrency     end as PY1,
    CASE when concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) >= lv_py2from and
                    concat(_cl.fiscalyear , concat( substring(_cl.fiscalPeriod, 2,2), '01' ) ) <= lv_py2to
              then _cl.AmountInLocalCurrency     end as PY2


      from ztrpt_fi_mstr as _mstr
      inner join P_CnsldtnGroupJrnlEntrItm  as _cl   on _cl.CnsldtnFinancialStatementItem
                                            between _MSTR.docfrom and _MSTR.docto
                                     and ( _cl.fiscalyear = lv_year OR
                                           _cl.fiscalyear = lv_year - 1 OR
                                           _cl.fiscalyear = lv_year  - 2 )
    where _mstr.mandt = session_context('CLIENT')
      and _MSTR.rptid           = 'RPT31';




 lt_gldatasum =
  select Mainnode,
         Subnode,
         Ledger,
         CompanyCode,
         GlAccount,
         ProfitCenter,
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
          ProfitCenter,
          CurrencyInCC;


  lt_final = SELECT
       session_context('CLIENT') as Client,
       _gl.*
     from :lt_gldatasum
     as _gl;

 lt_return = SELECT
              _gl.*,
              ''     as GLAccDesc
       from :lt_final as _gl;

       RETURN :lt_return;
ENDMETHOD.
ENDCLASS.
