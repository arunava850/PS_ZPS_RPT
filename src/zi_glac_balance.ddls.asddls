@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.sqlViewName: 'ZIGLACBALANCE'
@EndUserText.label: 'Public Storage GL Ac Balance'
@VDM.viewType: #COMPOSITE
@VDM.private:true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #NOT_ALLOWED
@Metadata.ignorePropagatedAnnotations: true 
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST, #UNION]

define view ZI_GLAC_BALANCE
as select from ZI_GLCRDB_BAL as P_GLAcctCreditDebitBalance 
{
key P_GLAcctCreditDebitBalance.Ledger as rldnr,
key P_GLAcctCreditDebitBalance.CompanyCode as rbukrs,
key P_GLAcctCreditDebitBalance.FiscalYearPeriod as fiscyearper,
key P_GLAcctCreditDebitBalance.FiscalYear as gjahr,
key P_GLAcctCreditDebitBalance.AccountingDocument as belnr,
key P_GLAcctCreditDebitBalance.LedgerGLLineItem as docln,
key P_GLAcctCreditDebitBalance.SourceLedger as rldnr_pers,

P_GLAcctCreditDebitBalance.LedgerFiscalYear as ryear,
//P_GLAcctCreditDebitBalance.GLRecordType as rrcty,

///////////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_00  Unified Journal Entry: Transaction, Currencies, Units
///////////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.FinancialTransactionType as rmvct,
P_GLAcctCreditDebitBalance.BusinessTransactionType as bttype,
P_GLAcctCreditDebitBalance.ReferenceDocumentType as awtyp,
P_GLAcctCreditDebitBalance.LogicalSystem as awsys,
P_GLAcctCreditDebitBalance.ReferenceDocumentContext as aworg,
P_GLAcctCreditDebitBalance.ReferenceDocument as awref,
P_GLAcctCreditDebitBalance.ReferenceDocumentItem as awitem,
P_GLAcctCreditDebitBalance.ReferenceDocumentItemGroup as awitgrp,
////P_GLAcctCreditDebitBalance.SUBTA,
P_GLAcctCreditDebitBalance.IsReversal as xreversing,
P_GLAcctCreditDebitBalance.IsReversed as xreversed,
////P_GLAcctCreditDebitBalance.XTRUEREV,
////P_GLAcctCreditDebitBalance.AWTYP_REV,
P_GLAcctCreditDebitBalance.ReversalReferenceDocumentCntxt as aworg_rev,
P_GLAcctCreditDebitBalance.ReversalReferenceDocument as awref_rev,
////P_GLAcctCreditDebitBalance.SUBTA_REV,
P_GLAcctCreditDebitBalance.IsSettlement as xsettling,
P_GLAcctCreditDebitBalance.IsSettled as xsettled,
P_GLAcctCreditDebitBalance.PredecessorReferenceDocType as prec_awtyp,
P_GLAcctCreditDebitBalance.PredecessorReferenceDocCntxt as prec_aworg,
P_GLAcctCreditDebitBalance.PredecessorReferenceDocument as prec_awref,
P_GLAcctCreditDebitBalance.PredecessorReferenceDocItem as prec_awitem,
//P_GLAcctCreditDebitBalance.PREC_SUBTA,

P_GLAcctCreditDebitBalance.GLAccount as racct,

////////////////////////////////////////////////////////////////////////////////////
// .INCLUDE  ACDOC_SI_GL_ACCAS Unified Journal Entry: G/L additional account assignments
////////////////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.ProfitCenter as prctr,
P_GLAcctCreditDebitBalance.FunctionalArea as rfarea,
P_GLAcctCreditDebitBalance.BusinessArea as rbusa,
P_GLAcctCreditDebitBalance.ControllingArea as kokrs,
P_GLAcctCreditDebitBalance.Segment as segment,
P_GLAcctCreditDebitBalance.PartnerCostCenter as scntr,
P_GLAcctCreditDebitBalance.PartnerProfitCenter as pprctr,
P_GLAcctCreditDebitBalance.PartnerFunctionalArea as sfarea,
P_GLAcctCreditDebitBalance.PartnerBusinessArea as sbusa,
P_GLAcctCreditDebitBalance.PartnerCompany as rassc,
P_GLAcctCreditDebitBalance.PartnerSegment as psegment,

/////////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_FIX  Unified Journal Entry: Mandatory fields for G/L
////////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.DebitCreditCode as drcrk,
P_GLAcctCreditDebitBalance.FiscalYearVariant as periv,
//P_GLAcctCreditDebitBalance.PostingDate as budat,
//cast( ( case when P_GLAcctCreditDebitBalance.IsPeriodBasedBalanceReporting = 'X' then '00000000'
//                                                                                 else P_GLAcctCreditDebitBalance.PostingDate
//        end )
//as fis_budat ) as budat,
P_GLAcctCreditDebitBalance.PostingDate as budat,
//P_GLAcctCreditDebitBalance.bldat,
P_GLAcctCreditDebitBalance.AccountingDocumentType as blart,
P_GLAcctCreditDebitBalance.AccountingDocumentItem as buzei,
P_GLAcctCreditDebitBalance.AssignmentReference as zuonr,
P_GLAcctCreditDebitBalance.PostingKey as bschl,
P_GLAcctCreditDebitBalance.AccountingDocumentCategory as bstat,
P_GLAcctCreditDebitBalance.TransactionTypeDetermination as ktosl,
P_GLAcctCreditDebitBalance.SubLedgerAcctLineItemType as slalittype,
P_GLAcctCreditDebitBalance.AccountingDocCreatedByUser as usnam,
//P_GLAcctCreditDebitBalance.timestamp,
P_GLAcctCreditDebitBalance.EliminationProfitCenter as eprctr,
P_GLAcctCreditDebitBalance.OriginObjectType as rhoart,
P_GLAcctCreditDebitBalance.GLAccountType as glaccount_type,
P_GLAcctCreditDebitBalance.ChartOfAccounts as ktopl,
P_GLAcctCreditDebitBalance.AlternativeGLAccount as lokkt,
P_GLAcctCreditDebitBalance.CountryChartOfAccounts as ktop2,
P_GLAcctCreditDebitBalance.CreationDateTime,

///////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_GEN  Unified Journal Entry: Fields for several subledgers
//////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.InvoiceReference as rebzg,
P_GLAcctCreditDebitBalance.InvoiceReferenceFiscalYear as rebzj,
P_GLAcctCreditDebitBalance.FollowOnDocumentType as rebzz,
P_GLAcctCreditDebitBalance.InvoiceItemReference as rebzt,
P_GLAcctCreditDebitBalance.ReferencePurchaseOrderCategory as rbest,
P_GLAcctCreditDebitBalance.PurchasingDocument as ebeln,
P_GLAcctCreditDebitBalance.PurchasingDocumentItem as ebelp,
P_GLAcctCreditDebitBalance.AccountAssignmentNumber as zekkn,
P_GLAcctCreditDebitBalance.DocumentItemText as sgtxt,
P_GLAcctCreditDebitBalance.Plant as werks,
P_GLAcctCreditDebitBalance.Supplier as lifnr,
P_GLAcctCreditDebitBalance.Customer as kunnr,

P_GLAcctCreditDebitBalance.Product as matnr,
P_GLAcctCreditDebitBalance.SoldProduct as  matnr_copa,
P_GLAcctCreditDebitBalance.SoldProductGroup as  matkl,
P_GLAcctCreditDebitBalance.ProductGroup as matkl_mm,

/////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_FI  Unified Journal Entry: Fields for FI subledgers
/////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.FinancialAccountType as koart,
P_GLAcctCreditDebitBalance.SpecialGLCode as umskz,
P_GLAcctCreditDebitBalance.TaxCode as mwskz,
P_GLAcctCreditDebitBalance.HouseBank as hbkid,
P_GLAcctCreditDebitBalance.HouseBankAccount as hktid,
P_GLAcctCreditDebitBalance.IsOpenItemManaged as xopvw,
//P_GLAcctCreditDebitBalance.augdt,
P_GLAcctCreditDebitBalance.ClearingAccountingDocument as augbl,
P_GLAcctCreditDebitBalance.ClearingDocFiscalYear as auggj,
//P_GLAcctCreditDebitBalance.IsCleared as xaugp,


/////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_FAA  Unified Journal Entry: Fields for Asset Accounting
/////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.AssetDepreciationArea as afabe,
P_GLAcctCreditDebitBalance.MasterFixedAsset as anln1,
P_GLAcctCreditDebitBalance.FixedAsset as anln2,
P_GLAcctCreditDebitBalance.AssetValueDate as bzdat,
P_GLAcctCreditDebitBalance.AssetTransactionType as anbwa,
P_GLAcctCreditDebitBalance.AssetAcctTransClassfctn as movcat,
P_GLAcctCreditDebitBalance.DepreciationFiscalPeriod as depr_period,
P_GLAcctCreditDebitBalance.GroupMasterFixedAsset as anlgr,
P_GLAcctCreditDebitBalance.GroupFixedAsset as anlgr2,
//P_GLAcctCreditDebitBalance.settlement_rule,

//////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_ML Unified Journal Entry: Fields for Material Ledger
//////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.CostEstimate as kalnr,
P_GLAcctCreditDebitBalance.InventorySpecialStockValnType as kzbws,
//P_GLAcctCreditDebitBalance.xobew,
P_GLAcctCreditDebitBalance.InventorySpecialStockType as sobkz,
P_GLAcctCreditDebitBalance.InventorySpclStkSalesDocument as mat_kdauf,
P_GLAcctCreditDebitBalance.InvtrySpclStockWBSElmntExtID,
P_GLAcctCreditDebitBalance.InventorySpclStkSalesDocItm as mat_kdpos,
P_GLAcctCreditDebitBalance.InvtrySpclStockWBSElmntIntID as mat_pspnr, 
P_GLAcctCreditDebitBalance.InventorySpclStockWBSElement as mat_ps_posid,
P_GLAcctCreditDebitBalance.PartnerWBSElementInternalID,
P_GLAcctCreditDebitBalance.PartnerWBSElementExternalID,
P_GLAcctCreditDebitBalance.InventorySpecialStockSupplier as mat_lifnr,
P_GLAcctCreditDebitBalance.InventoryValuationType as bwtar,
P_GLAcctCreditDebitBalance.ValuationArea as bwkey,

////////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_CFIN   Unified Journal Entry: Fields for Central Finance
//////////////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.SenderCompanyCode,
P_GLAcctCreditDebitBalance.SenderGLAccount as racct_sender,
P_GLAcctCreditDebitBalance.SenderAccountAssignment as accas_sender,
P_GLAcctCreditDebitBalance.SenderAccountAssignmentType as accasty_sender,

////////////////////////////////////////////////////////////////////////////
//  .INCLUDE  ACDOC_SI_CO  Unified Journal Entry: CO fields
///////////////////////////////////////////////////////////////////////////
//P_GLAcctCreditDebitBalance.UtilsProfileConstcyChkGrp as hkgrp,
//P_GLAcctCreditDebitBalance.ControllingDebitCreditCode as co_belkz,
P_GLAcctCreditDebitBalance.ControllingObjectDebitType as beltp,
P_GLAcctCreditDebitBalance.QuantityIsIncomplete as muvflg,
P_GLAcctCreditDebitBalance.OffsettingAccount as gkont,
P_GLAcctCreditDebitBalance.OffsettingAccountType as gkoar,
P_GLAcctCreditDebitBalance.LineItemIsCompleted as erlkz,
P_GLAcctCreditDebitBalance.PersonnelNumber as pernr,
P_GLAcctCreditDebitBalance.ControllingObjectClass as scope,
P_GLAcctCreditDebitBalance.PartnerCompanyCode as pbukrs,
P_GLAcctCreditDebitBalance.PartnerControllingObjectClass as pscope,
//P_GLAcctCreditDebitBalance.aufnr_org,
P_GLAcctCreditDebitBalance.OriginCostCenter as ukostl,
P_GLAcctCreditDebitBalance.OriginCostCtrActivityType as ulstar,
P_GLAcctCreditDebitBalance.OriginProduct,
P_GLAcctCreditDebitBalance.VarianceOriginGLAccount,
P_GLAcctCreditDebitBalance.AccountAssignment as accas,
P_GLAcctCreditDebitBalance.AccountAssignmentType as accasty,
P_GLAcctCreditDebitBalance.ProjectNetwork as nplnr,
P_GLAcctCreditDebitBalance.RelatedNetworkActivity as nplnr_vorgn,
P_GLAcctCreditDebitBalance.BusinessProcess as prznr,
P_GLAcctCreditDebitBalance.CostObject as kstrg,
//P_GLAcctCreditDebitBalance.bemot,
P_GLAcctCreditDebitBalance.CustomerServiceNotification as qmnum,
P_GLAcctCreditDebitBalance.ServiceDocumentType,
P_GLAcctCreditDebitBalance.ServiceDocument,
P_GLAcctCreditDebitBalance.ServiceDocumentItem,
P_GLAcctCreditDebitBalance.PartnerServiceDocumentType,
P_GLAcctCreditDebitBalance.PartnerServiceDocument,
P_GLAcctCreditDebitBalance.PartnerServiceDocumentItem,
P_GLAcctCreditDebitBalance.ServiceContract,
P_GLAcctCreditDebitBalance.ServiceContractType,
P_GLAcctCreditDebitBalance.ServiceContractItem,
P_GLAcctCreditDebitBalance.TimeSheetOvertimeCategory,
P_GLAcctCreditDebitBalance.OperatingConcern as erkrs,
P_GLAcctCreditDebitBalance.PartnerAccountAssignment as paccas,
P_GLAcctCreditDebitBalance.PartnerAccountAssignmentType as paccasty,
P_GLAcctCreditDebitBalance.PartnerCostCtrActivityType as plstar,
P_GLAcctCreditDebitBalance.PartnerOrder as paufnr,
P_GLAcctCreditDebitBalance.PartnerOrder_2,
P_GLAcctCreditDebitBalance.PartnerOrderCategory as pautyp,
P_GLAcctCreditDebitBalance.PartnerWBSElement as pps_posid,
P_GLAcctCreditDebitBalance.PartnerProject as pps_pspid,
P_GLAcctCreditDebitBalance.PartnerSalesDocument as pkdauf,
P_GLAcctCreditDebitBalance.PartnerSalesDocumentItem as pkdpos,
P_GLAcctCreditDebitBalance.PartnerProjectNetwork as pnplnr,
P_GLAcctCreditDebitBalance.PartnerProjectNetworkActivity as pnplnr_vorgn,
P_GLAcctCreditDebitBalance.PartnerBusinessProcess as pprznr,
P_GLAcctCreditDebitBalance.PartnerCostObject as pkstrg,

//////////////////////////////////////////////////////////////////////
//  .INCLUDE  ACDOC_SI_COPA  Unified Journal Entry: CO-PA fields
//////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.BillingDocumentType as fkart,
P_GLAcctCreditDebitBalance.SalesOrganization as vkorg,
P_GLAcctCreditDebitBalance.DistributionChannel as vtweg,
P_GLAcctCreditDebitBalance.OrganizationDivision as spart,
P_GLAcctCreditDebitBalance.CustomerGroup as kdgrp,

//////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_PS  Unified Journal Entry: Fields for Public Sector
/////////////////////////////////////////////////////////////////////
//P_GLAcctCreditDebitBalance.re_bukrs,
//P_GLAcctCreditDebitBalance.re_account,
P_GLAcctCreditDebitBalance.FinancialManagementArea as fikrs,
P_GLAcctCreditDebitBalance.Fund as rfund,
P_GLAcctCreditDebitBalance.GrantID as rgrant_nbr,
P_GLAcctCreditDebitBalance.BudgetPeriod as rbudget_pd,
P_GLAcctCreditDebitBalance.PartnerFund as sfund,
P_GLAcctCreditDebitBalance.PartnerGrant as sgrant_nbr,
P_GLAcctCreditDebitBalance.PartnerBudgetPeriod as sbudget_pd,

///////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_JVA  Unified Journal Entry: Fields for Joint Venture Accounting
///////////////////////////////////////////////////////////////////////
P_GLAcctCreditDebitBalance.JointVenture as vname,
P_GLAcctCreditDebitBalance.JointVentureEquityGroup as egrup,
P_GLAcctCreditDebitBalance.JointVentureCostRecoveryCode as recid,
//P_GLAcctCreditDebitBalance.vptnr,
//P_GLAcctCreditDebitBalance.btype,
P_GLAcctCreditDebitBalance.JointVentureEquityType as etype,
//P_GLAcctCreditDebitBalance.prodper,

///////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_RE STRU  0 0 Unified Journal Entry: Fields for Real Estate
///////////////////////////////////////////////////////////////////////
//P_GLAcctCreditDebitBalance.swenr,
//P_GLAcctCreditDebitBalance.sgenr,
//P_GLAcctCreditDebitBalance.sgrnr,
//P_GLAcctCreditDebitBalance.smenr,
//P_GLAcctCreditDebitBalance.recnnr,
//P_GLAcctCreditDebitBalance.snksl,
//P_GLAcctCreditDebitBalance.sempsl,
P_GLAcctCreditDebitBalance.SettlementReferenceDate as dabrz,
//P_GLAcctCreditDebitBalance.pswenr,
//P_GLAcctCreditDebitBalance.psgenr,
//P_GLAcctCreditDebitBalance.psgrnr,
//P_GLAcctCreditDebitBalance.psmenr,
//P_GLAcctCreditDebitBalance.precnnr,
//P_GLAcctCreditDebitBalance.psnksl,
//P_GLAcctCreditDebitBalance.psempsl,
//P_GLAcctCreditDebitBalance.pdabrz,

P_GLAcctCreditDebitBalance.CostCenter as rcntr,
P_GLAcctCreditDebitBalance.CostCtrActivityType as lstar,
P_GLAcctCreditDebitBalance.OrderID as aufnr,
P_GLAcctCreditDebitBalance.OrderCategory as autyp,
P_GLAcctCreditDebitBalance.WBSElementInternalID as ps_psp_pnr,
P_GLAcctCreditDebitBalance.WBSElementExternalID as posid_edit,
P_GLAcctCreditDebitBalance.WBSElement as ps_posid,
P_GLAcctCreditDebitBalance.Project as ps_pspid,
P_GLAcctCreditDebitBalance.ProjectInternalID as ps_prj_pnr,
P_GLAcctCreditDebitBalance.ProjectExternalID as pspid_edit,
P_GLAcctCreditDebitBalance.PartnerProjectInternalID,
P_GLAcctCreditDebitBalance.PartnerProjectExternalID,
P_GLAcctCreditDebitBalance.SalesOrder as kdauf,
P_GLAcctCreditDebitBalance.SalesOrderItem as kdpos,

P_GLAcctCreditDebitBalance.ClearingDate as augdt,

P_GLAcctCreditDebitBalance.ConsolidationUnit,
P_GLAcctCreditDebitBalance.PartnerConsolidationUnit,
P_GLAcctCreditDebitBalance.Company, 
P_GLAcctCreditDebitBalance.ConsolidationChartOfAccounts,
P_GLAcctCreditDebitBalance.CnsldtnFinancialStatementItem,
P_GLAcctCreditDebitBalance.CnsldtnSubitemCategory,
P_GLAcctCreditDebitBalance.CnsldtnSubitem,  
@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.BalanceTransactionCurrency  as rtcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rtcur'} } P_GLAcctCreditDebitBalance.AmountInBalanceTransacCrcy  as tsl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.TransactionCurrency as rwcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rwcur'} } P_GLAcctCreditDebitBalance.AmountInTransactionCurrency as wsl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.CompanyCodeCurrency as rhcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rhcur'} } P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency as hsl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.GlobalCurrency as rkcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rkcur'} } P_GLAcctCreditDebitBalance.AmountInGlobalCurrency as ksl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FunctionalCurrency as FunctionalCurrency,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FunctionalCurrency'} }
P_GLAcctCreditDebitBalance.AmountInFunctionalCurrency as AmountInFunctionalCurrency,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency1 as rocur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rocur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency1 as osl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency2 as rvcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rvcur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency2 as vsl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency3 as rbcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rbcur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency3 as bsl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency4 as rccur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rccur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency4 as csl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency5 as rdcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rdcur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency5 as dsl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency6 as recur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'recur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency6 as esl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency7 as rfcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rfcur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency7 as fsl,

@Semantics.currencyCode:true
P_GLAcctCreditDebitBalance.FreeDefinedCurrency8 as rgcur,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rgcur'} } P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency8 as gsl,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rhcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInCoCodeCrcy as hsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rhcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInCoCodeCrcy as hsl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rwcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInTransCrcy as wsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rwcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInTransCrcy as wsl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rtcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInBalanceTransCrcy as tsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rtcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInBalanceTransCrcy as tsl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rkcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInGlobalCrcy as ksl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rkcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInGlobalCrcy as ksl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FunctionalCurrency'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFunctionalCrcy as DebitAmountInFunctionalCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FunctionalCurrency'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFunctionalCrcy as CreditAmountInFunctionalCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rocur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy1 as osl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rocur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy1 as osl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rvcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy2 as vsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rvcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy2 as vsl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rbcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy3 as bsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rbcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy3 as bsl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rccur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy4 as csl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rccur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy4 as csl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rdcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy5 as dsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rdcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy5 as dsl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'recur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy6 as esl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'recur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy6 as esl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rfcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy7 as fsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rfcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy7 as fsl_credit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rgcur'} } 
P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy8 as gsl_debit,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'rgcur'} } 
P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy8 as gsl_credit,

P_GLAcctCreditDebitBalance.FiscalPeriod as poper,

P_GLAcctCreditDebitBalance.OffsettingChartOfAccounts,
P_GLAcctCreditDebitBalance.JrnlEntryItemObsoleteReason,

cast( 0 as fis_end_bal_hsl ) as hsl_end_bal,
cast( 0 as fis_end_bal_wsl ) as wsl_end_bal,
cast( 0 as fis_end_bal_tsl ) as tsl_end_bal,
cast( 0 as fis_end_bal_ksl ) as ksl_end_bal,
cast( 0 as fis_end_bal_fcsl_ui ) as EndingBalanceAmtInFuncnlCrcy,
cast( 0 as fis_end_bal_osl ) as osl_end_bal,
cast( 0 as fis_end_bal_vsl ) as vsl_end_bal,
cast( 0 as fis_end_bal_bsl ) as bsl_end_bal,
cast( 0 as fis_end_bal_csl ) as csl_end_bal,
cast( 0 as fis_end_bal_dsl ) as dsl_end_bal,
cast( 0 as fis_end_bal_esl ) as esl_end_bal,
cast( 0 as fis_end_bal_fsl ) as fsl_end_bal,
cast( 0 as fis_end_bal_gsl ) as gsl_end_bal,

GLAccountAuthorizationGroup,
SupplierBasicAuthorizationGrp,
CustomerBasicAuthorizationGrp,
AcctgDocTypeAuthorizationGroup,
OrderType,
SalesOrderType,
AssetClass,
FiscalPeriodDate,
AccrualObjectType,
AccrualObject,
AccrualSubobject,
AccrualItemType,
AccrualObjectLogicalSystem,
AccrualReferenceObject,
AccrualValueDate,  

CashLedgerCompanyCode,
CashLedgerAccount,
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

// Associations
_PartnerProjectExternalID,
_PartnerProjctExtrnalIDText,
_PartnerWBSElementExternalID,
_PartnerWBSElemntExtrnalIDText,
_PartnerProjectBasicData,
_PartnerProjectBasicDataText,
_PartnerWBSElementBasicData,
_PartnerWBSElmntBasicDataText,

_InvtrySpclStockWBSElmntBD,
P_GLAcctCreditDebitBalance._InvtrySpclStockWBSElmntExtID,

P_GLAcctCreditDebitBalance._ServiceContract,
P_GLAcctCreditDebitBalance._ServiceContractItem,
P_GLAcctCreditDebitBalance._ServiceContractType,
P_GLAcctCreditDebitBalance._TimeSheetOvertimeCat,
P_GLAcctCreditDebitBalance._AccrualObjectType,
P_GLAcctCreditDebitBalance._AccrualObject,
P_GLAcctCreditDebitBalance._AccrualSubobject,
P_GLAcctCreditDebitBalance._AccrualItemType ,

P_GLAcctCreditDebitBalance._CashLedgerCompanyCode,
P_GLAcctCreditDebitBalance._CashLedgerAccount,
P_GLAcctCreditDebitBalance._FinancialManagementArea,
P_GLAcctCreditDebitBalance._FundsCenter,
P_GLAcctCreditDebitBalance._FundedProgram,
P_GLAcctCreditDebitBalance._Fund,
//P_GLAcctCreditDebitBalance._Grant,
P_GLAcctCreditDebitBalance._BudgetPeriod,
P_GLAcctCreditDebitBalance._PartnerFund,
//P_GLAcctCreditDebitBalance._PartnerGrant,
P_GLAcctCreditDebitBalance._PartnerBudgetPeriod,
P_GLAcctCreditDebitBalance._PubSecBudgetAccountCoCode,
P_GLAcctCreditDebitBalance._PubSecBudgetAccount,
P_GLAcctCreditDebitBalance._PubSecBudgetCnsmpnDate,
P_GLAcctCreditDebitBalance._PubSecBudgetCnsmpnFsclPeriod,
P_GLAcctCreditDebitBalance._PubSecBudgetCnsmpnFsclYear,
P_GLAcctCreditDebitBalance._PubSecBudgetCnsmpnType,
P_GLAcctCreditDebitBalance._PubSecBudgetCnsmpnAmtType,  
P_GLAcctCreditDebitBalance._FunctionalCurrency,

_ConsolidationUnit,
_PartnerConsolidationUnit,
_Company,
_ConsolidationChartOfAccounts,
_CnsldtnFinancialStatementItem,
_CnsldtnSubitemCategory,
_CnsldtnSubitem, 
_CustomerCompany,
_SupplierCompany,
//cast( concat( P_GLAcctCreditDebitBalance.FiscalPeriod, P_GLAcctCreditDebitBalance.PostingDate ) as FIS_FISCALPERIODDATE ) as FiscalPeriodDate

cast( '2         ' as fis_glaccount_flow_type preserving type ) as GLAccountFlowType


}
