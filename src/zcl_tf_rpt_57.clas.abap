CLASS zcl_tf_rpt_57 DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
   CLASS-METHODS get_rpt57 FOR TABLE FUNCTION ZTF_RPT_57.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tf_rpt_57 IMPLEMENTATION.

 METHOD get_rpt57
 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY "CDS SESSION CLIENT current
   USING I_CalendarDate I_GLAccountLineItem
    skat
    zb_altgl_hier
    ZB_HIER_NODE_TEXT.
*     hrrp_node hrrp_nodet
  declare lv_year char( 4 );
  declare lv_month char( 2 );
  declare lv_cdate date;
  declare lv_fdate "$ABAP.type( fis_budat_from )";
  declare lv_tdate "$ABAP.type( fis_budat_to )";

  lv_year = substring(p_fisprd,0,4);
  lv_month = substring(p_fisprd,6,2);
  lv_tdate = concat(lv_year, concat( '12', '31' ) );
  lv_fdate = concat(lv_year-3, concat( '01', '01' ) );

   SELECT current_date INTO lv_cdate FROM dummy;

  lt_calender_yr = SELECT
  DISTINCT
  _cal.calendaryear,
  _cal.calendarquarter,
  _cal.calendarmonth,
  _cal.yearmonth,
  _cal.yearquarter,
  concat(_cal.calendaryear, concat( '0', _cal.calendarmonth ) ) as fiscyearper
from
 i_calendardate as _cal
 where
*      ( CalendarYear =  lv_year and calendarmonth <= lv_month )
         CalendarYear =  lv_year
      or CalendarYear =  lv_year - 1
      or CalendarYear =  lv_year - 2;
*      or CalendarYear =  lv_year - 3 ;

  lt_calender_month = SELECT
  DISTINCT
  _cal.calendaryear,
  _cal.calendarquarter,
  _cal.calendarmonth,
  _cal.yearmonth,
  _cal.yearquarter,
  concat(_cal.calendaryear, concat( '0', _cal.calendarmonth ) ) as fiscyearper
from
 i_calendardate as _cal
 where
      ( CalendarYear =  lv_year and calendarmonth <= lv_month )
      or CalendarYear =  lv_year - 1;
* Get all G/L data
 lt_gldata_all = select distinct
session_context('CLIENT') as Client,
     _gl.ledger,
     _gl.CompanyCode,
     _gl.FiscalYear,
*     _gl.postingdate,
     _gl.AccountingDocument,
     _gl.LedgerGLLineItem,
     _gl.GlAccount,
    _gl.amountincompanycodecurrency   as AmountInCC,
     _gl.CompanyCodeCurrency as CurrencyInCC,
     _gl.Partnercompany as TradingPartner,
     CASE
     when FiscalPeriod between 013 and 016
     then concat( FiscalYear, '012' )
     else
     _gl.fiscalyearperiod
     end as
      FiscalYearPer
     from I_GLAccountLineItem
     as _gl
     where _gl.ledger = '0L'
      and _gl.FiscalPeriod != '000'
      and  _gl.fiscalyear in ( select calendaryear from :lt_calender_yr )
      and  _gl.GlAccount in ( select nodevalue from zb_altgl_hier );

 lt_gldata = select distinct
session_context('CLIENT') as Client,
     _gl.ledger,
     _gl.CompanyCode,
     _gl.FiscalYear,
     _gl.GlAccount,
   sum(  _gl.AmountInCC ) as AmountInCC,
     _gl.CurrencyInCC,
     _gl.TradingPartner,
     _gl.FiscalYearPer
     from :lt_gldata_all
     as _gl
   group by
               _gl.ledger,
               _gl.CompanyCode,
               _gl.FiscalYear,
               _gl.GlAccount,
               _gl.CurrencyInCC,
               _gl.TradingPartner,
               _gl.FiscalYearPer;



* Get Year Data for G/L
lt_calendar_yr =
     select
     Client,
              Ledger,
              CompanyCode,
              FiscalYear,
              GlAccount,
             sum( AmountInCC) as AmountInCC ,
              CurrencyInCC,
              TradingPartner,
               concat(  'Y', FiscalYear ) as FiscalYearPer
     from :lt_gldata
      group by   Client,
               Ledger,
               CompanyCode,
               FiscalYear,
              GlAccount,
               CurrencyInCC,
               TradingPartner,
               FiscalYearPer;

* Only get monthly data for last 2 years
  lt_calendar_month =
        SELECT
        _gl.*
        from :lt_gldata as _gl
        where _gl.FiscalYearPer in ( select fiscyearper from :lt_calender_month );
*            or _gl.FiscalYear = lv_year - 1;


       lt_final = SELECT * FROM :lt_calendar_month UNION
                  SELECT * FROM :lt_calendar_yr ;

* Getting G/L Text
 lt_return = SELECT
              session_context('CLIENT') as Client,
              Ledger,
              CompanyCode,
              FiscalYear,
              GlAccount,
              AmountInCC,
              CurrencyInCC,
              TradingPartner,
              FiscalYearPer,
              _skat.txt20     as GLAccDesc,
              _ntxt.nodetxt as NodeTxt
       from :lt_final as _gl
        left outer join skat as _skat on _skat.mandt = _gl.Client
                                          and  _skat.spras = session_context('LOCALE_SAP')
                                             and _skat.saknr =  _gl.GlAccount
                                             and _skat.ktopl = 'PSUS'
        left outer join ZB_HIER_NODE_TEXT( 'H109/PSUS/ALT_GL' )
                        as _ntxt  on _ntxt.leafvalue = _gl.GlAccount;


       RETURN :lt_return;
ENDMETHOD.
ENDCLASS.
