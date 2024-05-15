CLASS zcl_tf_rpt_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
    CLASS-METHODS get_rpt12 FOR TABLE FUNCTION ztf_rpt_12.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_12 IMPLEMENTATION.

  METHOD get_rpt12
   BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
     USING  i_glaccountlineitem ztrpt_fi_mstr
      skat ska1 cepc zb_ss_nss_profctr_hier zi_stat_deriv_pdate  zi_stat_deriv_pdate_mo zb_ss_profctr_hier zb_nss_profctr_hier.

*      zi_stat_deriv_pdate
    declare lv_year char( 4 );
    declare lv_qtryear char( 6 );
    declare lv_qtr char( 2 );
    declare lv_date char( 2 );
    declare lv_date_c char( 2 );
    declare lv_month char( 2 );
    declare lv_month_c char( 2 );
    declare lv_month_to char( 2 );
    declare lv_month_from char( 2 );
    declare lv_leap int;

    declare lv_cdate date;
    declare lv_fdate "$ABAP.type( fis_budat_from )";
    declare lv_tdate "$ABAP.type( fis_budat_to )";
    declare lv_cqtrfrom "$ABAP.type( fis_budat_from )";
    declare lv_cqtrto "$ABAP.type( fis_budat_to )";
    declare lv_cqtrpyfrom "$ABAP.type( fis_budat_from )";
    declare lv_cqtrpyto "$ABAP.type( fis_budat_to )";
    declare lv_cyfrom "$ABAP.type( fis_budat_from )";
    declare lv_cyto "$ABAP.type( fis_budat_to )";
    declare lv_pyfrom "$ABAP.type( fis_budat_from )";
    declare lv_pyto "$ABAP.type( fis_budat_to )";
    declare lv_py1from "$ABAP.type( fis_budat_from )";
    declare lv_py1to "$ABAP.type( fis_budat_to )";
    declare lv_py2from "$ABAP.type( fis_budat_from )";
    declare lv_py2to "$ABAP.type( fis_budat_to )";
    declare lv_pch char( 1 );

**********RPT12***************


*    lv_qtr = p_qtr;
    lv_year = p_year;

    lv_month = p_month;
    IF lv_month = '01'     then lv_qtr = 'Q1';  lv_month_c = '01'; lv_date_c = '31'; lv_month_to = '01' ; lv_date = '31' ;
    ELSEIF lv_month = '02' then lv_qtr = 'Q1';  lv_month_c = '02'; lv_month_to = '02' ;

    lv_leap = mod(lv_year, 4);

    IF lv_leap = 0 then
    lv_date_c = '29';
    lv_date = '29' ;
    ELSE lv_date_c = '28';
    lv_date = '28' ;
    END if;

    ELSEIF lv_month = '03' then lv_qtr = 'Q1';  lv_month_c = '03'; lv_date_c = '31'; lv_month_to = '03' ; lv_date = '31' ;
    ELSEIF lv_month = '04' then lv_qtr = 'Q2';  lv_month_c = '04'; lv_date_c = '30'; lv_month_to = '04' ; lv_date = '30' ;
    ELSEIF lv_month = '05' then lv_qtr = 'Q2';  lv_month_c = '05'; lv_date_c = '31'; lv_month_to = '05' ; lv_date = '31' ;
    ELSEIF lv_month = '06' then lv_qtr = 'Q2';  lv_month_c = '06'; lv_date_c = '30'; lv_month_to = '06' ; lv_date = '30' ;
    ELSEIF lv_month = '07' then lv_qtr = 'Q3';  lv_month_c = '07'; lv_date_c = '31'; lv_month_to = '07' ; lv_date = '31' ;
    ELSEIF lv_month = '08' then lv_qtr = 'Q3';  lv_month_c = '08'; lv_date_c = '31'; lv_month_to = '08' ; lv_date = '31' ;
    ELSEIF lv_month = '09' then lv_qtr = 'Q3';  lv_month_c = '09'; lv_date_c = '30'; lv_month_to = '09' ; lv_date = '30' ;
    ELSEIF lv_month = '10' then lv_qtr = 'Q4'; lv_month_c = '10'; lv_date_c = '31'; lv_month_to = '10' ; lv_date = '31' ;
    ELSEIF lv_month = '11' then lv_qtr = 'Q4'; lv_month_c = '11'; lv_date_c = '30'; lv_month_to = '11' ; lv_date = '30' ;
    ELSEIF lv_month = '12' then lv_qtr = 'Q4'; lv_month_c = '12'; lv_date_c = '31'; lv_month_to = '12' ; lv_date = '31' ;
    END if;

    lv_pch = p_pch;
    SELECT current_date INTO lv_cdate FROM dummy;

*    IF lv_qtr = 'Q1'     then lv_month_to = '03' ;
*    ELSEIF lv_qtr = 'Q2' then lv_month_to = '06';
*    ELSEIF lv_qtr = 'Q3' then lv_month_to = '09';
*    ELSEIF lv_qtr = 'Q4' then lv_month_to = '12';
*    END if;
    IF lv_qtr = 'Q1'     then lv_month_from = '01' ;
    ELSEIF lv_qtr = 'Q2' then lv_month_from = '04';
    ELSEIF lv_qtr = 'Q3' then lv_month_from = '07';
    ELSEIF lv_qtr = 'Q4' then lv_month_from = '10';
    END if;
*    IF lv_qtr = 'Q1'     then lv_date = '31' ;
*    ELSEIF lv_qtr = 'Q2' then lv_date = '30';
*    ELSEIF lv_qtr = 'Q3' then lv_date = '30';
*    ELSEIF lv_qtr = 'Q4' then lv_date = '31';
*    END if;
    lv_fdate = concat(lv_year-2, concat( '01' , '01' ) );
    lv_tdate = concat(lv_year, concat( lv_month_to, lv_date ) );

* Qtr Comparison
   lv_cqtrfrom = concat(lv_year, concat( lv_month_from, '01' ) );
   lv_cqtrto =   concat(lv_year, concat( lv_month_to, lv_date ) );

   lv_cqtrpyfrom = concat(lv_year - 1 , concat( lv_month_from, '01' ) );
   lv_cqtrpyto =   concat(lv_year - 1 , concat( lv_month_to, lv_date ) );

* Year Comparison
   lv_cyfrom = concat(lv_year, concat( '01', '01' ) );
   lv_cyto =   concat(lv_year, concat( lv_month_to, lv_date ) );

   lv_pyfrom = concat(lv_year - 1 , concat( '01', '01' ) );
   lv_pyto =   concat(lv_year - 1 , concat( lv_month_to, lv_date ) );

* Previous Year Comparison
*   lv_py1from = concat(lv_year - 1 , concat( '01', '01' ) );
*   lv_py1to =   concat(lv_year - 1 , concat( '12', '31' ) );
*
*   lv_py2from =  concat(lv_year - 2 , concat( '01', '01' ) );
*   lv_py2to =   concat(lv_year - 2 , concat( '12', '31' ) );
* Month Comparison
   lv_py1from = concat(lv_year, concat( lv_month_c, '01' ) );
   lv_py1to =   concat(lv_year, concat( lv_month_c, lv_date_c ) );

   lv_py2from = concat(lv_year - 1 , concat( lv_month_c, '01' ) );
   lv_py2to =   concat(lv_year - 1 , concat( lv_month_c, lv_date_c ) );

  lt_gldata1 = SELECT DISTINCT
       _mstr.mainnode,
       _mstr.subnode,
       _gl.ledger,
       _gl.companycode,
       _gl.glaccount,
       _gl.accountingdocument,
       _gl.ledgergllineitem,
       _ska1.bilkt                    as glaccountgroup,
       _gl.profitcenter,
      _gl.postingdate,
      _gl.amountincompanycodecurrency,
      _gl.companycodecurrency as currencyincc,
      _cepc.segment,
         case when  _gl.postingdate >= lv_cqtrfrom and
                      _gl.postingdate <= lv_cqtrto
                then amountincompanycodecurrency     end as cqtr  ,
           case when  _gl.postingdate >= lv_cqtrpyfrom and
                      _gl.postingdate <= lv_cqtrpyto
                then amountincompanycodecurrency end as cqtrpy,
           case when  _gl.postingdate >= lv_cyfrom and
                      _gl.postingdate <= lv_cyto
                then amountincompanycodecurrency end as cy,
           case when  _gl.postingdate >= lv_pyfrom and
                      _gl.postingdate <= lv_pyto
                then amountincompanycodecurrency end as py,
            case when  _gl.postingdate >= lv_py1from and
                      _gl.postingdate <= lv_py1to
                then amountincompanycodecurrency end as py1,
           case when  _gl.postingdate >= lv_py2from and
                      _gl.postingdate <= lv_py2to
                then amountincompanycodecurrency end as py2
        from ztrpt_fi_mstr as _mstr
             inner join ska1   as _ska1 on _ska1.mandt = _mstr.mandt
                                        and _ska1.bilkt = _mstr.docfrom
                                        and _ska1.mandt = session_context('CLIENT')
*                                      and _MSTR.docto
        inner join zb_ss_nss_profctr_hier as _phier ON _phier.hierarchyclass = 'PSCO'
        inner join            cepc  as _cepc ON _cepc.mandt = session_context('CLIENT')
                                             and  _cepc.prctr = _phier.nodevalue
                                             and _cepc.segment = 'PS_STORAGE'
        inner join i_glaccountlineitem  as _gl   ON _gl.glaccount = _ska1.saknr
                                       and _gl.postingdate between lv_fdate and lv_tdate
                                       and _gl.profitcenter = _cepc.prctr
      where
       _mstr.mandt = session_context('CLIENT')
*     and
*  (
*       _CEPC.segment         = 'PS_3PC'
*    or _CEPC.segment         = 'PS_RET'
*    or _CEPC.segment         = 'PS_TINS'
*  )
    and  _mstr.rptid           = 'RPT12'
    and  _gl.ledger            = '0L'

    UNION
   SELECT DISTINCT
       _mstr.mainnode,
       _mstr.subnode,
       '0L'  as ledger,
       _stat_mo.rbukrs as companycode,
       '' as glaccount,
       '' as accountingdocument,
       '' as ledgergllineitem,
       _stat_mo.stagr                    as glaccountgroup,
       _stat_mo.prctr as profitcenter,
      ''  as postingdate,
      cast(_stat_mo.msl as dec(23,3))  AS amountincompanycodecurrency,
      'USD' as currencyincc,
      '' as Segment,
         CASE when  _stat_mo.postingdate >= lv_cqtrfrom and
                      _stat_mo.postingdate <= lv_cqtrto
                then  0    end as cqtr  ,
           case when  _stat_mo.postingdate >= lv_cqtrpyfrom and
                      _stat_mo.postingdate <= lv_cqtrpyto
                then 0 end as cqtrpy,
           case when  _stat_mo.postingdate >= lv_cyfrom and
                      _stat_mo.postingdate <= lv_cyto
                then 0 end as cy,
           case when  _stat_mo.postingdate >= lv_pyfrom and
                      _stat_mo.postingdate <= lv_pyto
                then 0 end as py,
            case when  _stat_mo.postingdate >= lv_py1from and
                      _stat_mo.postingdate <= lv_py1to
                then cast(_stat_mo.msl as dec(23,3)) END as py1,
           CASE when  _stat_mo.postingdate >= lv_py2from and
                      _stat_mo.postingdate <= lv_py2to
                then cast(_stat_mo.msl as dec(23,3)) END as py2
        from ztrpt_fi_mstr as _mstr

*     inner join      cepc               as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
*                                                 and _CEPC.segment = 'PS_STORAGE'
*                                                  and _CEPC.mandt = session_context('CLIENT')
       inner join      zi_stat_deriv_pdate_mo      as _stat_mo  ON  _stat_mo.stagr   =    _mstr.docfrom
*                                               and _stat.Prctr   =    _CEPC.prctr
                                                 and _stat_mo.postingdate between lv_fdate and lv_tdate
                                                 and _mstr.docfrom like '9%'
       inner join      zb_ss_nss_profctr_hier as _phier1 on _phier1.hierarchyclass = 'PSCO' AND  _phier1.nodevalue = _stat_mo.prctr
       inner join            cepc  as _cepc1 on _cepc1.mandt = session_context('CLIENT')
                                     and  _cepc1.prctr = _phier1.nodevalue
                                     and _cepc1.segment = 'PS_STORAGE'
      where
       _mstr.mandt = session_context('CLIENT')
       and _stat_mo.mandt = session_context('CLIENT')
*  (
*       _CEPC.segment         = 'PS_3PC'
*    or _CEPC.segment         = 'PS_RET'
*    or _CEPC.segment         = 'PS_TINS'
*  )
    and  _mstr.rptid           = 'RPT12'


        UNION
   SELECT DISTINCT
       _mstr.mainnode,
       _mstr.subnode,
       '0L'  as ledger,
       _stat.rbukrs as companycode,
       '' as glaccount,
       '' as accountingdocument,
       '' as ledgergllineitem,
       _stat.stagr                    as glaccountgroup,
       _stat.prctr as profitcenter,
      ''  as postingdate,
      cast(_stat.msl as dec(23,3))  AS amountincompanycodecurrency,
      'USD' as currencyincc,
      '' as Segment,
         CASE when  _stat.postingdate >= lv_cqtrfrom and
                      _stat.postingdate <= lv_cqtrto
                then  cast(_stat.msl as dec(23,3))    END as cqtr  ,
           CASE when  _stat.postingdate >= lv_cqtrpyfrom and
                      _stat.postingdate <= lv_cqtrpyto
                then cast(_stat.msl as dec(23,3)) END as cqtrpy,
           CASE when  _stat.postingdate >= lv_cyfrom and
                      _stat.postingdate <= lv_cyto
                then cast(_stat.msl as dec(23,3)) END as cy,
           CASE when  _stat.postingdate >= lv_pyfrom and
                      _stat.postingdate <= lv_pyto
                then cast(_stat.msl as dec(23,3)) END as py,
            CASE when  _stat.postingdate >= lv_py1from and
                      _stat.postingdate <= lv_py1to
                then 0 end as py1,
           case when  _stat.postingdate >= lv_py2from and
                      _stat.postingdate <= lv_py2to
                then 0 end as py2
        from ztrpt_fi_mstr as _mstr

*     inner join      cepc               as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
*                                                 and _CEPC.segment = 'PS_STORAGE'
*                                                  and _CEPC.mandt = session_context('CLIENT')
       inner join      zi_stat_deriv_pdate      as _stat  on  _stat.stagr   =    _mstr.docfrom
*                                               and _stat.Prctr   =    _CEPC.prctr
                                                 and _stat.postingdate between lv_fdate and lv_tdate
                                                 and _mstr.docfrom like '9%'
       inner join      zb_ss_nss_profctr_hier as _phier2 on _phier2.hierarchyclass = 'PSCO' AND  _phier2.nodevalue = _stat.prctr
              inner join            cepc  as _cepc2 on _cepc2.mandt = session_context('CLIENT')
                                     and  _cepc2.prctr = _phier2.nodevalue
                                     and _cepc2.segment = 'PS_STORAGE'
      where
       _mstr.mandt = session_context('CLIENT')
       and _stat.mandt = session_context('CLIENT')
*  (
*       _CEPC.segment         = 'PS_3PC'
*    or _CEPC.segment         = 'PS_RET'
*    or _CEPC.segment         = 'PS_TINS'
*  )
    and  _mstr.rptid           = 'RPT12';




   IF lv_pch = 'A'
   then
   lt_gldata2 = SELECT
         _gl2.*
       from :lt_gldata1
       as _gl2 ;
   elseif lv_pch = 'Y'
   then
    lt_gldata2 = select
         _gl2.*
       from :lt_gldata1
       as _gl2
       inner join      zb_ss_profctr_hier as _phier on _phier.hierarchyclass = 'PSCO' AND  _phier.nodevalue = _gl2.profitcenter;
    elseif lv_pch = 'N'
    then
    lt_gldata2 = select
         _gl2.*
       from :lt_gldata1
       as _gl2
       inner join      zb_nss_profctr_hier as _phier on _phier.hierarchyclass = 'PSCO' AND  _phier.nodevalue = _gl2.profitcenter;
end if;


******************************************************************************
   lt_gldatasum =
    select mainnode,
           subnode,
           ledger,
           companycode,
           glaccount,
           glaccountgroup,
           profitcenter,
           segment,
           sum(amountincompanycodecurrency) as amountincc,
           currencyincc,
           sum(_gl.cqtr) as cqtr,
           sum(_gl.cqtrpy) as cqtrpy ,
           sum(_gl.cy) as cy,
           sum(_gl.py) as  py,
           sum(_gl.py1) as py1,
           sum(_gl.py2) as py2
   from :lt_gldata2 as _gl
   GROUP BY mainnode,
            subnode,
            ledger,
            companycode,
            glaccount,
            glaccountgroup,
            profitcenter,
            Segment,
            currencyincc;


    lt_final = SELECT
         session_context('CLIENT') as Client,
         _gl.*
       from :lt_gldatasum
       as _gl;

   lt_return = select
                _gl.*,
                _skat.txt20     as glaccdesc
         from :lt_final as _gl
          left outer join skat as _skat on _skat.mandt = _gl.client
                                            and  _skat.spras = session_context('LOCALE_SAP')
                                               and _skat.saknr =  _gl.glaccount
                                               and _skat.ktopl = 'PSUS';

         RETURN :lt_return;
  ENDMETHOD.

ENDCLASS.
