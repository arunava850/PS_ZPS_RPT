@AbapCatalog.sqlViewName: 'ZISTATDERI1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STAT Logic'
define view ZI_STAT_DERIV_1
  as select from ZTF_STAT_DERIV
{
  Stagr,
  RYear,
  RQtr,
  Rbukrs,
  // Rcntr,
  Prctr,
  @Semantics.currencyCode: true
  Runit,
  @Semantics.amount.currencyCode:'Runit'
  MSL,
  case RQtr when 'Dec' then concat(RYear, concat('12','01'))
            when 'Sep' then concat(RYear, concat('09','01'))
            when 'June' then concat(RYear, concat('06','01'))
            when 'March' then concat(RYear, concat('03','01'))
            end as postingdate
}
where
      client = $session.client
  and MSL    is not initial
