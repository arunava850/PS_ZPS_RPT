@AbapCatalog.sqlViewName: 'ZV_RPT_971'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 77 Table3 Cons'
@Analytics.dataCategory: #CUBE

@VDM.viewType: #COMPOSITE
define view ZI_RPT_97_1
  with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
  as select distinct from ztrpt_fi_mstr                                  as _MSTR
    inner join            ZB_SS_PROFCTR_HIER                             as _phier on _phier.HierarchyClass = 'PSCO'
    left outer join       ska1                                           as _SKA1  on _SKA1.bilkt = _MSTR.docfrom
    inner join            cepc                                           as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
                                                                                   and _CEPC.segment = 'PS_STORAGE'
    inner join            I_GLAcctBalance
               ( P_FromPostingDate: $parameters.P_FromPostingDate,
                          P_ToPostingDate: $parameters.P_ToPostingDate ) as _gl    on  _gl.GLAccount    = _SKA1.saknr
                                                                                   and _gl.ProfitCenter = _CEPC.prctr
    left outer join ZI_STAT_DERIV       as _stat on  _stat.Stagr   =    _MSTR.docfrom
                                                 and _stat.Prctr   =    _CEPC.prctr
                                                 and _MSTR.docfrom like '9%'
    inner join ZI_2_RPT_0039 ( P_FromPostingDate: $parameters.P_FromPostingDate,
                          P_ToPostingDate: $parameters.P_ToPostingDate ) as h1 on _gl.Ledger = h1.Ledger
                          and _gl.CompanyCode = h1.CompanyCode
                          and _gl.FiscalYear = h1.FiscalYear
                          and _gl.SourceLedger = h1.SourceLedger
                          and _gl.AccountingDocument = h1.AccountingDocument
                          and _gl.LedgerGLLineItem = h1.LedgerGLLineItem
                          and _gl.GLAccountFlowType = h1.GLAccountFlowType
                          and _gl.FiscalPeriodDate = h1.FiscalPeriodDate
                                                 

{
      //  @Semantics.text: true
  key _MSTR.counter,
  key _MSTR.mainnode,
  key _MSTR.subnode,
  key _gl.Ledger,
  key _gl.CompanyCode,
  key _gl.FiscalYear,
  key _gl.SourceLedger,
  key _gl.AccountingDocument,
  key _gl.LedgerGLLineItem,
  key _gl.GLAccountFlowType,
      _SKA1.bilkt                    as GLAccountGroup,
      _gl.GLAccount,
      _gl.GLAccountHierarchy,
      _gl.ProfitCenter,
      _gl.FiscalYearVariant,
      _gl.FiscalYearPeriod,
      _gl.PostingDate,
      _gl.GLAccountType,
      _gl.ChartOfAccounts,
      _gl.Plant,
      _gl.Supplier,
      _gl.Customer,
      _gl.Material,
      _gl.FinancialAccountType,
      _gl.CompanyCodeCurrency,
      @DefaultAggregation: #SUM
      _gl.AmountInCompanyCodeCurrency,
      _gl.FiscalPeriod,
      case substring(_gl.PostingDate,5,2)
                 when  '01' then 'March'
                 when  '02' then 'March'
                  when  '03' then 'March'
                  when  '04' then 'June'
                  when  '05' then 'June'
                  when  '06' then 'June'
                  when  '07' then 'Sep'
                  when  '08' then 'Sep'
                  when  '09' then 'Sep'
                  when  '10' then 'Dec'
                  when  '11' then 'Dec'
                  when  '12' then 'Dec'
                  else 'Dummy'
                end                  as CQtrPostingDt,
      case substring(_gl.PostingDate,5,2) when  '01' then 'Jan'
                     when  '02' then 'Feb'
                      when  '03' then 'Mar'
                      when  '04' then 'Apr'
                      when  '05' then 'May'
                      when  '06' then 'Jun'
                      when  '07' then 'Jul'
                      when  '08' then 'Aug'
                      when  '09' then 'Sep'
                      when  '10' then 'Oct'
                      when  '11' then 'Nov'
                      when  '12' then 'Dec'
                      else 'Dummy'
                   end               as CMonPostingDt,
      substring(_gl.PostingDate,1,4) as CYrPostingDt,
      case substring(_gl.PostingDate,5,2) when  '01' then 'Jan'
                 when  '02' then 'Feb'
                  when  '03' then 'Mar'
                  when  '04' then 'Apr'
                  when  '05' then 'May'
                  when  '06' then 'Jun'
                  when  '07' then 'Jul'
                  when  '08' then 'Aug'
                  when  '09' then 'Sep'
                  when  '10' then 'Oct'
                  when  '11' then 'Nov'
                  when  '12' then 'Dec'
                  else 'Dummy'
                   end               as CMonDescPostingDt,
        h1.Location,
      h1.Facilities,
      h1.NodeValue,
      h1.Storage,
      case when h1.REV_CYYTD is not null and h1.DIR_CYYTD is not null and h1.IND_CYYTD is not null then 
      (h1.REV_CYYTD - h1.DIR_CYYTD - h1.IND_CYYTD ) 
      when h1.REV_CYYTD is not null and h1.DIR_CYYTD is null and h1.IND_CYYTD is null then h1.REV_CYYTD end as NOI
       
  
      
}

where
      _gl.Ledger            = '0L'
  and _gl.GLAccountFlowType = '2'
  and _MSTR.rptid           = 'RPT97'


union select from ztrpt_fi_mstr      as _MSTR
  inner join      ZB_SS_PROFCTR_HIER as _phier on _phier.HierarchyClass = 'PSCO'
  inner join      cepc               as _CEPC  on  _CEPC.prctr   = _phier.NodeValue
                                               and _CEPC.segment = 'PS_STORAGE'
  inner join      ZI_STAT_DERIV         as _stat  on  _stat.Stagr   =    _MSTR.docfrom
                                               and _stat.Prctr   =    _CEPC.prctr

                                               and _MSTR.docfrom like '9%'

{
  key _MSTR.counter,
  key _MSTR.mainnode,
  key _MSTR.subnode,
      '0L'                                  as Ledger,
      _stat.Rbukrs                          as CompanyCode,
      cast( '0000' as abap.numc( 4 ))       as FiscalYear,
      ''                                    as SourceLedger,
      ''                                    as AccountingDocument,
      ''                                    as LedgerGLLineItem,
      ''                                    as GLAccountFlowType,
      _stat.Stagr                           as GLAccountGroup,
      ''                                    as GLAccount,
      ''                                    as GLAccountHierarchy,
      _stat.Prctr                           as ProfitCenter,
      // ''                                    as CSegment,
      //  ''                                    as Segment,
      ''                                    as FiscalYearVariant,
      cast( '0000000' as abap.numc( 7 ))    as FiscalYearPeriod,
      ''                                    as PostingDate,
      ''                                    as GLAccountType,
      ''                                    as ChartOfAccounts,
      ''                                    as Plant,
      ''                                    as Supplier,
      ''                                    as Customer,
      ''                                    as Material,
      ''                                    as FinancialAccountType,
      cast( 'USD' as abap.cuky )            as CompanyCodeCurrency,
      _stat.MSL                             as AmountInCompanyCodeCurrency,
      cast( '000' as poper preserving type) as FiscalPeriod,
      _stat.RQtr                            as CQtrPostingDt,
      ''                                    as CMonPostingDt,
      _stat.RYear                           as CYrPostingDt,
      ''                                    as CMonDescPostingDt,
      ''                                    as Location,
      ''                                    as Facilities,
      ''                                    as NodeValue,
      ''                                    as Storage,
      0.00                                    as NOI
      


}
where
  _MSTR.rptid = 'RPT97'
//  and(
//        _stat.date_from >= $session.system_date
//    and _stat.date_to   <= $session.system_date
//  )

union select from ztrpt_fi_mstr as _MSTR

{
  key _MSTR.counter,
  key _MSTR.mainnode,
  key _MSTR.subnode,
      ''                                    as Ledger,
      ''                                    as CompanyCode,
      cast( '0000' as abap.numc( 4 ))       as FiscalYear,
      ''                                    as SourceLedger,
      ''                                    as AccountingDocument,
      ''                                    as LedgerGLLineItem,
      ''                                    as GLAccountFlowType,
      ''                                    as GLAccountGroup,
      ''                                    as GLAccount,
      ''                                    as GLAccountHierarchy,
      ''                                    as ProfitCenter,
      // ''                                    as CSegment,
      //  ''                                    as Segment,
      ''                                    as FiscalYearVariant,
      cast( '0000000' as abap.numc( 7 ))    as FiscalYearPeriod,
      ''                                    as PostingDate,
      ''                                    as GLAccountType,
      ''                                    as ChartOfAccounts,
      ''                                    as Plant,
      ''                                    as Supplier,
      ''                                    as Customer,
      ''                                    as Material,
      ''                                    as FinancialAccountType,
      cast( 'USD' as abap.cuky )            as CompanyCodeCurrency,
      0.00                                  as AmountInCompanyCodeCurrency,
      cast( '000' as poper preserving type) as FiscalPeriod,
      ''                                    as CQtrPostingDt,
      ''                                    as CMonPostingDt,
      ''                                    as CYrPostingDt,
      ''                                    as CMonDescPostingDt,
      ''                                    as Location,
      ''                                    as Facilities,
      ''                                    as NodeValue,
      ''                                    as Storage,
      0.00                                    as NOI

}
where
  _MSTR.rptid = 'RPT97'
