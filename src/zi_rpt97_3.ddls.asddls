@AbapCatalog.sqlViewName: 'ZV_RPT973'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 97'
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
define view ZI_RPT97_3
  with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
  as select from ZI_RPT_97_1
                 ( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate ) as _SS
  association [0..*] to ZI_MNODE_TXT as _MText on  $projection.mainnode = _MText.Mainnode
                                               and _MText.ReportId      = 'RPT97'
  //

  association [0..*] to ZI_SNODE_TXT as _SText on  $projection.mainnode = _SText.MainNode
                                               and $projection.subnode  = _SText.SubNode
                                               and _SText.ReportId      = 'RPT97'
{
key _SS.counter,
key _SS.mainnode,
key _SS.subnode,
key _SS.Ledger,
key _SS.CompanyCode,
key _SS.FiscalYear,
key _SS.SourceLedger,
key _SS.AccountingDocument,
key _SS.LedgerGLLineItem,
key _SS.GLAccountFlowType,
_SS.GLAccountGroup,
_SS.GLAccount,
_SS.GLAccountHierarchy,
_SS.ProfitCenter,
_SS.FiscalYearVariant,
_SS.FiscalYearPeriod,
_SS.PostingDate,
_SS.GLAccountType,
_SS.ChartOfAccounts,
_SS.Plant,
_SS.Supplier,
_SS.Customer,
_SS.Material,
_SS.FinancialAccountType,
_SS.CompanyCodeCurrency,
_SS.AmountInCompanyCodeCurrency,
_SS.FiscalPeriod,
_SS.CQtrPostingDt,
_SS.CMonPostingDt,
_SS.CYrPostingDt,
_SS.CMonDescPostingDt,
_SS.Location,
_SS.Facilities,
_SS.NodeValue,
_SS.Storage,
_SS.NOI,
@AnalyticsDetails.query.axis: #ROWS
_MText.Mainnodetxt,
@AnalyticsDetails.query.axis: #ROWS
_SText.subnodetxt,
_SText,
_MText
 } 
