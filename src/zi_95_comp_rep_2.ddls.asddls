@AbapCatalog.sqlViewName: 'ZI95COMPREP2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'R0095- Composite View'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_95_COMP_REP_2 
with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
   
as select from ZC_95_COMP_REP
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
 HierarchyParentNode,
 Facilities,
 NodeValue,
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
 GLAccountNumber,
 GLAccount,
 GLAccountHierarchy,
 ProfitCenter,
 FunctionalArea,
 BusinessArea,
 ControllingArea,
 Segment,
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
 StatGLAcc,
 StatKF,
 ValidityStartDate,
 LastYearDate,
 CLastYearQUARTER,
 CLastYEAR,
 CalendarQuarter,
 YearQuarter,
  CalendarYear,      
    CQUARTER,
    CCMONTH,
    CCMONTH1,
    CYEAR,
    LYEAR,
    L2LYEAR,
    ValidityYEAR,
    ProfCtr_Year,
    NumOfFac,
    NetRentSqFt,
    CstDevlop,
    SqFt_910200,
    SqFt_910210,
    SqFt_910120,
    SquareFtOccupancy,
    AnnualConPerSqFt,
    fltp_to_dec(SquareFtOccupancy as abap.dec(17,2)) as SquareFtOccupancy_dec,
    fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2))  as AnnualConPerSqFt_dec,
 AmountInGlobalCurrency,

// FINANCIAS - KPIs........................

 FI_CURRENT_QTD,
 FI_CURRENT_YTD,
 FI_LASTYR_QTD,
 FI_LASTYR_YTD,
 FI_LASTYR,
 FI_L2LASTYR,
 FI_ChangeQTD,
 FI_ChangeYTD,
 FI_ChangeYr,
 
 // STATISTICALS - KPIs.......................
    
  // Square foot occupancy
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY QTD'
    case CONCAT(substring(LastYearDate,1,4),CQUARTER) when YearQuarter then fltp_to_dec(SquareFtOccupancy as abap.dec(17,2))  end as SF_LASTYR_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY YTD'
    case substring(LastYearDate,1,4) when CalendarYear then fltp_to_dec(SquareFtOccupancy as abap.dec(17,2)) end as SF_LASTYR_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Current QTD'
    case CQUARTER when CalendarQuarter then fltp_to_dec(SquareFtOccupancy as abap.dec(17,2))  end as SF_CURRENT_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Current YTD'
    @DefaultAggregation: #SUM
    case CYEAR when CalendarYear then fltp_to_dec(SquareFtOccupancy as abap.dec(17,2))  end as SF_CURRENT_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last Year'
    @DefaultAggregation: #SUM
    case LYEAR when CalendarYear then fltp_to_dec(SquareFtOccupancy as abap.dec(17,2))  end as SF_LASTYR,
   
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last to LastYear'
    @DefaultAggregation: #SUM
    case L2LYEAR when CalendarYear then fltp_to_dec(SquareFtOccupancy as abap.dec(17,2))  end as SF_L2LASTYR,
    
  // Annual contract rent per occupied square foot
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY QTD'
    case CONCAT(substring(LastYearDate,1,4),CQUARTER) when YearQuarter then fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2))  end as AC_LASTYR_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY YTD'
    case substring(LastYearDate,1,4) when CalendarYear then fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2))  end as AC_LASTYR_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Current QTD'
    case CQUARTER when CalendarQuarter then fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2)) end as AC_CURRENT_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Current YTD'
    @DefaultAggregation: #SUM
    case CYEAR when CalendarYear then fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2))  end as AC_CURRENT_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last Year'
    @DefaultAggregation: #SUM
    case LYEAR when CalendarYear then fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2))  end as AC_LASTYR,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last to LastYear'
    @DefaultAggregation: #SUM
    case L2LYEAR when CalendarYear then fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2))  end as AC_L2LASTYR,  
    
// Number of Facilities         
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY QTD'
    case CONCAT(substring(LastYearDate,1,4),CQUARTER) when YearQuarter then NumOfFac  end as NF_LASTYR_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY YTD'
    case substring(LastYearDate,1,4) when CalendarYear then NumOfFac  end as NF_LASTYR_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Current QTD'
    case CQUARTER when CalendarQuarter then NumOfFac  end as NF_CURRENT_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Current YTD'
    @DefaultAggregation: #SUM
    case CYEAR when CalendarYear then NumOfFac  end as NF_CURRENT_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last Year'
    @DefaultAggregation: #SUM
    case LYEAR when CalendarYear then NumOfFac  end as NF_LASTYR,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last to LastYear'
    @DefaultAggregation: #SUM
    case L2LYEAR when CalendarYear then NumOfFac  end as NF_L2LASTYR, 
    
  // Net rentable square feet (in thousands)
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY QTD'
    case CONCAT(substring(LastYearDate,1,4),CQUARTER) when YearQuarter then NetRentSqFt end as NR_LASTYR_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY YTD'
    case substring(LastYearDate,1,4) when CalendarYear then NetRentSqFt  end as NR_LASTYR_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Current QTD'
    case CQUARTER when CalendarQuarter then NetRentSqFt  end as NR_CURRENT_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Current YTD'
    @DefaultAggregation: #SUM
    case CYEAR when CalendarYear then NetRentSqFt  end as NR_CURRENT_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last Year'
    @DefaultAggregation: #SUM
    case LYEAR when CalendarYear then NetRentSqFt  end as NR_LASTYR,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last to LastYear'
    @DefaultAggregation: #SUM
    case L2LYEAR when CalendarYear then NetRentSqFt  end as NR_L2LASTYR, 
    
  // Costs to develop (in thousands)
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY QTD'
    case CONCAT(substring(LastYearDate,1,4),CQUARTER) when YearQuarter then CstDevlop end as CD_LASTYR_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY YTD'
    case substring(LastYearDate,1,4) when CalendarYear then CstDevlop  end as CD_LASTYR_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Current QTD'
    case CQUARTER when CalendarQuarter then CstDevlop  end as CD_CURRENT_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Current YTD'
    @DefaultAggregation: #SUM
    case CYEAR when CalendarYear then CstDevlop  end as CD_CURRENT_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last Year'
    @DefaultAggregation: #SUM
    case LYEAR when CalendarYear then CstDevlop  end as CD_LASTYR,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last to LastYear'
    @DefaultAggregation: #SUM
    case L2LYEAR when CalendarYear then CstDevlop  end as CD_L2LASTYR
    
   
    }
    
