CLASS zcl_tf_rpt_87 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_amdp_marker_hdb.
  CLASS-METHODS get_rpt87 FOR TABLE FUNCTION ZTF_RPT_87.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_87 IMPLEMENTATION.


METHOD get_rpt87
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  acdoca cepc skb1 skat cepct t247 ZTRPT_FI_MSTR .
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

  IF lv_qtr = 'Q1'     then lv_month_to = '03' ;
  ELSEIF lv_qtr = 'Q2' then lv_month_to = '06';
  ELSEIF lv_qtr = 'Q3' then lv_month_to = '09';
  ELSEIF lv_qtr = 'Q4' then lv_month_to = '12';
  END if;
  IF lv_qtr = 'Q1'     then lv_month_from = '01' ;
  ELSEIF lv_qtr = 'Q2' then lv_month_from = '04';
  ELSEIF lv_qtr = 'Q3' then lv_month_from = '07';
  ELSEIF lv_qtr = 'Q4' then lv_month_from = '10';
  END if;
  IF lv_qtr = 'Q1'     then lv_date = '31' ;
  ELSEIF lv_qtr = 'Q2' then lv_date = '30';
  ELSEIF lv_qtr = 'Q3' then lv_date = '30';
  ELSEIF lv_qtr = 'Q4' then lv_date = '31';

  END if;
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

 lt_gldata1 = SELECT
 d.rptid,
  a.rbukrs,
  a.rldnr,
  a.gjahr,
  a.racct,
  a.lokkt,
  a.fiscyearper,
  a.blart,
  a.prctr,

  a.segment,
  a.rhcur,
  _cepc.regio,
  _cepc.anred,
  _cepct.ltext,
  concat( concat( _m.mnr ,_m.ktx) , concat( '-', year ( a.budat)) ) as Period,
  a.hsl
        from ztrpt_fi_mstr as d left outer join acdoca as a on d.docfrom = a.racct and d.zfield = a.lokkt
  and a.rclnt = session_context('CLIENT')
       LEFT OUTER join skb1   as _skb1 ON _SKb1.mandt = session_context('CLIENT')
                             and _skb1.saknr = a.racct
                             and _skb1.bukrs = a.rbukrs
  inner join            cepc  as _cepc on _cepc.mandt = session_context('CLIENT')
                                       and  _cepc.prctr = a.prctr
  left outer join cepct  as _CEPCt on _CEPCt.mandt = session_context('CLIENT')
                                       and  _CEPCt.prctr = a.prctr
                                       and _cepct.spras = 'EN'
  left outer join t247 as _m ON    _m.mnr = substring(a.budat, 5, 2)
                                and _m.spras = 'E'
  where
         a.rldnr = '0L' and a.budat between lv_cyfrom and lv_cyto
         and d.mandt = session_context('CLIENT')
         AND (d.rptid = 'RPT87' OR d.rptid = 'RPT70') AND a.ktopl = 'PSUS' ;



******************************************************************************
  lt_gldatasum =
  SELECT
  rptid AS Report,
  rbukrs AS CompanyCode,
  rldnr AS Ledger,
  gjahr AS Year,
  racct AS Account,
  lokkt AS AlternativeACC,
  fiscyearper AS FiscalPeriod,
  blart AS DocType,
  prctr AS ProfitCenter,
  segment AS Segment,
  rhcur AS CompanyCodeCurrency,
  regio AS Region,
*LTEXT as LongText,
  anred AS Title,
  ltext AS LongText,
  period,
  SUM(hsl) AS AmountinCC
   FROM :lt_gldata1 AS _gl
   GROUP BY rptid,rbukrs,
  rldnr,
  gjahr,
  racct,
  lokkt,
  fiscyearper,
  blart,
  prctr,
  segment,
  rhcur,
  regio,
  anred,
  ltext,
  period;
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
