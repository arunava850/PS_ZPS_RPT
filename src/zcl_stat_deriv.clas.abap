CLASS zcl_stat_deriv DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
    CLASS-METHODS get_msl FOR TABLE FUNCTION ZTF_STAT_deriv.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_stat_deriv IMPLEMENTATION.

  METHOD get_msl
  BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
  USING faglskf_pn.

    lt_msl = select rclnt,
    stagr,
    date_from,
     CAST(docnr as "$ABAP.type( SET_COUNT )" )   as docnr,
*    docln,
    rbukrs,
*    rcntr,
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
    RYear,
    row_number( ) over ( PARTITION BY rclnt, stagr, rbukrs, prctr,runit,CQtrDateFrom, RYear
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
    CASE CQtrDateFrom
        WHEN  'Jan' then 'March'
        WHEN  'Feb' then 'March'
        WHEN  'March' then 'March'
        WHEN  'April' then 'June'
        WHEN  'May' then 'June'
        WHEN  'June' then 'June'
        WHEN  'July' then 'Sep'
        WHEN  'Aug' then 'Sep'
        WHEN  'Sep' then 'Sep'
        WHEN  'Oct' then 'Dec'
        WHEN  'Nov' then 'Dec'
        WHEN  'Dec' then 'Dec'
        END                            as CQtrDateFrom,
    RYear
      from :lt_msl_grp as _msl
       where row_number_partion_by = 1;


        lt_msl_conc =
        SELECT
        rclnt,
        Stagr,
*        Docln,
        Rbukrs,
*        Rcntr,
        Prctr,
        Runit,
        Msl,
        CQtrDateFrom,
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
*        Rcntr,
        Prctr,
        Runit,
        cqtryear,
        CQtrDateFrom as RQtr,
        SUM( Msl ) / SUM(cqtryearCount) AS fMSL
   FROM :lt_msl_conc
   GROUP BY
   rclnt,
Stagr,
RYear,
Rbukrs,
*Rcntr,
Prctr,
Runit,
cqtryear,
CQtrDateFrom;

      return  select
      rclnt AS Client,
      stagr AS Stagr,
      ryear    AS ryear,
      RQtr,
      rbukrs AS Rbukrs,
*      rcntr AS Rcntr,
      prctr AS Prctr,
      runit AS Runit,
      fmsl AS msl
      FROM :lt_msl_sum;

  ENDMETHOD.
ENDCLASS.
