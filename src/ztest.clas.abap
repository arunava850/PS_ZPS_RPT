
CLASS ztest DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_amdp_marker_hdb.
  CLASS-METHODS get_rpt87t FOR TABLE FUNCTION ZTests87.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ztest IMPLEMENTATION.


METHOD get_rpt87t
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  acdoca   skat   ZTRPT_FI_MSTR .
*skb1 cepct t247 cepc.
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

**********RPT87***************
  lv_qtr = 'Q4';
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

lt_gldata1 = select
D.RPTID,
a.rbukrs,
A.RLDNR,
A.GJAHR,
A.RACCT,
A.LOKKT,
A.FISCYEARPER,
a.blart,
a.prctr,

a.segment,
a.RHCUR,
**_CEPC.REGIO,
*_CEPC.LTEXT,
**_CEPC.ANRED,
*_cepct.ltext,
*concat( MONTHNAME (a.budat), concat( '-', YEAR ( a.budat)) ) as Period,
*concat( CONCAT( _M.MNR ,_M.ktx) , concat( '-', YEAR ( a.budat)) ) as Period,
*MONTHNAME (a.budat) as Month,
*YEAR ( a.budat) as year,
a.hsl
      from ZTRPT_FI_MSTR AS D INNER JOIN ACDOCA as A ON D.docfrom = A.racct AND D.zfield = A.LOKKT
*           LEFT OUTER join skb1   as _SKB1 on _SKb1.mandt = session_context('CLIENT')
*                                      and _SKB1.saknr = A.racct
*                                      and _SKB1.bukrs = A.rbukrs

*      inner join            cepc  as _CEPC on _CEPC.mandt = session_context('CLIENT')
*                                           and  _CEPC.prctr = A.prctr
*      LEFT OUTER JOIN cepct  as _CEPCt on _CEPCt.mandt = session_context('CLIENT')
*                                           and  _CEPCt.prctr = A.prctr
*                                           and _cepct.spras = 'EN'
*      left outer join t247 as _M on    _M.mnr = substring(a.budat, 5, 2)
*                                     and _M.spras = 'E'
    where

   A.rldnr           = '0L' and A.budat between lv_cyfrom and lv_cyto
*   and (a.racct = '0000210050' or a.racct = '0000210060')
   AND (D.rptid = 'RPT87' OR D.rptid = 'RPT70') AND A.KTOPL = 'PSUS' ;



******************************************************************************
 lt_gldatasum =
  select
  RPTID as Report,
   rbukrs as CompanyCode,
RLDNR as Ledger,
GJAHR as Year,
RACCT as Account,
LOKKT as AlternativeACC,
FISCYEARPER as FiscalPeriod,
blart as DocType,
prctr as ProfitCenter,
segment as Segment,
RHCUR as CompanyCodeCurrency,
*REGIO as Region,
**LTEXT as LongText,
*ANRED as Title,
*ltext as LongText,
*period,
SUM(hsl) as AmountinCC
 from :lt_gldata1 as _gl
 GROUP BY rptid,rbukrs,
RLDNR,
GJAHR,
RACCT,
LOKKT,
FISCYEARPER,
blart,
prctr,
segment,
RHCUR
*REGIO,
*ANRED
*LTEXT,
*period
;


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
                                             and _skat.saknr =  _gl.Account
                                             and _skat.ktopl = 'PSUS';

       RETURN :lt_return;
ENDMETHOD.
ENDCLASS.
