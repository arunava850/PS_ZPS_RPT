CLASS zcl_stat_deriv_mo DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
    CLASS-METHODS get_msl FOR TABLE FUNCTION ZTF_STAT_DERIV_MO.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_stat_deriv_mo IMPLEMENTATION.

  METHOD get_msl
  BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
  USING faglskf_pn.

    lt_msl = select rclnt,
    stagr,
    date_from,
     CAST(docnr as "$ABAP.type( SET_COUNT )" )   as docnr,
    rbukrs,
    prctr,
    runit,
    msl,
    CASE substring(date_from,5,2)
        WHEN  '01' then 'Jan'
        WHEN  '02' then 'Feb'
        WHEN  '03' then 'March'
        WHEN  '04' then 'April'
        WHEN  '05' then 'May'
        WHEN  '06' then 'June'
        WHEN  '07' then 'July'
        WHEN  '08' then 'Aug'
        WHEN  '09' then 'Sep'
        WHEN  '10' then 'Oct'
        WHEN  '11' then 'Nov'
        WHEN  '12' then 'Dec'
        ELSE ' '
        END                            as CQtrDateFrom,
        substring(date_from,5,2) as CalendarMonth,
        substring(date_from, 1,4) as RYear
        from faglskf_pn
        where rclnt = session_context('CLIENT')
          and ( msl != 0
               or msl != 0.000 );

    lt_msl_grp =
      select
      rclnt,
      stagr,
      docnr,
    rbukrs,
    prctr,
    runit,
    msl,
   CQtrDateFrom,
   CalendarMonth,
    RYear,
    row_number( ) over ( PARTITION BY rclnt, stagr, rbukrs, prctr,runit,CQtrDateFrom, RYear, CalendarMonth
                           ORDER BY docnr desc ) as row_number_partion_by
        from :lt_msl;

   lt_msl_unq =
      select
       rclnt,
       stagr,
       docnr,
       rbukrs,
       prctr,
       runit,
       msl,
      CQtrDateFrom as CQtrDateFrom,
      CalendarMonth,
    RYear
      from :lt_msl_grp as _msl
       where row_number_partion_by = 1;


        lt_msl_conc =
        SELECT
        rclnt,
        Stagr,
        Rbukrs,
        Prctr,
        Runit,
        Msl,
        CQtrDateFrom,
        CalendarMonth,
        RYear,
        concat( CQtrDateFrom, RYear ) as cqtryear,
        1 as cqtryearCount
     FROM :lt_msl_unq;

 lt_msl_sum =
     SELECT
        rclnt,
        Stagr,
        RYear,
        Rbukrs,
        Prctr,
        Runit,
        cqtryear,
        CQtrDateFrom as RQtr,
        CalendarMonth,
        SUM( Msl ) / SUM(cqtryearCount) AS fMSL
   FROM :lt_msl_conc
   GROUP BY
   rclnt,
Stagr,
RYear,
Rbukrs,
Prctr,
Runit,
cqtryear,
CQtrDateFrom,
CalendarMonth;

      return  select
      rclnt AS Client,
      stagr AS Stagr,
      ryear    AS ryear,
      RQtr,
      CalendarMonth,
      rbukrs AS Rbukrs,
      prctr AS Prctr,
      runit AS Runit,
      fmsl AS msl
      FROM :lt_msl_sum;

  ENDMETHOD.
ENDCLASS.
