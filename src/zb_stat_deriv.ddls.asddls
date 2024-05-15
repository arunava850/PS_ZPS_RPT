@AbapCatalog.sqlViewName: 'ZSTATDERIV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stat Logic Derivation from FAGLSKF_PN'
define view ZB_STAT_DERIV
  as select from faglskf_pn as _stat
{
  key stagr      as Stagr,
  key date_from  as DateFrom,
  key docnr      as Docnr,
  key docln      as Docln,
      date_to    as DateTo,
      rbukrs     as Rbukrs,
      rcntr      as Rcntr,
      prctr      as Prctr,
      rfarea     as Rfarea,
      rbusa      as Rbusa,
      kokrs      as Kokrs,
      segment    as Segment,
      activ      as Activ,
      obart      as Obart,
      runit      as Runit,
      logsys     as Logsys,
      rrcty      as Rrcty,
      rvers      as Rvers,
      msl        as Msl,
      refdocnr   as Refdocnr,
      canc_docnr as CancDocnr,
      usnam      as Usnam,
      timestamp  as Timestamp,
      delta_ind  as DeltaInd
}
