@AbapCatalog.sqlViewName: 'ZI95ACDPFHIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developed & Expanded with Prof Hier'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_95_ACD_PFHIER 
with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
    
as select from ZB_95_ACDOCA1 (P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )
left outer join I_CalendarDate as f  on f.CalendarDate = $session.system_date

left outer join ZB_95_PROFCTR_HIER as b on ZB_95_ACDOCA1.ProfitCenter = b.NodeValue

{
    key ZB_95_ACDOCA1.Ledger,
    key ZB_95_ACDOCA1.CompanyCode,
    key ZB_95_ACDOCA1.FiscalYear,
    key ZB_95_ACDOCA1.SourceLedger,
    key ZB_95_ACDOCA1.AccountingDocument,
    key ZB_95_ACDOCA1.LedgerGLLineItem,
    key ZB_95_ACDOCA1.GLAccountFlowType,
    key ZB_95_ACDOCA1.FiscalPeriodDate,
    b.HierarchyParentNode as HierarchyParentNode,
    case HierarchyParentNode
      when '01.2.4.1' then 'Developed in 2018'
      when '01.2.4.2' then 'Developed in 2019'
      when '01.2.4.3' then 'Developed in 2020'
      when '01.2.4.4' then 'Developed in 2021'
      when '01.2.4.5' then 'Developed in 2022'
      when '01.2.4.6' then 'Developed in 2023'
      when '01.2.5.1' then 'Expansions completed before 2022'
      when '01.2.5.2' then 'Expansions completed before 2022'
      when '01.2.5.3' then 'Expansions completed before 2022'
      when '01.2.5.4' then 'Expansions completed before 2022'
      when '01.2.5.5' then 'Expansions completed in 2022 or 2023'
      when '01.2.5.6' then 'Expansions completed in 2022 or 2023' 
      when '01.2'     then 'Expansions in Process'
      when '02.1.1.1' then 'Same Store Facilities'
      when '01.2.3'    then 'Acquired Facilities' 
      when '01.2.4'    then 'Newly developed & Expanded Facilities'
      when '01.2.5'    then 'Newly developed & Expanded Facilities'
      when '01.2.1'    then 'Other Non-Same Store Facilities'
      when '01.2.6'    then 'Other Non-Same Store Facilities' else 'Others' end as Facilities,
    b.NodeValue as NodeValue,
    //b.NodeText as NodeText,
    ZB_95_ACDOCA1.LedgerFiscalYear,
    ZB_95_ACDOCA1.FinancialTransactionType,
    ZB_95_ACDOCA1.BusinessTransactionType,
    ZB_95_ACDOCA1.ReferenceDocumentType,
    ZB_95_ACDOCA1.LogicalSystem,
    ZB_95_ACDOCA1.ReferenceDocumentContext,
    ZB_95_ACDOCA1.ReferenceDocument,
    ZB_95_ACDOCA1.ReferenceDocumentItem,
    ZB_95_ACDOCA1.ReferenceDocumentItemGroup,
    ZB_95_ACDOCA1.IsReversal,
    ZB_95_ACDOCA1.IsReversed,
    ZB_95_ACDOCA1.ReversalReferenceDocumentCntxt,
    ZB_95_ACDOCA1.ReversalReferenceDocument,
    ZB_95_ACDOCA1.IsSettlement,
    ZB_95_ACDOCA1.IsSettled,
    ZB_95_ACDOCA1.PredecessorReferenceDocType,
    ZB_95_ACDOCA1.PredecessorReferenceDocCntxt,
    ZB_95_ACDOCA1.PredecessorReferenceDocument,
    ZB_95_ACDOCA1.PredecessorReferenceDocItem,
    ZB_95_ACDOCA1.GLAccountNumber,
    ZB_95_ACDOCA1.GLAccount,
    ZB_95_ACDOCA1.GLAccountHierarchy,
    ZB_95_ACDOCA1.ProfitCenter,
    ZB_95_ACDOCA1.FunctionalArea,
    ZB_95_ACDOCA1.BusinessArea,
    ZB_95_ACDOCA1.ControllingArea,
    ZB_95_ACDOCA1.Segment,
    ZB_95_ACDOCA1.PartnerCostCenter,
    ZB_95_ACDOCA1.PartnerProfitCenter,
    ZB_95_ACDOCA1.PartnerFunctionalArea,
    ZB_95_ACDOCA1.PartnerBusinessArea,
    ZB_95_ACDOCA1.PartnerCompany,
    ZB_95_ACDOCA1.PartnerSegment,
    ZB_95_ACDOCA1.DebitCreditCode,
    ZB_95_ACDOCA1.FiscalYearVariant,
    ZB_95_ACDOCA1.FiscalYearPeriod,
    ZB_95_ACDOCA1.PostingDate,
    ZB_95_ACDOCA1.AccountingDocumentType,
    ZB_95_ACDOCA1.AccountingDocumentItem,
    ZB_95_ACDOCA1.AssignmentReference,
    ZB_95_ACDOCA1.PostingKey,
    ZB_95_ACDOCA1.AccountingDocumentCategory,
    ZB_95_ACDOCA1.TransactionTypeDetermination,
    ZB_95_ACDOCA1.SubLedgerAcctLineItemType,
    ZB_95_ACDOCA1.AccountingDocCreatedByUser,
    ZB_95_ACDOCA1.EliminationProfitCenter,
    ZB_95_ACDOCA1.OriginObjectType,
    ZB_95_ACDOCA1.GLAccountType,
    ZB_95_ACDOCA1.ChartOfAccounts,
    ZB_95_ACDOCA1.AlternativeGLAccount,
    ZB_95_ACDOCA1.CountryChartOfAccounts,
    ZB_95_ACDOCA1.CreationDateTime,
    ZB_95_ACDOCA1.InvoiceReference,
    ZB_95_ACDOCA1.InvoiceReferenceFiscalYear,
    ZB_95_ACDOCA1.FollowOnDocumentType,
    ZB_95_ACDOCA1.InvoiceItemReference,
    ZB_95_ACDOCA1.ReferencePurchaseOrderCategory,
    ZB_95_ACDOCA1.PurchasingDocument,
    ZB_95_ACDOCA1.PurchasingDocumentItem,
    ZB_95_ACDOCA1.AccountAssignmentNumber,
    ZB_95_ACDOCA1.DocumentItemText,
    ZB_95_ACDOCA1.Plant,
    ZB_95_ACDOCA1.Supplier,
    ZB_95_ACDOCA1.Customer,
    ZB_95_ACDOCA1.Material,
    ZB_95_ACDOCA1.Product,
    ZB_95_ACDOCA1.SoldMaterial,
    ZB_95_ACDOCA1.SoldProduct,
    ZB_95_ACDOCA1.MaterialGroup,
    ZB_95_ACDOCA1.SoldProductGroup,
    ZB_95_ACDOCA1.ProductGroup,
    ZB_95_ACDOCA1.FinancialAccountType,
    ZB_95_ACDOCA1.SpecialGLCode,
    ZB_95_ACDOCA1.TaxCode,
    ZB_95_ACDOCA1.HouseBank,
    ZB_95_ACDOCA1.HouseBankAccount,
    ZB_95_ACDOCA1.IsOpenItemManaged,
    ZB_95_ACDOCA1.ClearingAccountingDocument,
    ZB_95_ACDOCA1.ClearingDocFiscalYear,
    ZB_95_ACDOCA1.ClearingJournalEntry,
    ZB_95_ACDOCA1.ClearingJournalEntryFiscalYear,
    ZB_95_ACDOCA1.AssetDepreciationArea,
    ZB_95_ACDOCA1.MasterFixedAsset,
    ZB_95_ACDOCA1.FixedAsset,
    ZB_95_ACDOCA1.AssetValueDate,
    ZB_95_ACDOCA1.AssetTransactionType,
    ZB_95_ACDOCA1.AssetAcctTransClassfctn,
    ZB_95_ACDOCA1.DepreciationFiscalPeriod,
    ZB_95_ACDOCA1.GroupMasterFixedAsset,
    ZB_95_ACDOCA1.GroupFixedAsset,
    ZB_95_ACDOCA1.CostEstimate,
    ZB_95_ACDOCA1.InventorySpecialStockValnType,
    ZB_95_ACDOCA1.InvtrySpecialStockValnType_2,
    ZB_95_ACDOCA1.InventorySpecialStockType,
    ZB_95_ACDOCA1.InventorySpclStkSalesDocument,
    ZB_95_ACDOCA1.InventorySpclStkSalesDocItm,
    ZB_95_ACDOCA1.InvtrySpclStockWBSElmntIntID,
    ZB_95_ACDOCA1.InvtrySpclStockWBSElmntExtID,
    ZB_95_ACDOCA1.InventorySpclStockWBSElement,
    ZB_95_ACDOCA1.InventorySpecialStockSupplier,
    ZB_95_ACDOCA1.InventoryValuationType,
    ZB_95_ACDOCA1.ValuationArea,
    ZB_95_ACDOCA1.SenderCompanyCode,
    ZB_95_ACDOCA1.SenderGLAccount,
    ZB_95_ACDOCA1.SenderAccountAssignment,
    ZB_95_ACDOCA1.SenderAccountAssignmentType,
    ZB_95_ACDOCA1.ControllingObjectDebitType,
    ZB_95_ACDOCA1.QuantityIsIncomplete,
    ZB_95_ACDOCA1.OffsettingAccount,
    ZB_95_ACDOCA1.OffsettingAccountType,
    ZB_95_ACDOCA1.OffsettingChartOfAccounts,
    ZB_95_ACDOCA1.LineItemIsCompleted,
    ZB_95_ACDOCA1.PersonnelNumber,
    ZB_95_ACDOCA1.ControllingObjectClass,
    ZB_95_ACDOCA1.PartnerCompanyCode,
    ZB_95_ACDOCA1.PartnerControllingObjectClass,
    ZB_95_ACDOCA1.OriginCostCenter,
    ZB_95_ACDOCA1.OriginCostCtrActivityType,
    ZB_95_ACDOCA1.OriginProduct,
    ZB_95_ACDOCA1.VarianceOriginGLAccount,
    ZB_95_ACDOCA1.AccountAssignment,
    ZB_95_ACDOCA1.AccountAssignmentType,
    ZB_95_ACDOCA1.ProjectNetwork,
    ZB_95_ACDOCA1.RelatedNetworkActivity,
    ZB_95_ACDOCA1.BusinessProcess,
    ZB_95_ACDOCA1.CostObject,
    ZB_95_ACDOCA1.CustomerServiceNotification,
    ZB_95_ACDOCA1.ServiceDocumentType,
    ZB_95_ACDOCA1.ServiceDocument,
    ZB_95_ACDOCA1.ServiceDocumentItem,
    ZB_95_ACDOCA1.PartnerServiceDocumentType,
    ZB_95_ACDOCA1.PartnerServiceDocument,
    ZB_95_ACDOCA1.PartnerServiceDocumentItem,
    ZB_95_ACDOCA1.ServiceContractType,
    ZB_95_ACDOCA1.ServiceContract,
    ZB_95_ACDOCA1.ServiceContractItem,
    ZB_95_ACDOCA1.TimeSheetOvertimeCategory,
    ZB_95_ACDOCA1.OperatingConcern,
    ZB_95_ACDOCA1.PartnerAccountAssignment,
    ZB_95_ACDOCA1.PartnerAccountAssignmentType,
    ZB_95_ACDOCA1.PartnerCostCtrActivityType,
    ZB_95_ACDOCA1.PartnerOrder,
    ZB_95_ACDOCA1.PartnerOrderCategory,
    ZB_95_ACDOCA1.PartnerWBSElement,
    ZB_95_ACDOCA1.PartnerProject,
    ZB_95_ACDOCA1.PartnerSalesDocument,
    ZB_95_ACDOCA1.PartnerSalesDocumentItem,
    ZB_95_ACDOCA1.PartnerProjectNetwork,
    ZB_95_ACDOCA1.PartnerProjectNetworkActivity,
    ZB_95_ACDOCA1.PartnerBusinessProcess,
    ZB_95_ACDOCA1.PartnerCostObject,
    ZB_95_ACDOCA1.BillingDocumentType,
    ZB_95_ACDOCA1.SalesOrganization,
    ZB_95_ACDOCA1.DistributionChannel,
    ZB_95_ACDOCA1.OrganizationDivision,
    ZB_95_ACDOCA1.CustomerGroup,
    ZB_95_ACDOCA1.JointVenture,
    ZB_95_ACDOCA1.JointVentureEquityGroup,
    ZB_95_ACDOCA1.JointVentureCostRecoveryCode,
    ZB_95_ACDOCA1.JointVentureEquityType,
    ZB_95_ACDOCA1.SettlementReferenceDate,
    ZB_95_ACDOCA1.CostCenter,
    ZB_95_ACDOCA1.CostCtrActivityType,
    ZB_95_ACDOCA1.OrderID,
    ZB_95_ACDOCA1.OrderCategory,
    ZB_95_ACDOCA1.WBSElementInternalID,
    ZB_95_ACDOCA1.WBSElementExternalID,
    ZB_95_ACDOCA1.WBSElement,
    ZB_95_ACDOCA1.PartnerWBSElementInternalID,
    ZB_95_ACDOCA1.PartnerWBSElementExternalID,
    ZB_95_ACDOCA1.Project,
    ZB_95_ACDOCA1.ProjectInternalID,
    ZB_95_ACDOCA1.ProjectExternalID,
    ZB_95_ACDOCA1.PartnerProjectInternalID,
    ZB_95_ACDOCA1.PartnerProjectExternalID,
    ZB_95_ACDOCA1.SalesOrder,
    ZB_95_ACDOCA1.SalesOrderItem,
    ZB_95_ACDOCA1.SalesDocument,
    ZB_95_ACDOCA1.SalesDocumentItem,
    ZB_95_ACDOCA1.ClearingDate,
    ZB_95_ACDOCA1.ConsolidationUnit,
    ZB_95_ACDOCA1.PartnerConsolidationUnit,
    ZB_95_ACDOCA1.Company,
    ZB_95_ACDOCA1.ConsolidationChartOfAccounts,
    ZB_95_ACDOCA1.CnsldtnFinancialStatementItem,
    ZB_95_ACDOCA1.CnsldtnSubitemCategory,
    ZB_95_ACDOCA1.CnsldtnSubitem,
    ZB_95_ACDOCA1.JrnlEntryItemObsoleteReason,
    ZB_95_ACDOCA1.BalanceTransactionCurrency,
    ZB_95_ACDOCA1.AmountInBalanceTransacCrcy,
    ZB_95_ACDOCA1.TransactionCurrency,
    ZB_95_ACDOCA1.AmountInTransactionCurrency,
    ZB_95_ACDOCA1.CompanyCodeCurrency,
    ZB_95_ACDOCA1.AmountInCompanyCodeCurrency,
    ZB_95_ACDOCA1.GlobalCurrency,
//    ZB_95_ACDOCA1.AmountInGlobalCurrency,
    ZB_95_ACDOCA1.FunctionalCurrency,
    ZB_95_ACDOCA1.AmountInFunctionalCurrency,
    ZB_95_ACDOCA1.FreeDefinedCurrency1,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency1,
    ZB_95_ACDOCA1.FreeDefinedCurrency2,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency2,
    ZB_95_ACDOCA1.FreeDefinedCurrency3,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency3,
    ZB_95_ACDOCA1.FreeDefinedCurrency4,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency4,
    ZB_95_ACDOCA1.FreeDefinedCurrency5,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency5,
    ZB_95_ACDOCA1.FreeDefinedCurrency6,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency6,
    ZB_95_ACDOCA1.FreeDefinedCurrency7,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency7,
    ZB_95_ACDOCA1.FreeDefinedCurrency8,
    ZB_95_ACDOCA1.AmountInFreeDefinedCurrency8,
    ZB_95_ACDOCA1.DebitAmountInCoCodeCrcy,
    ZB_95_ACDOCA1.CreditAmountInCoCodeCrcy,
    ZB_95_ACDOCA1.DebitAmountInTransCrcy,
    ZB_95_ACDOCA1.CreditAmountInTransCrcy,
    ZB_95_ACDOCA1.DebitAmountInBalanceTransCrcy,
    ZB_95_ACDOCA1.CreditAmountInBalanceTransCrcy,
    ZB_95_ACDOCA1.DebitAmountInGlobalCrcy,
    ZB_95_ACDOCA1.CreditAmountInGlobalCrcy,
    ZB_95_ACDOCA1.DebitAmountInFunctionalCrcy,
    ZB_95_ACDOCA1.CreditAmountInFunctionalCrcy,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy1,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy1,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy2,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy2,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy3,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy3,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy4,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy4,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy5,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy5,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy6,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy6,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy7,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy7,
    ZB_95_ACDOCA1.DebitAmountInFreeDefinedCrcy8,
    ZB_95_ACDOCA1.CreditAmountInFreeDefinedCrcy8,
    ZB_95_ACDOCA1.FiscalPeriod,
    ZB_95_ACDOCA1.EndingBalanceAmtInCoCodeCrcy,
    ZB_95_ACDOCA1.EndingBalanceAmtInTransCrcy,
    ZB_95_ACDOCA1.EndingBalanceAmtInBalTransCrcy,
    ZB_95_ACDOCA1.EndingBalanceAmtInGlobalCrcy,
    ZB_95_ACDOCA1.EndingBalanceAmtInFuncnlCrcy,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy1,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy2,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy3,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy4,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy5,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy6,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy7,
    ZB_95_ACDOCA1.EndingBalAmtInFreeDfndCrcy8,
    ZB_95_ACDOCA1.AccrualObjectType,
    ZB_95_ACDOCA1.AccrualObject,
    ZB_95_ACDOCA1.AccrualSubobject,
    ZB_95_ACDOCA1.AccrualItemType,
    ZB_95_ACDOCA1.AccrualObjectLogicalSystem,
    ZB_95_ACDOCA1.AccrualReferenceObject,
    ZB_95_ACDOCA1.AccrualValueDate,
    ZB_95_ACDOCA1.CashLedgerCompanyCode,
    ZB_95_ACDOCA1.CashLedgerAccount,
    ZB_95_ACDOCA1.FinancialManagementArea,
    ZB_95_ACDOCA1.FundsCenter,
    ZB_95_ACDOCA1.FundedProgram,
    ZB_95_ACDOCA1.Fund,
    ZB_95_ACDOCA1.GrantID,
    ZB_95_ACDOCA1.BudgetPeriod,
    ZB_95_ACDOCA1.PartnerFund,
    ZB_95_ACDOCA1.PartnerGrant,
    ZB_95_ACDOCA1.PartnerBudgetPeriod,
    ZB_95_ACDOCA1.PubSecBudgetAccount,
    ZB_95_ACDOCA1.PubSecBudgetAccountCoCode,
    ZB_95_ACDOCA1.PubSecBudgetCnsmpnDate,
    ZB_95_ACDOCA1.PubSecBudgetCnsmpnFsclPeriod,
    ZB_95_ACDOCA1.PubSecBudgetCnsmpnFsclYear,
    ZB_95_ACDOCA1.PubSecBudgetIsRelevant,
    ZB_95_ACDOCA1.PubSecBudgetCnsmpnType,
    ZB_95_ACDOCA1.PubSecBudgetCnsmpnAmtType,
    ZB_95_ACDOCA1.FlowOfFundsLedgerFiscalYear,
    ZB_95_ACDOCA1.GLAccountAuthorizationGroup,
    ZB_95_ACDOCA1.SupplierBasicAuthorizationGrp,
    ZB_95_ACDOCA1.CustomerBasicAuthorizationGrp,
    ZB_95_ACDOCA1.AcctgDocTypeAuthorizationGroup,
    ZB_95_ACDOCA1.OrderType,
    ZB_95_ACDOCA1.SalesOrderType,
    ZB_95_ACDOCA1.AssetClass,
    ZB_95_ACDOCA1.ValidityStartDate,    
    ZB_95_ACDOCA1.LastYearDate,
    ZB_95_ACDOCA1.StatGLAcc,
    ZB_95_ACDOCA1.StatKF,
   
    case substring(ZB_95_ACDOCA1.LastYearDate,5,2) when  '01' then '1'
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
                   else 'XYZ'
                     end                             as CLastYearQUARTER,
                     
    substring(ZB_95_ACDOCA1.LastYearDate,1,4)        as CLastYEAR,
    
    CONCAT(substring(ZB_95_ACDOCA1.LastYearDate,1,4),ZB_95_ACDOCA1.CQUARTER) as YearQuarter,
    f.CalendarQuarter,
    f.CalendarYear,
  
// Start of FINANCIALS - KPIs    
      
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    ZB_95_ACDOCA1.AmountInGlobalCurrency,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY QTD'
    case CONCAT(substring(ZB_95_ACDOCA1.LastYearDate,1,4),ZB_95_ACDOCA1.CQUARTER) when f.YearQuarter then ZB_95_ACDOCA1.AmountInGlobalCurrency  end as FI_LASTYR_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'LY YTD'
    case substring(ZB_95_ACDOCA1.LastYearDate,1,4) when f.CalendarYear then ZB_95_ACDOCA1.AmountInGlobalCurrency  end as FI_LASTYR_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    @EndUserText.label: 'Current QTD'
    case ZB_95_ACDOCA1.CQUARTER when f.CalendarQuarter then ZB_95_ACDOCA1.AmountInGlobalCurrency  end as FI_CURRENT_QTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Current YTD'
    @DefaultAggregation: #SUM
    case ZB_95_ACDOCA1.CYEAR when f.CalendarYear then ZB_95_ACDOCA1.AmountInGlobalCurrency  end as FI_CURRENT_YTD,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last Year'
    @DefaultAggregation: #SUM
    case ZB_95_ACDOCA1.LYEAR when f.CalendarYear then ZB_95_ACDOCA1.AmountInGlobalCurrency  end as FI_LASTYR,
    
    @AnalyticsDetails.query.axis: #ROWS
    @EndUserText.label: 'Last to LastYear'
    @DefaultAggregation: #SUM
    case ZB_95_ACDOCA1.L2LYEAR when f.CalendarYear then ZB_95_ACDOCA1.AmountInGlobalCurrency  end as FI_L2LASTYR,
    
// End of FINANCIALS - KPIs

    ZB_95_ACDOCA1.CQUARTER,
    ZB_95_ACDOCA1.CCMONTH,
    ZB_95_ACDOCA1.CCMONTH1,
    ZB_95_ACDOCA1.CYEAR,
    ZB_95_ACDOCA1.LYEAR,
    ZB_95_ACDOCA1.L2LYEAR,
    ZB_95_ACDOCA1.ValidityYEAR,
    ZB_95_ACDOCA1.ProfCtr_Year,
    ZB_95_ACDOCA1.NumOfFac    as NumOfFac,
    ZB_95_ACDOCA1.NetRentSqFt as NetRentSqFt,
    ZB_95_ACDOCA1.CstDevlop   as CstDevlop,
    cast(ZB_95_ACDOCA1.SqFt_910200 as abap.fltp) as  SqFt_910200,
    cast(ZB_95_ACDOCA1.SqFt_910210 as abap.fltp) as  SqFt_910210,
    cast(ZB_95_ACDOCA1.SqFt_910120 as abap.fltp) as  SqFt_910120
    
//    @AnalyticsDetails.query.axis: #ROWS
//    @EndUserText.label: 'SquareFtOccupancy'
//    @DefaultAggregation: #SUM
//    division(ZB_95_ACDOCA1.SqFt_910200,ZB_95_ACDOCA1.SqFt_910210,2) as SquareFtOccupancy,
//    //cast( ZB_95_ACDOCA1.SqFt_910200 as abap.fltp) / cast( ZB_95_ACDOCA1.SqFt_910210 as abap.fltp) as SquareFtOccupancy,
//    //fltp_to_dec(SquareFtOccupancy as abap.dec(17,2)) as SquareFtOccupancy_Dec,
//    
//    @AnalyticsDetails.query.axis: #ROWS
//    @EndUserText.label: 'AnnualConPerSqFt'
//    @DefaultAggregation: #SUM
//    division(ZB_95_ACDOCA1.SqFt_910120,ZB_95_ACDOCA1.SqFt_910200,2) as AnnualConPerSqFt
//    //cast( ZB_95_ACDOCA1.SqFt_910120 as abap.fltp) / cast( ZB_95_ACDOCA1.SqFt_910200 as abap.fltp) as AnnualConPerSqFt
//    //fltp_to_dec(AnnualConPerSqFt as abap.dec(17,2)) as AnnualConPerSqFt_Dec,
 
    }           
           
