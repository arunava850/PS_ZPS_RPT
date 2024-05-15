@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'ZIGLCRDBAL'
@VDM.viewType: #COMPOSITE
@VDM.private: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass:  #MIXED
@ObjectModel.usageType.serviceQuality: #D
@AbapCatalog.buffering.status: #NOT_ALLOWED
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@Metadata.ignorePropagatedAnnotations: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Public Storage GL Debit/Credit Balance'
define view ZI_GLCRDB_BAL
as select from I_GLAccountLineItem
left outer to one join I_TrialBalanceUserParam
  on I_TrialBalanceUserParam.UserID = $session.user
left outer to one join I_YrEndClsgPostingUserParam
  on I_YrEndClsgPostingUserParam.UserID = $session.user
inner join P_FiscalYearPeriod
on I_GLAccountLineItem.FiscalYearVariant = P_FiscalYearPeriod.fiscal_year_variant and
   I_GLAccountLineItem.LedgerFiscalYear = P_FiscalYearPeriod.fiscal_year and
   I_GLAccountLineItem.FiscalPeriod = P_FiscalYearPeriod.fiscal_period

association [0..1] to I_WBSElementByExternalID       as _WBSElementExternalID        on  $projection.WBSElementExternalID = _WBSElementExternalID.WBSElementExternalID
association [0..1] to I_WBSElementByExternalID       as _WBSElementExternalIDText    on  $projection.WBSElementExternalID = _WBSElementExternalIDText.WBSElementExternalID

association [0..1] to I_ProjectBasicData             as _ProjectBasicData              on  $projection.ProjectInternalID = _ProjectBasicData.ProjectInternalID
association [0..1] to I_ProjectBasicData             as _ProjectBasicDataText          on  $projection.ProjectInternalID = _ProjectBasicDataText.ProjectInternalID
association [0..1] to I_ProjectBasicData             as _PartnerProjectBasicData       on  $projection.PartnerProjectInternalID = _PartnerProjectBasicData.ProjectInternalID
association [0..1] to I_ProjectBasicData             as _PartnerProjectBasicDataText   on  $projection.PartnerProjectInternalID = _PartnerProjectBasicDataText.ProjectInternalID

association [0..1] to I_WBSElementBasicData          as _WBSElementBasicData           on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID
association [0..1] to I_WBSElementBasicData          as _WBSElementBasicDataText       on  $projection.WBSElementInternalID = _WBSElementBasicDataText.WBSElementInternalID
association [0..1] to I_WBSElementBasicData          as _PartnerWBSElementBasicData    on  $projection.PartnerWBSElementInternalID = _PartnerWBSElementBasicData.WBSElementInternalID
association [0..1] to I_WBSElementBasicData          as _PartnerWBSElmntBasicDataText  on  $projection.PartnerWBSElementInternalID = _PartnerWBSElmntBasicDataText.WBSElementInternalID

association [0..1] to I_WBSElementByExternalID       as _PartnerWBSElementExternalID        on  $projection.PartnerWBSElementExternalID = _PartnerWBSElementExternalID.WBSElementExternalID
association [0..1] to I_WBSElementByExternalID       as _PartnerWBSElemntExtrnalIDText    on  $projection.PartnerWBSElementExternalID = _PartnerWBSElemntExtrnalIDText.WBSElementExternalID
//
association [0..1] to I_ProjectByExternalID       as _PartnerProjectExternalID        on  $projection.PartnerProjectExternalID   = _PartnerProjectExternalID.ProjectExternalID
association [0..1] to I_ProjectByExternalID       as _PartnerProjctExtrnalIDText    on  $projection.PartnerProjectExternalID   = _PartnerProjctExtrnalIDText.ProjectExternalID

association [0..1] to I_ProjectByExternalID         as _ProjectExternalID             on  $projection.ProjectExternalID = _ProjectExternalID.ProjectExternalID
association [0..1] to I_ProjectByExternalID         as _ProjectExternalIDText         on  $projection.ProjectExternalID = _ProjectExternalIDText.ProjectExternalID


association [0..1] to I_WBSElementBasicData          as _InvtrySpclStockWBSElmntBD   on  $projection.InvtrySpclStockWBSElmntIntID = _InvtrySpclStockWBSElmntBD.WBSElementInternalID
association [0..1] to I_WBSElementByExternalID       as _InvtrySpclStockWBSElmntExtID  on  $projection.InvtrySpclStockWBSElmntExtID = _InvtrySpclStockWBSElmntExtID.WBSElementExternalID
{
    //I_GLAccountLineItem
    key SourceLedger,
    key CompanyCode,
    key FiscalYearPeriod, 
    key FiscalYear,
    key AccountingDocument,
    key LedgerGLLineItem,
    key Ledger,
    FiscalPeriod,
    FiscalYearVariant,  
    LedgerFiscalYear,
    GLRecordType,
    ChartOfAccounts,
    ControllingArea,
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
    SourceReferenceDocumentType,
    SourceLogicalSystem,
    SourceReferenceDocumentCntxt,
    SourceReferenceDocument,
    SourceReferenceDocumentItem,
    SourceReferenceDocSubitem,
    IsCommitment,
    JrnlEntryItemObsoleteReason,
    GLAccount,
    CostCenter,
    ProfitCenter,
    FunctionalArea,
    BusinessArea,
    Segment,
    PartnerCostCenter,
    PartnerProfitCenter,
    PartnerFunctionalArea,
    PartnerBusinessArea,
    PartnerCompany,
    PartnerSegment,
    BalanceTransactionCurrency,
    AmountInBalanceTransacCrcy,
    TransactionCurrency,
    AmountInTransactionCurrency,
    CompanyCodeCurrency,
    AmountInCompanyCodeCurrency,
    GlobalCurrency,
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
    FixedAmountInGlobalCrcy,
    GrpValnFixedAmtInGlobCrcy,
    PrftCtrValnFxdAmtInGlobCrcy,
    TotalPriceVarcInGlobalCrcy,
    GrpValnTotPrcVarcInGlobCrcy,
    PrftCtrValnTotPrcVarcInGlbCrcy,
    FixedPriceVarcInGlobalCrcy,
    GrpValnFixedPrcVarcInGlobCrcy,
    PrftCtrValnFxdPrcVarcInGlbCrcy,
    ControllingObjectCurrency,
    AmountInObjectCurrency,
    BaseUnit,
    Quantity,
    FixedQuantity,
    CostSourceUnit,
    ValuationQuantity,
    ValuationFixedQuantity,
    AdditionalQuantity1Unit,
    AdditionalQuantity1,
    AdditionalQuantity2Unit,
    AdditionalQuantity2,
    AdditionalQuantity3Unit,
    AdditionalQuantity3,
    DebitCreditCode,
    DocumentDate,
    AccountingDocumentType,
    AccountingDocumentItem,
    AssignmentReference,
    AccountingDocumentCategory,
    PostingKey,
    TransactionTypeDetermination,
    SubLedgerAcctLineItemType,
    AccountingDocCreatedByUser,
    LastChangeDateTime,
    CreationDateTime,
    CreationDate,
    EliminationProfitCenter,
    OriginObjectType,
    GLAccountType,
    AlternativeGLAccount,
    CountryChartOfAccounts,
    InvoiceReference,
    InvoiceReferenceFiscalYear,
    FollowOnDocumentType,
    InvoiceItemReference,
    ReferencePurchaseOrderCategory,
    PurchasingDocument,
    PurchasingDocumentItem,
    AccountAssignmentNumber,
    DocumentItemText,
    SalesOrder,
    SalesOrderItem,
    SalesDocument,
    SalesDocumentItem,
    Product,
    Material,

    SoldProduct,
    SoldMaterial,

    SoldProductGroup,
    MaterialGroup,

    ProductGroup,

    Plant,
    Supplier,
    Customer,
    FinancialAccountType,
    SpecialGLCode,
    TaxCode,
    HouseBank,
    HouseBankAccount,
    IsOpenItemManaged,
    ClearingDate,
    ClearingAccountingDocument,
    ClearingDocFiscalYear,
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
    InventorySpecialStockType,
    InventorySpclStkSalesDocument,
    InventorySpclStkSalesDocItm,
    InvtrySpclStockWBSElmntIntID,
    @ObjectModel.foreignKey.association: '_InvtrySpclStockWBSElmntExtID'
    _InvtrySpclStockWBSElmntBD.WBSElementExternalID as InvtrySpclStockWBSElmntExtID,
    InventorySpclStockWBSElement,
    InventorySpecialStockSupplier,
    InventoryValuationType,
    ValuationArea,
    SenderCompanyCode,
    SenderGLAccount,
    SenderAccountAssignment,
    SenderAccountAssignmentType,
    CostOriginGroup,
    OriginSenderObject,
    ControllingDebitCreditCode,
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
    OriginProfitCenter,
    OriginCostCtrActivityType,
    OriginProduct,
    VarianceOriginGLAccount,
    AccountAssignment,
    AccountAssignmentType,
    CostCtrActivityType,
    OrderID,
    OrderCategory,
    WBSElementInternalID,
    @ObjectModel.foreignKey.association: '_PartnerWBSElementBasicData'
    PartnerWBSElementInternalID,
    @ObjectModel.foreignKey.association: '_WBSElementExternalID'
    cast( _WBSElementBasicData.WBSElementExternalID as fis_wbsext_no_conv ) as WBSElementExternalID,
    @ObjectModel.foreignKey.association: '_PartnerWBSElementExternalID'
    cast( _PartnerWBSElementBasicData.WBSElementExternalID as fis_partner_wbsext_no_conv ) as PartnerWBSElementExternalID,
    WBSElement,
    ProjectInternalID,
    @ObjectModel.foreignKey.association: '_PartnerProjectBasicData'
    PartnerProjectInternalID,
    cast( _ProjectBasicData.ProjectExternalID  as fis_projectext_no_conv ) as ProjectExternalID,
    @ObjectModel.foreignKey.association: '_PartnerProjectExternalID'
    cast( _PartnerProjectBasicData.ProjectExternalID as fis_part_projectext_no_conv ) as PartnerProjectExternalID,
    Project,
    OperatingConcern,
    ProjectNetwork,
    RelatedNetworkActivity,
    BusinessProcess,
    CostObject,
    CostAnalysisResource,
    ServiceDocumentType,
    ServiceDocument,
    ServiceDocumentItem,
    ServiceContract,
    ServiceContractType,
    ServiceContractItem,
    PartnerServiceDocumentType,
    PartnerServiceDocument,
    PartnerServiceDocumentItem,
    TimeSheetOvertimeCategory,
    CustomerServiceNotification,
    PartnerAccountAssignment,
    PartnerAccountAssignmentType,
    PartnerCostCtrActivityType,
    PartnerOrder,
    PartnerOrder_2,
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
    CustomerSupplierCountry,
    CustomerSupplierIndustry,
    SalesDistrict,
    BillToParty,
    ShipToParty,
    CustomerSupplierCorporateGroup,
    JointVenture,
    JointVentureEquityGroup,
    JointVentureCostRecoveryCode,
    JointVentureEquityType,
    SettlementReferenceDate,
    WorkCenterInternalID,
    OrderOperation,
    OrderItem,
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
    IsStatisticalOrder,
    IsStatisticalCostCenter,
    IsStatisticalSalesDocument,
    WBSIsStatisticalWBSElement,
    GLAccountAuthorizationGroup,
    SupplierBasicAuthorizationGrp,
    CustomerBasicAuthorizationGrp,
    AcctgDocTypeAuthorizationGroup,
    OrderType,
    SalesOrderType,
    AssetClass,

         // Period based reporting
    ( case when (I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting is null or I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = '' or I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = 'X') then fiscal_period_end_date
         // Daily based reporting and migrated items without posting date
             when (I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = 'D') and (I_GLAccountLineItem.PostingDate = '00000000') then P_FiscalYearPeriod.fiscal_period_start_date
         // Daily based reporting with posting date
             when (I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = 'D') and (I_GLAccountLineItem.PostingDate <> '00000000') then PostingDate
         end )
    as PostingDate,
    //migrated items without posting date (BSTAT = C and MIG_SOURCE = C/U)
//    case when I_GLAccountLineItem.PostingDate = '00000000' then P_FiscalYearPeriod.fiscal_period_start_date
//                                                           else PostingDate
//    end as PostingDate,

         // Period based reporting
    cast( ( case when (I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting is null or I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = '' or I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = 'X') then concat( P_FiscalYearPeriod.fiscal_period_end_date, P_FiscalYearPeriod.fiscal_period  )
         // Daily based reporting and migrated items without posting date
             when (I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = 'D') and (I_GLAccountLineItem.PostingDate = '00000000') then concat( P_FiscalYearPeriod.fiscal_period_start_date, P_FiscalYearPeriod.fiscal_period  )
         // Daily based reporting with posting date
             when (I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting = 'D') and (I_GLAccountLineItem.PostingDate <> '00000000') then concat( PostingDate, P_FiscalYearPeriod.fiscal_period  )
         end )
    as fis_fiscalperiod_date ) as FiscalPeriodDate,

//    Coalesce( I_TrialBalanceUserParam.IsPeriodBasedBalanceReporting, 'X' )  as IsPeriodBasedBalanceReporting,

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

    ConsolidationUnit,
    PartnerConsolidationUnit,
    Company,
    ConsolidationChartOfAccounts,
    CnsldtnFinancialStatementItem,
    CnsldtnSubitemCategory,
    CnsldtnSubitem,

    cast( LedgerFiscalYear as fis_ryear_flow preserving type ) as FlowOfFundsLedgerFiscalYear,

    _WBSElementExternalID,
    _WBSElementExternalIDText,
    _ProjectBasicData,
    _ProjectBasicDataText,
    _WBSElementBasicData,
    _WBSElementBasicDataText,
    _ProjectExternalID,
    _ProjectExternalIDText,

    _PartnerProjectExternalID,
    _PartnerProjctExtrnalIDText,
    _PartnerWBSElementExternalID,
    _PartnerWBSElemntExtrnalIDText,
    _PartnerProjectBasicData,
    _PartnerProjectBasicDataText,
    _PartnerWBSElementBasicData,
    _PartnerWBSElmntBasicDataText,

    _InvtrySpclStockWBSElmntBD,
    _InvtrySpclStockWBSElmntExtID,

    _ServiceContract,
    _ServiceContractType,
    _ServiceContractItem,
    _TimeSheetOvertimeCat,

    _AccrualObjectType,
    _AccrualObject,
    _AccrualSubobject,
    _AccrualItemType,

    _CashLedgerCompanyCode,
    _CashLedgerAccount,
    _FinancialManagementArea,
    _FundsCenter,
    _FundedProgram,
    _Fund,
//    _Grant,
    _BudgetPeriod,
    _PartnerFund,
//    _PartnerGrant,
    _PartnerBudgetPeriod,
    _PubSecBudgetAccountCoCode,
    _PubSecBudgetAccount,
    _PubSecBudgetCnsmpnDate,
    _PubSecBudgetCnsmpnFsclPeriod,
    _PubSecBudgetCnsmpnFsclYear,
    _PubSecBudgetCnsmpnType,
    _PubSecBudgetCnsmpnAmtType,
    _FunctionalCurrency,
    _ConsolidationUnit,
    _PartnerConsolidationUnit,
    _Company,
    _ConsolidationChartOfAccounts,
    _CnsldtnFinancialStatementItem,
    _CnsldtnSubitemCategory,
    _CnsldtnSubitem,
    _SupplierCompany,
    _CustomerCompany
}
where
         (
        // exclude opening/closing postings
                ( I_GLAccountLineItem.GLRecordType <> '5' and
        // exclude BCF
                 I_GLAccountLineItem.FiscalPeriod > '000'
                )
        // or include also opening/closing postings if enabled
            or ( I_YrEndClsgPostingUserParam.UserParameterValue = 'X' and I_GLAccountLineItem.GLRecordType = '5' and
                    ( I_GLAccountLineItem.AccountingDocumentCategory = 'J' or I_GLAccountLineItem.AccountingDocumentCategory = 'L' )
                )
            )
//include also migrated items
    or
    (  I_GLAccountLineItem.PostingDate = '00000000' and
       I_GLAccountLineItem.FiscalPeriod <> '000'
    )
