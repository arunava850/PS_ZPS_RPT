@AbapCatalog.sqlViewName: 'ZISTATDERI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STAT Logic'
define view ZI_STAT_DERIV
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
  MSL
}
where
      client = $session.client
  and MSL    is not initial
