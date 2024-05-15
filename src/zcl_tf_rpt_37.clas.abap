CLASS zcl_tf_rpt_37 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt37_stat FOR TABLE FUNCTION ztf_rpt_37_stat.
    CLASS-METHODS get_rpt37_1 FOR TABLE FUNCTION ztf_rpt_37.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TF_RPT_37 IMPLEMENTATION.


  METHOD get_rpt37_1
   BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
     USING
      skat   I_GLAccountLineItem ska1     zb_2_rpt_0039 zb_ss_profctr_hier.
*     cepc ZI_STAT_DERIV_PDATE
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




   lt_gldata2 =
   SELECT DISTINCT
    _gl.ledger as rldnr,
    _gl.AccountingDocument,
    _gl.LedgerGLLineItem,
   _ska1.bilkt,
   _gl.glaccount as racct,
    _gl.AssetTransactionType as anbwa,
    _gl.CompanyCode as rbukrs,
    _gl.ProfitCenter as prctr,
     _pm.location,
    _gl.AmountInCompanyCodeCurrency as hsl,
    _gl.postingdate,
    _gl.FiscalPeriod
    from ska1   as _ska1
       inner join I_GLAccountLineItem  as _gl   on _gl.GLAccount = _ska1.saknr and _gl.FiscalYear = :p_year
       inner join  zb_2_rpt_0039 as _pm  ON _pm.ProfCtr =    _gl.profitcenter
       inner join zb_ss_profctr_hier as _phier on _phier.HierarchyClass = 'PSCO' and _phier.NodeValue =  _pm.NodeValue
    where _ska1.mandt = session_context('CLIENT')
      and _ska1.bilkt in ( '0000260000', '0000120000','0000120100', '0000120200', '0000120500' )
      and _gl.ledger = '0L';

  lt_gldata1 = SELECT
                b.racct,
    b.rldnr,
    b.anbwa,
    b.rbukrs,
    b.prctr,
    b.location,
    b.hsl,
    b.postingdate,
    b.FiscalPeriod,
    b.bilkt,
    case when  b.bilkt = '0000260000'  then b.hsl else 0 end as CurrentYearEncumbrances,
    case when  b.bilkt = '0000120000' and (b.anbwa >= '100' and b.anbwa <= '199') then b.hsl else 0 end as InitialCostLand,
    case when  (b.bilkt = '0000120200' or b.bilkt = '0000120100') and (b.anbwa >= '100' and b.anbwa <= '199') then b.hsl else 0 end as InitialCostBuildingsandImprovement,
    case when  (b.bilkt = '0000120200' or b.bilkt = '0000120100' or b.bilkt = '0000120000')then b.hsl else 0 end as Acquisitionduringtheyear ,
    case when  b.bilkt = '0000120000'   then b.hsl else 0 end as GrossCarryingAmountLand ,
    case when  (b.bilkt = '0000120200' or b.bilkt = '0000120100')   then b.hsl else 0 end as GrossCarryingAmountBuildingsandImprovement,
    case when  b.bilkt = '0000120500'  then b.hsl else 0 end as AccumulatedDepreciation
        from :lt_gldata2 as b;

******************************************************************************
        lt_gldatasum =
        select  _b.racct,
                 _b.rldnr,
                 _b.anbwa,

    _b.rbukrs,
    _b.prctr,
    _b.location,
    _b.postingdate,
    sum(_b.hsl) as hsl,
     sum(_b.CurrentYearEncumbrances) as CurrentYearEncumbrances,
     sum(_b.InitialCostLand) as ICLand,
     sum(_b.InitialCostBuildingsandImprovement) as ICBuildingsandImprovement,
     sum(_b.Acquisitionduringtheyear) as Acquisitionduringtheyear,
     sum(_b.GrossCarryingAmountLand) as GCAmountLand,
     sum(_b.GrossCarryingAmountBuildingsandImprovement) as GCAmtBuildingsandImprov,
     sum(_b.AccumulatedDepreciation) as AccumulatedDepreciation
   from :lt_gldata1 as _b
   GROUP BY racct,
            rldnr,
            anbwa,
            rbukrs,
            prctr,
            location,
            postingdate;


    lt_final = SELECT
         session_context('CLIENT') as Client,
         _gl.*
       from :lt_gldatasum
       as _gl;

   lt_return = select
                _gl.*,
                _skat.txt20     as GLAccDesc
         from :lt_final as _gl
          left outer join skat as _skat on _skat.mandt = _gl.Client
                                            and  _skat.spras = session_context('LOCALE_SAP')
                                               and _skat.saknr =  _gl.racct
                                               and _skat.ktopl = 'PSUS';

         RETURN :lt_return;

  ENDMETHOD.


 METHOD get_rpt37_stat
   BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
     USING
      ZI_STAT_DERIV_PDATE zb_2_rpt_0039 zb_ss_profctr_hier.

      declare lv_cyfrom "$ABAP.type( fis_budat_from )";
      declare lv_cyto "$ABAP.type( fis_budat_to )";
      declare lv_year char( 4 );

      lv_year = p_year;
* Year Comparison
    lv_cyfrom = concat(lv_year, concat( '01', '01' ) );
    lv_cyto =   concat(lv_year, concat( '12', '31' ) );



  lt_psmarket = Select * from zb_2_rpt_0039;
  lt_sstore = Select * from zb_ss_profctr_hier;


  lt_stat_nf =
   SELECT DISTINCT
  _pm.location,
  _pm.NodeValue as prctr,
  COUNT ( DISTINCT _pm.nodevalue) as NoofFacilities,
  0.000 NetRentableSquareFoot
  from :lt_psmarket as _pm
  inner join :lt_sstore as _phier on _phier.HierarchyClass = 'PSCO' and _phier.NodeValue =  _pm.NodeValue
  GROUP BY
  _pm.location,
 _pm.NodeValue;



  lt_stat_nr =
  SELECT DISTINCT
  _pm.location,
  a.prctr as prctr,
  0 as NoofFacilities,
    a.msl           as NetRentableSquareFoot
  from :lt_psmarket as _pm
  inner join :lt_sstore as _phier on _phier.HierarchyClass = 'PSCO' and _phier.NodeValue =  _pm.NodeValue
  inner join ZI_STAT_DERIV_PDATE as a on a.postingdate >= lv_cyfrom and a.postingdate <= lv_cyto
                                      and a.Prctr = _pm.nodevalue
                                      and a.stagr = '910220';

  lt_stat_nr_sum =
  Select DISTINCT
  location,
  prctr,
  sum( NoofFacilities ) as NoofFacilities,
  sum( NetRentableSquareFoot ) as NetRentableSquareFoot
  from :lt_stat_nr

  GROUP BY
  location,
  prctr;




  lt_stat =
  select * from :lt_stat_nf union
  Select * from :lt_stat_nr_sum;

  lt_stat_sum =

  select
  location,
  prctr,
  sum( NoofFacilities ) as NoofFacilities,
  sum( NetRentableSquareFoot  ) as NetRentableSquareFoot

  from :lt_stat
  GROUP BY
   location,
   prctr;


  lt_return =
    Select
    session_context('CLIENT') as Client,
    a.location as State,
    a.prctr as ProfitCenter,
    a.NoofFacilities,
    a.NetRentableSquareFoot


    from :lt_stat_sum as a;

    return :lt_return;


  ENDMETHOD.
ENDCLASS.
