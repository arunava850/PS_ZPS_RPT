@AbapCatalog.sqlViewName: 'ZIVRPT019_2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RPT0019 SameStore 5Quarter'
@Analytics.dataCategory: #CUBE
@ObjectModel:{
  usageType: {
    dataClass: #CUSTOMIZING,
    serviceQuality: #C,
    sizeCategory: #S},
  representativeKey: 'ConsolidationLedger',
  modelingPattern: #ANALYTICAL_DIMENSION,
  supportedCapabilities: [#CDS_MODELING_DATA_SOURCE,
                          #CDS_MODELING_ASSOCIATION_TARGET,
                          #SQL_DATA_SOURCE,
                          #ANALYTICAL_DIMENSION ]
  }

@VDM.viewType: #COMPOSITE
define view ZI_RPT_019_SS5QTR_2
  with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
  as select from ZI_RPT_019_SS5QTR
                  ( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate ) as _ss
  association [0..*] to ZI_MNODE_TXT as _MText on  $projection.mainnode = _MText.Mainnode
                                               and _MText.ReportId      = 'RPT19'
  //

  association [0..*] to ZI_SNODE_TXT as _SText on  $projection.mainnode = _SText.MainNode
                                               and $projection.subnode  = _SText.SubNode
                                               and _SText.ReportId      = 'RPT19'
  //


{
  key _ss.counter,
  key _ss.mainnode,
  key _ss.subnode,
  key _ss.Ledger,
  key _ss.CompanyCode,
  key _ss.FiscalYear,
  key _ss.SourceLedger,
  key _ss.AccountingDocument,
  key _ss.LedgerGLLineItem,
  key _ss.GLAccountFlowType,
      _ss.GLAccountGroup,
      _ss.GLAccount,
      _ss.GLAccountHierarchy,
      _ss.ProfitCenter,
      _ss.FiscalYearVariant,
      _ss.FiscalYearPeriod,
      _ss.PostingDate,
      _ss.GLAccountType,
      _ss.ChartOfAccounts,
      _ss.Plant,
      _ss.Supplier,
      _ss.Customer,
      _ss.Material,
      _ss.FinancialAccountType,
      _ss.CompanyCodeCurrency,
      @DefaultAggregation: #SUM
      _ss.AmountInCompanyCodeCurrency,
      _ss.FiscalPeriod,
      _ss.CQtrPostingDt,
      _ss.CMonPostingDt,
      _ss.CYrPostingDt,
      _ss.CMonDescPostingDt,
      _SText.subnodetxt  as SubNodeTxt,
      _MText.Mainnodetxt as MainNodeTxt,
      _MText,
      _SText
}
