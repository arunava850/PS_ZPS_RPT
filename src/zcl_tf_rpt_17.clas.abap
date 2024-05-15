CLASS zcl_tf_rpt_17 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt17 FOR TABLE FUNCTION ZTF_RPT_17.
   CLASS-METHODS get_rpt17_rr FOR TABLE FUNCTION ZTF_RPT_17_rr.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_17 IMPLEMENTATION.
METHOD get_rpt17_rr
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING  I_GLAccountLineItem ztrpt_fi_mstr
     ska1 cepc zb_nss_profctr_hier  ZI_STAT_DERIV_PDATE.
  declare lv_year char( 4 );
  declare lv_qtryear char( 6 );
  declare lv_qtr char( 2 );
  declare lv_date char( 2 );
  declare lv_month char( 2 );
  declare lv_month_to char( 2 );
  declare lv_month_from char( 2 );
  declare lv_cdate date;
  declare lv_fdate "$ABAP.type( fis_budat_from )";
  declare lv_fdate_d "$ABAP.type( fis_budat_from )";
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
*
*   DECLARE lt_qtr_tab table( ryear "$ABAP.type( GJAHR )" ,
*                        cqtr  "$ABAP.type( CHAR5 )" ,
*                        qtr   "$ABAP.type( CHAR10 )"  );

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

  lv_fdate = concat(lv_year-1, concat( '01' , '01' ) );
  lv_tdate = concat(lv_year, concat( lv_month_to, lv_date ) );

* Qtr Comparison
 lv_cqtrfrom = concat(lv_year, concat( lv_month_from, '01' ) );
 lv_cqtrto =   concat(lv_year, concat( lv_month_to, lv_date ) );
* CQtr Previous Year
 lv_cqtrPYfrom = concat(lv_year - 1 , concat( lv_month_from, '01' ) );
 lv_cqtrPYto =   concat(lv_year - 1 , concat( lv_month_to, lv_date ) );

* Year Comparison
 lv_cyfrom = concat(lv_year, concat( '01', '01' ) );
 lv_cyto =   concat(lv_year, concat( lv_month_to, lv_date ) );

* Previous Year Comparison
lv_pyfrom = concat(lv_year - 1 , concat( '01', '01' ) );
 lv_pyto =   concat(lv_year - 1 , concat( lv_month_to, lv_date ) );

lt_gldata3 = select distinct
      _mstr.mandt as Client,
      _gl.ledger,
     _gl.CompanyCode,
     _gl.AccountingDocument,
     _gl.LedgerGLLineItem,
     _gl.GLAccount,
     _gl.profitcenter,
     _SKA1.bilkt                    as GLAccountGroup,
    _gl.PostingDate,
    _gl.CompanyCodeCurrency as CurrencyInCC,
      CASE when  _gl.postingdate >= lv_cqtrfrom and
                    _gl.postingdate <= lv_cqtrto
              then amountincompanycodecurrency     end as CQTR  ,
          CASE when  _gl.postingdate >= lv_cqtrPYfrom and
                    _gl.postingdate <= lv_cqtrPYto
              then amountincompanycodecurrency end   as CQTRPY,
         CASE when  _gl.postingdate >= lv_cyfrom and
                    _gl.postingdate <= lv_cyto
              then amountincompanycodecurrency end    as CY,
        CASE when  _gl.postingdate >= lv_pyfrom and
                    _gl.postingdate <= lv_pyto
              then amountincompanycodecurrency end   as PY
     from    zb_nss_profctr_hier as _nss
      inner join      ztrpt_fi_mstr       as _mstr
                                                   on _mstr.rptid = 'RPT17'
           inner join ska1   as _SKA1 on _SKA1.mandt = _mstr.mandt
                                      and _SKA1.bilkt = _MSTR.docfrom
      inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _SKA1.saknr
                                          and _gl.ProfitCenter = _nss.NodeValue
                                     and _gl.postingdate between lv_fdate and lv_tdate
       inner join      cepc                as _cepc ON _cepc.mandt =   _mstr.mandt
                                                   and  _cepc.prctr   = _nss.NodeValue
                                                   and _cepc.segment = 'PS_STORAGE'
    where _mstr.mandt = session_context('CLIENT')
      and _MSTR.rptid =  'RPT17'
      and _MSTR.docfrom not like '9%'
      and _gl.Ledger  =  '0L';

 lt_gldatasum3 =
  select
         Client,
         CompanyCode,
         ProfitCenter,
         GLAccountGroup as GlAccount,
         CurrencyInCC as UnitinCC,
         SUM(_gl.CQtr) as CQtr,
         SUM(_gl.CQtrPY) as CQtrPY ,
         SUM(_gl.CY) as CY,
         SUM(_gl.PY) as  PY

 from :lt_gldata3 as _gl
 GROUP BY
          Client,
          CompanyCode,
          ProfitCenter,
          GLAccountGroup,
          CurrencyInCC;

*RPT 17
lt_qtr_stat = select DISTINCT
             _mstr.mandt as Client,
             _stat.rbukrs as CompanyCode,
             _stat.Prctr  as ProfitCenter,
             _stat.STAGR as GlAccount,
           _stat.runit as UnitInCC,
            CASE when  _stat.postingdate >= lv_cqtrfrom and
                    _stat.postingdate <= lv_cqtrto
              then _stat.msl     end as CQTR  ,
          CASE when  _stat.postingdate >= lv_cqtrPYfrom and
                    _stat.postingdate <= lv_cqtrPYto
              then _stat.msl end   as CQTRPY,
         CASE when  _stat.postingdate >= lv_cyfrom and
                    _stat.postingdate <= lv_cyto
              then _stat.msl end    as CY,
        CASE when  _stat.postingdate >= lv_pyfrom and
                    _stat.postingdate <= lv_pyto
              then  _stat.msl end   as PY

             from
              ztrpt_fi_mstr      as _MSTR
            inner join      zb_nss_profctr_hier as _phier on _phier.HierarchyClass = 'PSCO'
            inner join      cepc               as _CEPC  on  _cepc.mandt = _mstr.mandt
                                               and  _CEPC.prctr   = _phier.NodeValue
                                               and _CEPC.segment = 'PS_STORAGE'
            inner join      ZI_STAT_DERIV_PDATE      as _stat  on  _stat.Stagr   =    _MSTR.docfrom
                                               and _stat.Prctr   =    _CEPC.prctr
                                               and _stat.postingdate between lv_fdate and lv_tdate
            where _mstr.mandt = session_context('CLIENT')
              and _mstr.rptid = 'RPT17'
              and _mstr.docfrom like '9%'
              and _mstr.docfrom not in ( '910230','910210' );


lt_qtr_stat1 = select
                Client,
               companyCode,
               ProfitCenter,
               GlAccount,
               unitInCC,
                sum( CQTR ) as CQTR,
                sum( CQTRPY ) as CQTRPY,
                sum( CY ) as CY,
                sum( PY ) as PY

               from :lt_qtr_stat
               GROUP BY client,companyCode, ProfitCenter, GlAccount,UnitInCC;

   lt_final = select * from :lt_gldatasum3 union
              select * from :lt_qtr_stat1;
       RETURN :lt_final;
ENDMETHOD.
 METHOD get_rpt17
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING   ztrpt_fi_mstr
      cepc zb_nss_profctr_hier t005u zi_stat_deriv.

  declare lv_year char( 4 );

  declare lv_qtr char( 2 );
  lv_qtr = p_qtr;
  lv_year = p_year;

  lt_Qtr_table  = SELECT
  lv_year AS ryear,
  case when lv_qtr = 'Q1' then 'March'
       WHEN lv_qtr = 'Q2' then 'June'
       WHEN lv_qtr = 'Q3' then 'Sep'
       WHEN lv_qtr = 'Q4' then 'Dec'
       END as cqtr
  from dummy as _qtr;

lt_data =
      SELECT
      _mstr.mandt as Client,
       _reg.bezei     as State,
      _nss.NodeValue as ProfitCenter,
      sum(  case when _stat.Stagr = '910230' then 1
      END   )          as COPByGL,
      COUNT ( DISTINCT _stat.prctr) as COPByPC,
      sum( case WHEN _stat.Stagr = '910210'
   then _stat.msl
      end    )        as TotalSqFoot
      from    zb_nss_profctr_hier as _nss
      inner join      ztrpt_fi_mstr       as _mstr on _mstr.rptid = 'RPT17'
      inner join      cepc                as _cepc ON _cepc.mandt =   _mstr.mandt
      and  _cepc.prctr   = _nss.NodeValue
      and _cepc.segment = 'PS_STORAGE'
      inner join zi_stat_deriv       as _stat ON  _stat.Stagr   =    _mstr.docfrom
                                                   and _stat.Prctr   =    _cepc.prctr
      inner join :lt_Qtr_table as _qtr
      on _qtr.ryear = _stat.ryear
      and _qtr.cqtr = _stat.RQtr
      left outer join t005u               as _reg  on
      _reg.mandt =  _mstr.mandt
      and  _reg.spras = session_context('LOCALE_SAP')
      and _reg.land1 = _cepc.land1
      and _reg.bland = _cepc.regio
      where
      _mstr.mandt = session_context('CLIENT')
      and _mstr.rptid = 'RPT17'
      and _mstr.docfrom like '9%'
     group by
     _mstr.mandt,
     _reg.bezei,
      _nss.NodeValue;

       return :lt_data;
endmethod.
ENDCLASS.
