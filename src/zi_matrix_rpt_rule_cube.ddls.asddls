@AbapCatalog.sqlViewName: 'ZIMATRPTRULECUBE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.buffering.status: #NOT_ALLOWED
@AccessControl.authorizationCheck: #CHECK
@Analytics: { dataCategory: #CUBE }
@Analytics.internalName: #LOCAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions:true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: { dataClass: #MIXED, sizeCategory: #XL, serviceQuality: #D }
//@Analytics.readClassName: 'CL_FINCS_GRA_CUBE_RR' 
@VDM.viewType: #COMPOSITE
@EndUserText.label: 'Consolidation Matrix with Reporting Rule'
define view ZI_MATRIX_RPT_RULE_CUBE
 with parameters
    P_FISCPER                    : fis_jahrper_conv, 
    P_ConsolidationUnitHierarchy : fincs_hryid,
    P_ConsolidationPrftCtrHier   : fincs_hryid,
    P_ConsolidationSegmentHier   : fincs_hryid,
    P_KeyDate                    : vdm_v_key_date,
    P_ConsolidationRptgItemHier  : fincs_rihry,
    P_ConsolidationRptgRuleID    : fincs_rptid,
    P_ChartOfAccount             : fc_itclg 
  as select from ZI_MATRIX_RPT_RULE_SUM(
                   P_FISCPER                      : $parameters.P_FISCPER,
                   P_ConsolidationUnitHierarchy   : $parameters.P_ConsolidationUnitHierarchy,
                   P_ConsolidationPrftCtrHier     : $parameters.P_ConsolidationPrftCtrHier,
                   P_ConsolidationSegmentHier     : $parameters.P_ConsolidationSegmentHier,
                   P_KeyDate                      : $parameters.P_KeyDate,
                   P_ConsolidationRptgItemHier    : $parameters.P_ConsolidationRptgItemHier,
                   P_ConsolidationRptgRuleID      : $parameters.P_ConsolidationRptgRuleID,
                   P_ChartOfAccount               : $parameters.P_ChartOfAccount
                   ) as CNSLDTNFNDNWITHRPTRULE8_2

  //Extension Association
  association [1..1] to E_CnsldtnGroupJrnlEntryItem as _Extension on  $projection.ConsolidationLedger         = _Extension.ConsolidationLedger
                                                                  and $projection.ConsolidationDimension      = _Extension.ConsolidationDimension
                                                                  and $projection.FiscalYear                  = _Extension.FiscalYear
                                                                  and $projection.ConsolidationDocumentNumber = _Extension.CnsldtnGroupJrnlEntry
                                                                  and $projection.ConsolidationPostingItem    = _Extension.CnsldtnGroupJrnlEntryItem

  association [0..1] to I_CnsldtnRptgItem_2           as _RptgItm on  $projection.ConsolidationChartOfAccounts = _RptgItm.ConsolidationChartOfAccounts
                                                                  and $projection.ConsolidationReportingItem   = _RptgItm.ConsolidationReportingItem

{

  @ObjectModel.foreignKey.association: '_Ledger'
  ConsolidationLedger,

  @ObjectModel.foreignKey.association: '_Dimension'
  ConsolidationDimension,

  @Semantics.fiscal.year: true
  FiscalYear,

  ConsolidationDocumentNumber,   //Successor should be CnsldtnGroupJrnlEntry

  ConsolidationPostingItem,

  GLRecordType,

  @ObjectModel.foreignKey.association: '_Version'
  ConsolidationVersion,
  
  @ObjectModel.foreignKey.association: '_VersionElement'
  ConsolidationVersionElement,

  @Semantics.currencyCode:true
  @ObjectModel.foreignKey.association: '_TransactionCurrency'
  TransactionCurrency,

  @Semantics.currencyCode:true
  @ObjectModel.foreignKey.association: '_LocalCurrency'
  LocalCurrency,

  @Semantics.currencyCode:true
  @ObjectModel.foreignKey.association: '_GroupCurrency'
  GroupCurrency,

  @Semantics.unitOfMeasure: true
  @ObjectModel.foreignKey.association: '_BaseUnit'
  BaseUnit,

  @Semantics.fiscal.period: true
  FiscalPeriod,

  @Semantics.fiscal.yearPeriod: true
  FiscalYearPeriod,
  
  @Semantics.fiscal.yearQuarter: true
  FiscalYearQuarter,
  
  @Semantics.fiscal.quarter: true
  FiscalQuarter,
 
  @Semantics.fiscal.yearVariant: true
  FiscalYearVariant,

  PeriodMode,

  @ObjectModel.foreignKey.association: '_DocumentType'
  ConsolidationDocumentType,

  @ObjectModel.foreignKey.association: '_DebitCreditCode'
  DebitCreditCode,

  @ObjectModel.foreignKey.association: '_Company'
  Company,

  @ObjectModel.foreignKey.association: '_CnsldtnUnit'
  ConsolidationUnit,

  //  Cons. Unit Eliminated
  @ObjectModel.foreignKey.association: '_CnsldtnUnitForElimination'
  ConsolidationUnitForElim,

  @ObjectModel.foreignKey.association: '_ChartOfAccounts'
  ConsolidationChartOfAccounts,

  //Test 1811
  @ObjectModel.foreignKey.association: '_CnsldtnFSItem_2'
  FinancialStatementItem,

  //  @ObjectModel.foreignKey.association: '_FSItem'
  //  FSItemNew,

  @ObjectModel.foreignKey.association: '_PartnerUnit'
  PartnerConsolidationUnit,

  @ObjectModel.foreignKey.association: '_CnsldtnGroup'
  ConsolidationGroup,

  @ObjectModel.foreignKey.association: '_CompanyCode'
  CompanyCode,

  @ObjectModel.foreignKey.association: '_SubItemCategory'
  SubItemCategory,

  @ObjectModel.foreignKey.association: '_SubItem'
  SubItem,

  @ObjectModel.foreignKey.association: '_PostingLevel'
  PostingLevel,

  //  _PostingLevel.ConsolidationReportingLevel,
  // cast('' as fincs_reporting_level)    as  CnsldtnReportingLevel,

  @ObjectModel.foreignKey.association: '_Apportionment'
  ConsolidationApportionment,

  @ObjectModel.foreignKey.association: '_CrcyCnvrsnDiffType'
  CurrencyConversionsDiffType,

  @Semantics.fiscal.year: true
  ConsolidationAcquisitionYear,

  @Semantics.fiscal.period: true
  ConsolidationAcquisitionPeriod,

  @ObjectModel.foreignKey.association: '_InvesteeUnit'
  InvesteeConsolidationUnit,

  @ObjectModel.foreignKey.association: '_InvestorUnit'
  InvestorConsolidationUnit,
  
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @Analytics.excludeFromRuntimeExtensibilty: true
  CurrPeriodAmt,

  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @Analytics.excludeFromRuntimeExtensibilty: true
  PrevPeriodAmt,
  
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @Analytics.excludeFromRuntimeExtensibilty: true
  CurrYTDAmt,
  
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @Analytics.excludeFromRuntimeExtensibilty: true
  PrevYTDAmt,
  
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'GroupCurrency'
  @Analytics.excludeFromRuntimeExtensibilty: true
  PrevYR2YTDAmt,

  DocumentItemText,

  ConsolidationPostgItemAutoFlag,

  BusinessTransactionType,

  PostingDate,

  CurrencyTranslationDate,

  RefConsolidationDocumentNumber,

  ReferenceFiscalYear,

  RefConsolidationPostingItem,

  RefConsolidationDocumentType,

  RefBusinessTransactionType,

  CreationDate,

  CreationTime,

  UserID,

  ReverseDocument,

  ReversedDocument,

  InvestmentActivityType,

  InvestmentActivity,

  ConsolidationDocReversalYear,

  ReferenceDocumentType,

  ReferenceDocumentContext,

  LogicalSystem,

  @ObjectModel.foreignKey.association: '_GLChartOfAccounts'
  ChartOfAccounts,

  @ObjectModel.foreignKey.association: '_GLAccountInChartOfAccounts'
  GLAccount,

  AssignmentReference,

  @ObjectModel.foreignKey.association: '_CostCenter'
  CostCenter,

  @ObjectModel.foreignKey.association: '_ProfitCenter'
  ProfitCenter,

  @ObjectModel.foreignKey.association: '_ProfitCenterForElim'
  ConsolidationPrftCtrForElim,

  @ObjectModel.foreignKey.association: '_FunctionalArea'
  FunctionalArea,

  @ObjectModel.foreignKey.association: '_BusinessArea'
  BusinessArea,

  @ObjectModel.foreignKey.association: '_ControllingArea'
  ControllingArea,

  @ObjectModel.foreignKey.association: '_Segment'
  Segment,

  @ObjectModel.foreignKey.association: '_SegmentForElim'
  ConsolidationSegmentForElim,

  @ObjectModel.foreignKey.association: '_PartnerCostCenter'
  PartnerCostCenter,

  @ObjectModel.foreignKey.association: '_PartnerProfitCenter'
  PartnerProfitCenter,

  @ObjectModel.foreignKey.association: '_PartnerFunctionalArea'
  PartnerFunctionalArea,

  @ObjectModel.foreignKey.association: '_PartnerBusinessArea'
  PartnerBusinessArea,

  @ObjectModel.foreignKey.association: '_PartnerCompany'
  PartnerCompany,

  @ObjectModel.foreignKey.association: '_PartnerSegment'
  PartnerSegment,

  @ObjectModel.foreignKey.association: '_InternalOrder'
  OrderID,

  @ObjectModel.foreignKey.association: '_Customer'
  Customer,

  @ObjectModel.foreignKey.association: '_Supplier'
  Supplier,

  @ObjectModel.foreignKey.association: '_Material'
  Material,

  @ObjectModel.foreignKey.association: '_Plant'
  Plant,

  @ObjectModel.foreignKey.association: '_FinancialTransactionType'
  FinancialTransactionType,

  @ObjectModel.foreignKey.association: '_WBSElementInternalID'
  WBSElementInternalID,

  //  @ObjectModel.foreignKey.association: '_WBSElement'
  //  WBSElement,

  @ObjectModel.foreignKey.association: '_WBSElement'
  WBSElementExternalID,

  @ObjectModel.foreignKey.association: '_Project'
  Project,

  //  ConsolidationRecordNumber,

  // Enhanced
  @ObjectModel.foreignKey.association: '_RptgItm'
  ConsolidationReportingItem,
 
  //  CnsldtnReverseSign,

  /*** 1802CE: Begin Of Additional Fields in Consolidation Journal Entries in S/4 ***/
  @ObjectModel.foreignKey.association: '_BillingDocumentType'
  BillingDocumentType,
  @ObjectModel.foreignKey.association: '_SalesOrganization'
  SalesOrganization,
  @ObjectModel.foreignKey.association: '_DistributionChannel'
  DistributionChannel,
  @ObjectModel.foreignKey.association: '_Division'
  OrganizationDivision,
  @ObjectModel.foreignKey.association: '_MaterialGroup'
  MaterialGroup,
  @ObjectModel.foreignKey.association: '_SoldProduct'
  SoldProduct,
  @ObjectModel.foreignKey.association: '_SoldProductGroup'
  SoldProductGroup,
  @ObjectModel.foreignKey.association: '_CustomerGroup'
  CustomerGroup,
  @ObjectModel.foreignKey.association: '_Country'
  CustomerSupplierCountry,
  @ObjectModel.foreignKey.association: '_Industry'
  CustomerSupplierIndustry,
  @ObjectModel.foreignKey.association: '_SalesDistrict'
  SalesDistrict,
  @ObjectModel.foreignKey.association: '_BillToParty'
  BillToParty,
  @ObjectModel.foreignKey.association: '_ShipToParty'
  ShipToParty,

  // Additionnal Flieds: AdHoc Item
  @ObjectModel.foreignKey.association: '_AdhocItem'
  CnsldtnAdhocItem,
  @ObjectModel.foreignKey.association: '_AdhocSet'
  CnsldtnAdhocSet,
  @ObjectModel.foreignKey.association: '_AdhocSetItem'
  CnsldtnAdhocSetItem,

  MatchingReasonCode,
  OriginType,
  OriginReference,
  
  CnsldtnGroupJrnlEntryBundle,

  CustomerSupplierCorporateGroup,

  _Ledger,

  _Dimension,

  _Version,
  
  _VersionElement,

  _Company,

  _CnsldtnUnit,

  //  Cons. Unit Eliminated
  _CnsldtnUnitForElimination,

  _CnsldtnGroup,

  _RptgItm,

  _ChartOfAccounts,

   @API.element.releaseState: #DEPRECATED
   @API.element.successor: '_CnsldtnFSItem_2'  
  _FinStmntItm,
  _CnsldtnFSItem_2,

  _GLAccountInChartOfAccounts,

  //  _GLAccountInCompanyCode,

  _GLChartOfAccounts,

  _PartnerUnit,

  _CompanyCode,

  _SubItemCategory,

  _SubItem,

  _DebitCreditCode,

  _DocumentType,

  _PostingLevel,

  //  _PostingLevel._ReportingLevel,

  _InvesteeUnit,

  _InvestorUnit,

  _Apportionment,

  _CrcyCnvrsnDiffType,

  _TransactionCurrency,

  _LocalCurrency,

  _GroupCurrency,

  _BaseUnit,

  _InternalOrder,

  _Customer,

  _Supplier,

  _Material,

  _MaterialGroup,

  _Plant,

  _FinancialTransactionType,

  _WBSElement,

  _WBSElementInternalID,

  _Project,

  _CostCenter,

  _ProfitCenter,

  //  Profit Center Eliminated
  _ProfitCenterForElim,

  _FunctionalArea,

  _BusinessArea,

  _ControllingArea,

  _Segment,

  //  Segment Eliminated
  _SegmentForElim,

  _PartnerCostCenter,

  _PartnerProfitCenter,

  _PartnerFunctionalArea,

  _PartnerBusinessArea,

  _PartnerCompany,

  _PartnerSegment,

  _BillingDocumentType,

  _SalesOrganization,

  _DistributionChannel,

  _Division,

  _SoldProduct,

  _SoldProductGroup,

  _CustomerGroup,

  _Country,

  _Industry,

  _SalesDistrict,

  _BillToParty,

  _ShipToParty,
  _AdhocItem,
  _AdhocSet,
  _AdhocSetItem
}
 
