@AbapCatalog.sqlViewName: 'ZBRPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developed and Extended Facilities1'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZB_RPT_0095 
with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
       
as select from I_GLAcctBalance
( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )
                                                                                                                    
 {
  key Ledger,
  key CompanyCode,
  key FiscalYear,
  key SourceLedger,
  key AccountingDocument,
  key LedgerGLLineItem,
  key GLAccountFlowType,
  key FiscalPeriodDate,

  LedgerFiscalYear,
  FinancialTransactionType,
  BusinessTransactionType,
  ReferenceDocumentType,
  LogicalSystem,
  ReferenceDocumentContext,
  ReferenceDocument,
  ReferenceDocumentItem,
  ReferenceDocumentItemGroup,
  IsReversal,
  IsReversed,
  ReversalReferenceDocumentCntxt,
  ReversalReferenceDocument,
  IsSettlement,
  IsSettled,
  PredecessorReferenceDocType,
  PredecessorReferenceDocCntxt,
  PredecessorReferenceDocument,
  PredecessorReferenceDocItem,
  GLAccount,
  GLAccountHierarchy,
  ProfitCenter,
  FunctionalArea,
  BusinessArea,
  ControllingArea,
  I_GLAcctBalance.Segment,
  PartnerCostCenter,
  PartnerProfitCenter,
  PartnerFunctionalArea,
  PartnerBusinessArea,
  PartnerCompany,
  PartnerSegment,
  DebitCreditCode,
  FiscalYearVariant,
  FiscalYearPeriod,
  PostingDate,
  AccountingDocumentType,
  AccountingDocumentItem,
  AssignmentReference,
  PostingKey,
  AccountingDocumentCategory,
  TransactionTypeDetermination,
  SubLedgerAcctLineItemType,
  AccountingDocCreatedByUser,
  EliminationProfitCenter,
  OriginObjectType,
  GLAccountType,
  ChartOfAccounts,
  AlternativeGLAccount,
  CountryChartOfAccounts,
  CreationDateTime,
  InvoiceReference,
  InvoiceReferenceFiscalYear,
  FollowOnDocumentType,
  InvoiceItemReference,
  ReferencePurchaseOrderCategory,
  PurchasingDocument,
  PurchasingDocumentItem,
  AccountAssignmentNumber,
  DocumentItemText,
  Plant,
  Supplier,
  Customer,
  Material,
  Product,
  SoldMaterial,
  SoldProduct,
  MaterialGroup,
  SoldProductGroup,
  ProductGroup,
  FinancialAccountType,
  SpecialGLCode,
  TaxCode,
  HouseBank,
  HouseBankAccount,
  IsOpenItemManaged,
  ClearingAccountingDocument,
  ClearingDocFiscalYear,
  ClearingJournalEntry,
  ClearingJournalEntryFiscalYear,
  AssetDepreciationArea,
  MasterFixedAsset,
  FixedAsset,
  AssetValueDate,
  AssetTransactionType,
  AssetAcctTransClassfctn,
  DepreciationFiscalPeriod,
  GroupMasterFixedAsset,
  GroupFixedAsset,
  CostEstimate,
  InventorySpecialStockValnType,
  InvtrySpecialStockValnType_2,
  InventorySpecialStockType,
  InventorySpclStkSalesDocument,
  InventorySpclStkSalesDocItm,
  InvtrySpclStockWBSElmntIntID,
  InvtrySpclStockWBSElmntExtID,
  InventorySpclStockWBSElement,
  InventorySpecialStockSupplier,
  InventoryValuationType,
  ValuationArea,
  SenderCompanyCode,
  SenderGLAccount,
  SenderAccountAssignment,
  SenderAccountAssignmentType,
  ControllingObjectDebitType,
  QuantityIsIncomplete,
  OffsettingAccount,
  OffsettingAccountType,
  OffsettingChartOfAccounts,
  LineItemIsCompleted,
  PersonnelNumber,
  ControllingObjectClass,
  PartnerCompanyCode,
  PartnerControllingObjectClass,
  OriginCostCenter,
  OriginCostCtrActivityType,
  OriginProduct,
  VarianceOriginGLAccount,
  AccountAssignment,
  AccountAssignmentType,
  ProjectNetwork,
  RelatedNetworkActivity,
  BusinessProcess,
  CostObject,
  CustomerServiceNotification,
  ServiceDocumentType,
  ServiceDocument,
  ServiceDocumentItem,
  PartnerServiceDocumentType,
  PartnerServiceDocument,
  PartnerServiceDocumentItem,
  ServiceContractType,
  ServiceContract,
  ServiceContractItem,
  TimeSheetOvertimeCategory,
  OperatingConcern,
  PartnerAccountAssignment,
  PartnerAccountAssignmentType,
  PartnerCostCtrActivityType,
  PartnerOrder,
  PartnerOrderCategory,
  PartnerWBSElement,
  PartnerProject,
  PartnerSalesDocument,
  PartnerSalesDocumentItem,
  PartnerProjectNetwork,
  PartnerProjectNetworkActivity,
  PartnerBusinessProcess,
  PartnerCostObject,
  BillingDocumentType,
  SalesOrganization,
  DistributionChannel,
  OrganizationDivision,
  CustomerGroup,
  JointVenture,
  JointVentureEquityGroup,
  JointVentureCostRecoveryCode,
  JointVentureEquityType,
  SettlementReferenceDate,
  CostCenter,
  CostCtrActivityType,
  OrderID,
  OrderCategory,
  WBSElementInternalID,
  WBSElementExternalID,
  WBSElement,
  PartnerWBSElementInternalID,
  PartnerWBSElementExternalID,
  Project,
  ProjectInternalID,
  ProjectExternalID,
  PartnerProjectInternalID,
  PartnerProjectExternalID,
  SalesOrder,
  SalesOrderItem,
  SalesDocument,
  SalesDocumentItem,
  ClearingDate,
  ConsolidationUnit,
  PartnerConsolidationUnit,
  Company,
  ConsolidationChartOfAccounts,
  CnsldtnFinancialStatementItem,
  CnsldtnSubitemCategory,
  CnsldtnSubitem,
  JrnlEntryItemObsoleteReason,
  BalanceTransactionCurrency,
  AmountInBalanceTransacCrcy,
  TransactionCurrency,
  AmountInTransactionCurrency,
  CompanyCodeCurrency,
  AmountInCompanyCodeCurrency,
  GlobalCurrency,
  @DefaultAggregation: #SUM
  AmountInGlobalCurrency,

  FunctionalCurrency,
  AmountInFunctionalCurrency,
  FreeDefinedCurrency1,
  AmountInFreeDefinedCurrency1,
  FreeDefinedCurrency2,
  AmountInFreeDefinedCurrency2,
  FreeDefinedCurrency3,
  AmountInFreeDefinedCurrency3,
  FreeDefinedCurrency4,
  AmountInFreeDefinedCurrency4,
  FreeDefinedCurrency5,
  AmountInFreeDefinedCurrency5,
  FreeDefinedCurrency6,
  AmountInFreeDefinedCurrency6,
  FreeDefinedCurrency7,
  AmountInFreeDefinedCurrency7,
  FreeDefinedCurrency8,
  AmountInFreeDefinedCurrency8,
  DebitAmountInCoCodeCrcy,
  CreditAmountInCoCodeCrcy,
  DebitAmountInTransCrcy,
  CreditAmountInTransCrcy,
  DebitAmountInBalanceTransCrcy,
  CreditAmountInBalanceTransCrcy,
  DebitAmountInGlobalCrcy,
  CreditAmountInGlobalCrcy,
  DebitAmountInFunctionalCrcy,
  CreditAmountInFunctionalCrcy,
  DebitAmountInFreeDefinedCrcy1,
  CreditAmountInFreeDefinedCrcy1,
  DebitAmountInFreeDefinedCrcy2,
  CreditAmountInFreeDefinedCrcy2,
  DebitAmountInFreeDefinedCrcy3,
  CreditAmountInFreeDefinedCrcy3,
  DebitAmountInFreeDefinedCrcy4,
  CreditAmountInFreeDefinedCrcy4,
  DebitAmountInFreeDefinedCrcy5,
  CreditAmountInFreeDefinedCrcy5,
  DebitAmountInFreeDefinedCrcy6,
  CreditAmountInFreeDefinedCrcy6,
  DebitAmountInFreeDefinedCrcy7,
  CreditAmountInFreeDefinedCrcy7,
  DebitAmountInFreeDefinedCrcy8,
  CreditAmountInFreeDefinedCrcy8,
  FiscalPeriod,
  EndingBalanceAmtInCoCodeCrcy,
  EndingBalanceAmtInTransCrcy,
  EndingBalanceAmtInBalTransCrcy,
  EndingBalanceAmtInGlobalCrcy,
  EndingBalanceAmtInFuncnlCrcy,
  EndingBalAmtInFreeDfndCrcy1,
  EndingBalAmtInFreeDfndCrcy2,
  EndingBalAmtInFreeDfndCrcy3,
  EndingBalAmtInFreeDfndCrcy4,
  EndingBalAmtInFreeDfndCrcy5,
  EndingBalAmtInFreeDfndCrcy6,
  EndingBalAmtInFreeDfndCrcy7,
  EndingBalAmtInFreeDfndCrcy8,
  AccrualObjectType,
  AccrualObject,
  AccrualSubobject,
  AccrualItemType,
  AccrualObjectLogicalSystem,
  AccrualReferenceObject,
  AccrualValueDate,
  CashLedgerCompanyCode,
  CashLedgerAccount,
  FinancialManagementArea,
  FundsCenter,
  FundedProgram,
  Fund,
  GrantID,
  BudgetPeriod,
  PartnerFund,
  PartnerGrant,
  PartnerBudgetPeriod,
  PubSecBudgetAccount,
  PubSecBudgetAccountCoCode,
  PubSecBudgetCnsmpnDate,
  PubSecBudgetCnsmpnFsclPeriod,
  PubSecBudgetCnsmpnFsclYear,
  PubSecBudgetIsRelevant,
  PubSecBudgetCnsmpnType,
  PubSecBudgetCnsmpnAmtType,
  FlowOfFundsLedgerFiscalYear,
  GLAccountAuthorizationGroup,
  SupplierBasicAuthorizationGrp,
  CustomerBasicAuthorizationGrp,
  AcctgDocTypeAuthorizationGroup,
  OrderType,
  SalesOrderType,
  AssetClass,
  /* Associations */
  _AccountingDocumentCategory,
  _AccountingDocumentType,
  _AccrualItemType,
  _AccrualObject,
  _AccrualObjectType,
  _AccrualSubobject,
  _AlternativeGLAccount,
  _AssetTransactionType,
  _BalanceTransactionCurrency,
  _BillingDocumentType,
  _BudgetPeriod,
  _BusinessArea,
  _BusinessProcess,
  _BusinessTransactionType,
  _CalendarDate,
  _CashLedgerAccount,
  _CashLedgerCompanyCode,
  _ChartOfAccounts,
  _ClearingAccountingDocument,
  _ClearingJournalEntry,
  _ClearingJrnlEntryFiscalYear,
  _CnsldtnFinancialStatementItem,
  _CnsldtnSubitem,
  _CnsldtnSubitemCategory,
  _Company,
  _CompanyCode,
  _CompanyCodeCurrency,
  _ConsolidationChartOfAccounts,
  _ConsolidationUnit,
  _ControllingArea,
  _ControllingObjectClass,
  _CostCenter,
  _CostCtrActivityType,
  _CountryChartOfAccounts,
  _CurrentCostCenter,
  _CurrentProfitCenter,
  _Customer,
  _CustomerCompany,
  _CustomerGroup,
  _DebitCreditCode,
  _DistributionChannel,
  _EliminationProfitCenter,
  _Employment,
  _FinancialAccountType,
  _FinancialManagementArea,
  _FinancialTransactionType,
  _FiscalCalendarDate,
  _FiscalYear,
  _FiscalYearVariant,
  _FixedAsset,
  _FreeDefinedCurrency1,
  _FreeDefinedCurrency2,
  _FreeDefinedCurrency3,
  _FreeDefinedCurrency4,
  _FreeDefinedCurrency5,
  _FreeDefinedCurrency6,
  _FreeDefinedCurrency7,
  _FreeDefinedCurrency8,
  _FunctionalArea,
  _FunctionalCurrency,
  _Fund,
  _FundedProgram,
  _FundsCenter,
  _GLAccountFlowType,
  _GLAccountHierarchy,
  _GLAccountInChartOfAccounts,
  _GLAccountInCompanyCode,
  _GLAccountType,
  _GlobalCurrency,
  _Grant,
  _GroupFixedAsset,
  _GroupMasterFixedAsset,
  _HouseBank,
  _HouseBankAccount,
  _InternalOrder,
  _InventorySpclStkSalesDocItm,
  _InventorySpclStkSalesDocument,
  _InventorySpclStockValnType,
  _InventorySpclStockWBSElement,
  _InventorySpecialStockSupplier,
  _InventorySpecialStockType,
  _InventorySpecialStockValnType,
  _InventoryValuationType,
  _InvtrySpclStkWBSElmntBscData,
  _InvtrySpclStockWBSElmntBD,
  _InvtrySpclStockWBSElmntExtID,
  _InvtrySpclStockWBSElmntIntID,
  _JournalEntry,
  _Ledger,
  _LedgerCompanyCodeCrcyRoles,
  _LogicalSystem,
  _MasterFixedAsset,
  _Material,
  _MaterialGroup,
  _MovementCategory,
  _OffsettingAccount,
  _OffsettingAccountType,
  _OffsettingAccountWithBP,
  _OffsettingChartOfAccounts,
  _OperatingConcern,
  _Order,
  _OrderCategory,
  _OriginCostCenter,
  _OriginCostCtrActivityType,
  _PartnerBudgetPeriod,
  _PartnerBusinessArea,
  _PartnerBusinessProcess,
  _PartnerCompany,
  _PartnerCompanyCode,
  _PartnerConsolidationUnit,
  _PartnerControllingObjectClass,
  _PartnerCostCenter,
  _PartnerCostCtrActivityType,
  _PartnerFunctionalArea,
  _PartnerFund,
  _PartnerGrant,
  _PartnerOrder,
  _PartnerOrderCategory,
  _PartnerOrder_2,
  _PartnerProfitCenter,
  _PartnerProjctExtrnalIDText,
  _PartnerProject,
  _PartnerProjectBasicData,
  _PartnerProjectBasicDataText,
  _PartnerProjectExternalID,
  _PartnerSalesDocument,
  _PartnerSalesDocumentItem,
  _PartnerSegment,
  _PartnerServiceDocument,
  _PartnerServiceDocumentItem,
  _PartnerServiceDocumentType,
  _PartnerWBSElement,
  _PartnerWBSElementBasicData,
  _PartnerWBSElementExternalID,
  _PartnerWBSElemntExtrnalIDText,
  _PartnerWBSElmntBasicDataText,
  _PersonWorkAgreement_1,
  _Plant,
  _PostingKey,
  _PredecessorReferenceDocType,
  _Product,
  _ProductGroup,
  _ProjectExternalID,
  _ProjectNetwork,
  _PubSecBudgetAccount,
  _PubSecBudgetAccountCoCode,
  _PubSecBudgetCnsmpnAmtType,
  _PubSecBudgetCnsmpnDate,
  _PubSecBudgetCnsmpnFsclPeriod,
  _PubSecBudgetCnsmpnFsclYear,
  _PubSecBudgetCnsmpnType,
  _PurchasingDocument,
  _PurchasingDocumentItem,
  _PurReqValuationArea,
  _ReferenceDocumentType,
  _SalesDocument,
  _SalesDocumentItem,
  _SalesOrder,
  _SalesOrderItem,
  _SalesOrganization,
  _Segment,
  _SenderGLAccount,
  _ServiceContract,
  _ServiceContractItem,
  _ServiceContractType,
  _ServiceDocument,
  _ServiceDocumentItem,
  _ServiceDocumentType,
  _SoldMaterial,
  _SoldProduct,
  _SoldProductGroup,
  _SoldProductGroup_2,
  _SourceLedger,
  _SpecialGLCode,
  _Supplier,
  _SupplierCompany,
  _TaxCode,
  _TimeSheetOvertimeCat,
  _TransactionCurrency,
  _User,
  _WBSElement,
  _WBSElementBasicData,
  _WBSElementExternalID,
  _WBSElementInternalID,
 
  case substring($parameters.P_ToPostingDate,5,2) when  '01' then '1'
             when  '02' then '1'
              when  '03' then '1'
              when  '04' then '2'
              when  '05' then '2'
              when  '06' then '2'
              when  '07' then '3'
              when  '08' then '3'
              when  '09' then '3'
              when  '10' then '4'
              when  '11' then '4'
              when  '12' then '4'
               else ''
                 end                               as ZQUARTER,
   substring($parameters.P_ToPostingDate,5,2)      as ZMONTH,
   
   case substring($parameters.P_ToPostingDate,5,2) when  '01' then 'Jan'
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
                   else ''
                     end                          as ZMONTH1,
                     
   substring($parameters.P_ToPostingDate,1,4)     as ZYEAR,
   
   substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),1,4) as ZLYEAR,
   substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-730,'NULL'),1,4) as ZL2LYEAR,
   
   DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL') as LastYearDate,
   substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),5,2) as ZLYMTH,
   substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-730,'NULL'),5,2) as ZL2LYMTH,
   
   case substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),5,2) 
                  when  '01' then '1'
                  when  '02' then '1'
                  when  '03' then '1'
                  when  '04' then '2'
                  when  '05' then '2'
                  when  '06' then '2'
                  when  '07' then '3'
                  when  '08' then '3'
                  when  '09' then '3'
                  when  '10' then '4'
                  when  '11' then '4'
                  when  '12' then '4'
                   else '' end                             as ZLQUARTER,
                   
   case substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-730,'NULL'),5,2) 
                  when  '01' then '1'
                  when  '02' then '1'
                  when  '03' then '1'
                  when  '04' then '2'
                  when  '05' then '2'
                  when  '06' then '2'
                  when  '07' then '3'
                  when  '08' then '3'
                  when  '09' then '3'
                  when  '10' then '4'
                  when  '11' then '4'
                  when  '12' then '4'
                   else '' end                             as ZL2LYQTR            
    
} where SourceLedger = '0L' and Ledger = '0L' and GLAccountFlowType = '2'
