@AbapCatalog.sqlViewName: 'ZISTATDERIVPDMO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STAT Logic'
define view ZI_STAT_DERIV_PDATE_MO
  as select from ZTF_STAT_DERIV_MO
{
  Stagr,
  RYear,
  RQtr,
  CalendarMonth,
  Rbukrs,
  Prctr,
  @Semantics.currencyCode: true
  Runit,
  @Semantics.amount.currencyCode:'Runit'
  MSL,
  case RQtr
            when 'Dec' then concat(RYear, concat('12','01'))
            when 'Sep' then concat(RYear, concat('09','01'))
            when 'June' then concat(RYear, concat('06','01'))
            when 'March' then concat(RYear, concat('03','01'))
            when 'Jan' then concat(RYear, concat('01','01'))
            when 'Feb' then concat(RYear, concat('02','01'))
            when 'April' then concat(RYear, concat('04','01'))
            when 'May' then concat(RYear, concat('05','01'))
            when 'July' then concat(RYear, concat('07','01'))
            when 'Aug' then concat(RYear, concat('08','01'))
            when 'Oct' then concat(RYear, concat('10','01'))
            when 'Nov' then concat(RYear, concat('11','01'))
            end as postingdate
}
where
      client = $session.client
  and MSL    is not initial
