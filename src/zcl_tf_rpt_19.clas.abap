CLASS zcl_tf_rpt_19 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt19 FOR TABLE FUNCTION ZTF_RPT_19.
   CLASS-METHODS get_rpt19_stat FOR TABLE FUNCTION ZTF_RPT_19_stat.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_19 IMPLEMENTATION.
 METHOD get_rpt19_stat
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING   ztrpt_fi_mstr
      cepc ZB_SS_PROFCTR_HIER
    ZI_STAT_DERIV_PDATE
*    ZI_STAT_DERIV
    .
  declare lv_year char( 4 );
  declare lv_qtryear char( 6 );
  declare lv_qtr char( 2 );
  declare lv_date char( 2 );
  declare lv_month char( 2 );
  declare lv_month_to char( 2 );
  declare lv_month_from char( 2 );
  declare lv_cdate date;
  declare lv_idate "$ABAP.type( fis_budat_from )";
  declare lv_fdate "$ABAP.type( fis_budat_from )";
  declare lv_tdate "$ABAP.type( fis_budat_to )";
  declare lv_P1QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P2QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P3QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P4QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P5QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P1QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P2QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P3QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P4QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P5QtrFrom "$ABAP.type( fis_budat_from )";


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
  lv_idate = concat(lv_year, concat( lv_month_from, '01' ) );

lt_date = SELECT  lv_idate                                    DATE_OF_INTEREST,

 ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-5) * 3))                      P5QtrFrom,

        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-4) * 3)),-1)         P5QtrTo,
 ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-4) * 3))                      P4QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-3) * 3)),-1)         P4QtrTo,
 ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-3) * 3))                      P3QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-2) * 3)),-1)         P3QtrTo,
        ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-2) * 3))                      P2QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-1) * 3)),-1)         P2QtrTo,
        ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-1) * 3))                      P1QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),TO_INT(RIGHT(QUARTER(lv_idate),1) * 3)),-1)             P1QtrTo
*        ADD_MONTHS(TO_DATE(YEAR(lv_idate)),TO_INT(RIGHT(QUARTER(lv_idate),1) * 3))                          NEXT_QTR_BEGIN,
*        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)+1) * 3)),-1)         NEXT_QTR_END
    FROM DUMMY;

*  select P5QtrFrom,P1QtrTo  into  lv_fdate, lv_tdate from :lt_date;
   select TO_VARCHAR(P5QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P1QtrTo,  'YYYYMMDD'),
         TO_VARCHAR(P1QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P1QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P2QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P2QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P3QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P3QtrFrom,'YYYYMMDD'),
         TO_VARCHAR(P4QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P4QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P5QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P5QtrFrom, 'YYYYMMDD')
   into  lv_fdate, lv_tdate,
         lv_P1QtrTo , lv_P1QtrFrom,
         lv_P2QtrTo , lv_P2QtrFrom,
         lv_P3QtrTo , lv_P3QtrFrom,
         lv_P4QtrTo , lv_P4QtrFrom,
         lv_P5QtrTo , lv_P5QtrFrom from :lt_date;


********STAT Logic**********


lt_qtr_stat = select DISTINCT
             _MSTR.mainnode,
             _MSTR.subnode,
             _stat.rbukrs as CompanyCode,
             _stat.Prctr as ProfitCenter,
             _stat.STAGR as GlAccount,
           _stat.runit as UnitInCC,
            CASE when  _stat.postingdate >= lv_P1QtrFrom and
                    _stat.postingdate <= lv_P1QtrTo
              then _stat.msl     end as Q1  ,
         CASE when  _stat.postingdate >= lv_P2QtrFrom and
                    _stat.postingdate <= lv_P2QtrTo
              then _stat.msl end as Q2,
         CASE when  _stat.postingdate >= lv_P3QtrFrom and
                    _stat.postingdate <= lv_P3QtrTo
              then _stat.msl end as Q3,
         CASE when  _stat.postingdate >= lv_P4QtrFrom and
                    _stat.postingdate <= lv_P4QtrTo
              then _stat.msl end as Q4,
          CASE when  _stat.postingdate >= lv_P5QtrFrom and
                    _stat.postingdate <= :lv_P5QtrTo
              then _stat.msl end as Q5
             from
              ztrpt_fi_mstr      as _MSTR
            inner join      ZB_SS_PROFCTR_HIER as _phier on _phier.HierarchyClass = 'PSCO'
            inner join      cepc               as _CEPC  on  _cepc.mandt = _mstr.mandt
                                               and  _CEPC.prctr   = _phier.NodeValue
                                               and _CEPC.segment = 'PS_STORAGE'
            inner join      ZI_STAT_DERIV_PDATE      as _stat  on  _stat.Stagr   =    _MSTR.docfrom
                                               and _stat.Prctr   =    _CEPC.prctr
                                               and _stat.postingdate between lv_fdate and lv_tdate
            where _mstr.rptid = 'RPT19'
              and _mstr.mandt =  session_context('CLIENT')
              and _mstr.docfrom like '9%';

lt_qtr_stat1 = select
               mainnode,
               subnode,
               companyCode,
               ProfitCenter,
               GlAccount,
                sum( Q1 ) as Q1,
                sum( Q2 ) as Q2,
                sum( Q3 ) as Q3,
                sum( Q4 ) as Q4,
                sum( Q5 ) as Q5,
                unitInCC
               from :lt_qtr_stat
               GROUP BY mainnode,subnode,companyCode,ProfitCenter, GlAccount,UnitInCC;


********************************
  lt_final = SELECT
        session_context('CLIENT') as Client,
        _stat.mainnode,
        _stat.subnode,
         _stat. companycode,
         profitcenter,
         GlAccount,
*      _stat.UnitinCC ,
        q1,
        q2,
        q3,
        q4,
        q5

          from:lt_qtr_stat1 as _stat;


       RETURN :lt_final;
ENDMETHOD.
 METHOD get_rpt19
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  I_GLAccountLineItem ztrpt_fi_mstr
    skat ska1 cepc ZB_SS_PROFCTR_HIER

    .
  declare lv_year char( 4 );
  declare lv_qtryear char( 6 );
  declare lv_qtr char( 2 );
  declare lv_date char( 2 );
  declare lv_month char( 2 );
  declare lv_month_to char( 2 );
  declare lv_month_from char( 2 );
  declare lv_cdate date;
  declare lv_idate "$ABAP.type( fis_budat_from )";
  declare lv_fdate "$ABAP.type( fis_budat_from )";
  declare lv_tdate "$ABAP.type( fis_budat_to )";
  declare lv_P1QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P2QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P3QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P4QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P5QtrTo "$ABAP.type( fis_budat_to )";
  declare lv_P1QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P2QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P3QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P4QtrFrom "$ABAP.type( fis_budat_from )";
  declare lv_P5QtrFrom "$ABAP.type( fis_budat_from )";

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
  lv_idate = concat(lv_year, concat( lv_month_from, '01' ) );

lt_date = SELECT  lv_idate                                    DATE_OF_INTEREST,

 ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-5) * 3))                      P5QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-4) * 3)),-1)         P5QtrTo,
 ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-4) * 3))                      P4QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-3) * 3)),-1)         P4QtrTo,
 ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-3) * 3))                      P3QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-2) * 3)),-1)         P3QtrTo,
        ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-2) * 3))                      P2QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-1) * 3)),-1)         P2QtrTo,
        ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)-1) * 3))                      P1QtrFrom,
        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),TO_INT(RIGHT(QUARTER(lv_idate),1) * 3)),-1)             P1QtrTo
*        ADD_MONTHS(TO_DATE(YEAR(lv_idate)),TO_INT(RIGHT(QUARTER(lv_idate),1) * 3))                          NEXT_QTR_BEGIN,
*        ADD_DAYS(ADD_MONTHS(TO_DATE(YEAR(lv_idate)),(TO_INT(RIGHT(QUARTER(lv_idate),1)+1) * 3)),-1)         NEXT_QTR_END
    FROM DUMMY;

*  select P5QtrFrom,P1QtrTo  into  lv_fdate, lv_tdate from :lt_date;
  select TO_VARCHAR(P5QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P1QtrTo,  'YYYYMMDD'),
         TO_VARCHAR(P1QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P1QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P2QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P2QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P3QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P3QtrFrom,'YYYYMMDD'),
         TO_VARCHAR(P4QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P4QtrFrom, 'YYYYMMDD'),
         TO_VARCHAR(P5QtrTo, 'YYYYMMDD'),
         TO_VARCHAR(P5QtrFrom, 'YYYYMMDD')
   into  lv_fdate, lv_tdate,
         lv_P1QtrTo , lv_P1QtrFrom,
         lv_P2QtrTo , lv_P2QtrFrom,
         lv_P3QtrTo , lv_P3QtrFrom,
         lv_P4QtrTo , lv_P4QtrFrom,
         lv_P5QtrTo , lv_P5QtrFrom from :lt_date;


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
    _CEPC.Segment,
    substring(_gl.postingdate, 1,4) as RYear,
     CASE substring(_gl.postingdate,5,2)
        WHEN  '01' then 'March'
        WHEN  '02' then 'March'
        WHEN  '03' then 'March'
        WHEN  '04' then 'June'
        WHEN  '05' then 'June'
        WHEN  '06' then 'June'
        WHEN  '07' then 'Sep'
        WHEN  '08' then 'Sep'
        WHEN  '09' then 'Sep'
        WHEN  '10' then 'Dec'
        WHEN  '11' then 'Dec'
        WHEN  '12' then 'Dec'
        ELSE ' '
        END                            as CQtr,
           CASE when  _gl.postingdate >= lv_P1QtrFrom and
                    _gl.postingdate <= lv_P1QtrTo
              then 'Q1'
              when  _gl.postingdate >= lv_P2QtrFrom and
                    _gl.postingdate <= lv_P2QtrTo
              then 'Q2'
              when  _gl.postingdate >= lv_P3QtrFrom and
                    _gl.postingdate <= lv_P3QtrTo
               then 'Q3'
             when  _gl.postingdate >= lv_P4QtrFrom and
                    _gl.postingdate <= lv_P4QtrTo
                  then  'Q4'
             when  _gl.postingdate >= lv_P5QtrFrom and
                    _gl.postingdate <= :lv_P5QtrTo
              then 'Q5'
              end as Qtr,

       CASE when  _gl.postingdate >= lv_P1QtrFrom and
                    _gl.postingdate <= lv_P1QtrTo
              then amountincompanycodecurrency     end as Q1  ,
         CASE when  _gl.postingdate >= lv_P2QtrFrom and
                    _gl.postingdate <= lv_P2QtrTo
              then amountincompanycodecurrency end as Q2,
         CASE when  _gl.postingdate >= lv_P3QtrFrom and
                    _gl.postingdate <= lv_P3QtrTo
              then amountincompanycodecurrency end as Q3,
         CASE when  _gl.postingdate >= lv_P4QtrFrom and
                    _gl.postingdate <= lv_P4QtrTo
              then amountincompanycodecurrency end as Q4,
          CASE when  _gl.postingdate >= lv_P5QtrFrom and
                    _gl.postingdate <= :lv_P5QtrTo
              then amountincompanycodecurrency end as Q5
      from ztrpt_fi_mstr as _mstr
           inner join            ZB_SS_PROFCTR_HIER                             as _phier on _phier.HierarchyClass = 'PSCO'
           inner join ska1   as _SKA1 on _SKA1.mandt = _mstr.mandt
                                      and   _SKA1.bilkt = _MSTR.docfrom

      inner join            cepc
                             as _CEPC  on  _CEPC.mandt =  session_context('CLIENT')
                                     and  _CEPC.prctr   = _phier.NodeValue
                             and _CEPC.segment = 'PS_STORAGE'
      inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _SKA1.saknr
                                     and _gl.postingdate between lv_fdate and lv_tdate
                                     and _gl.ProfitCenter = _CEPC.prctr

    where
        _mstr.mandt =   session_context('CLIENT')
    and    _MSTR.rptid           = 'RPT19'
  and  _gl.Ledger            = '0L';

 lt_gldatasum =
  select Mainnode,
         Subnode,
         Ledger,
         CompanyCode,
         GlAccount,
         GLAccountGroup,
         ProfitCenter,
         Segment,
         SUM(amountincompanycodecurrency) as AmountinCC,
         CurrencyInCC,
         SUM(_gl.Q1) as Q1,
         SUM(_gl.Q2) as Q2 ,
         SUM(_gl.Q3) as Q3,
         SUM(_gl.Q4) as  Q4,
         SUM(_gl.Q5) as Q5
 from :lt_gldata1 as _gl
 GROUP BY Mainnode,
          Subnode,
          Ledger,
          CompanyCode,
          GlAccount,
          GLAccountGroup,
          ProfitCenter,
          Segment,
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
