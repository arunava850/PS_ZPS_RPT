// SQL View Name
@AbapCatalog.sqlViewName: 'ZIFIGLSUMACDOCA'
@EndUserText.label: 'Summary FIGL View'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true

// Auth Check
//@AccessControl.authorizationCheck: #CHECK

// Type: Composite Cube
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

// Other Properties
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass:  #MIXED
@ObjectModel.usageType.serviceQuality: #D
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #NOT_ALLOWED
@Metadata.allowExtensions:true


define view ZI_FIGL_SUM_ACDOCA
  with parameters
    P_VARNT : fis_periv,
    P_DATE  : abap.dats,
    P_HIER  : hryid, // GL
    P_HIER1 : hryid, //Profit Center
    P_HIER2 : hryid  //Cost Center
  //P_GLAC  : racct
  as select from    ZI_DT_FISCPER_CDS( P_VARNT : $parameters.P_VARNT, P_DATE  : $parameters.P_DATE ) as a
    join            ZI_GLAC_BAL                                                                      as P_GLAcctCreditDebitBalance on P_GLAcctCreditDebitBalance.FiscalYearVariant = a.fiscal_year_variant
    left outer join ZI_FI_VERSION_HIER                                                               as hr                         on  hr.stmt_ver                          = $parameters.P_HIER
                                                                                                                                   and hr.nodetype                          = 'D'
                                                                                                                                   and hr.parent_valid_to                   = '99991231'
                                                                                                                                   and P_GLAcctCreditDebitBalance.GLAccount = hr.hrynode

    left outer join I_ProfitCenterHierarchyNode                                                      as PrctrNode                  on  PrctrNode.ProfitCenterHierarchy            = $parameters.P_HIER1
                                                                                                                                   and P_GLAcctCreditDebitBalance.ControllingArea = PrctrNode.ControllingArea
                                                                                                                                   and P_GLAcctCreditDebitBalance.ProfitCenter    = PrctrNode.HierarchyNode
                                                                                                                                   and PrctrNode.ValidityEndDate                  = '99991231'

    left outer join I_CostCenterHierarchyNode                                                        as CctrNode                   on  CctrNode.CostCenterHierarchy               = $parameters.P_HIER2
                                                                                                                                   and P_GLAcctCreditDebitBalance.ControllingArea = CctrNode.ControllingArea
                                                                                                                                   and CctrNode.ValidityEndDate                   = '99991231'
                                                                                                                                   and P_GLAcctCreditDebitBalance.CostCenter      = CctrNode.CostCenter
{
  key P_GLAcctCreditDebitBalance.Ledger,
  key P_GLAcctCreditDebitBalance.CompanyCode,
  key P_GLAcctCreditDebitBalance.fiscyearper,
  key P_GLAcctCreditDebitBalance.FiscalYear,
  key P_GLAcctCreditDebitBalance.AccountingDocument,
  key P_GLAcctCreditDebitBalance.LedgerGLLineItem                     as docln,
  key P_GLAcctCreditDebitBalance.SourceLedger,

      P_GLAcctCreditDebitBalance.FiscalPeriod                         as FiscalYearPeriod,
      a.Curr_Date                                                     as RptDt,

      hr.stmt_ver                                                     as GLAccountHierarchy,
      P_GLAcctCreditDebitBalance.GLAccount,

      P_GLAcctCreditDebitBalance.ControllingArea,
      cast($parameters.P_HIER1 as fis_hryid_prctr)                    as ProfitCenterHierarchy,
      P_GLAcctCreditDebitBalance.ProfitCenter,

      cast($parameters.P_HIER2 as fis_hryid_cctr)                     as CostCenterHierarchy,
      P_GLAcctCreditDebitBalance.CostCenter,

      P_GLAcctCreditDebitBalance.LedgerFiscalYear,
      //P_GLAcctCreditDebitBalance.GLRecordType as rrcty,

      ///////////////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_00  Unified Journal Entry: Transaction, Currencies, Units
      ///////////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.FinancialTransactionType,
      P_GLAcctCreditDebitBalance.BusinessTransactionType,
      P_GLAcctCreditDebitBalance.ReferenceDocumentType,
      P_GLAcctCreditDebitBalance.LogicalSystem,
      P_GLAcctCreditDebitBalance.ReferenceDocumentContext,
      P_GLAcctCreditDebitBalance.ReferenceDocument,
      P_GLAcctCreditDebitBalance.ReferenceDocumentItem,
      P_GLAcctCreditDebitBalance.ReferenceDocumentItemGroup,
      ////P_GLAcctCreditDebitBalance.SUBTA,
      P_GLAcctCreditDebitBalance.IsReversal,
      P_GLAcctCreditDebitBalance.IsReversed,
      ////P_GLAcctCreditDebitBalance.XTRUEREV,
      ////P_GLAcctCreditDebitBalance.AWTYP_REV,
      P_GLAcctCreditDebitBalance.ReversalReferenceDocumentCntxt,
      P_GLAcctCreditDebitBalance.ReversalReferenceDocument,
      ////P_GLAcctCreditDebitBalance.SUBTA_REV,
      P_GLAcctCreditDebitBalance.IsSettlement,
      P_GLAcctCreditDebitBalance.IsSettled,
      P_GLAcctCreditDebitBalance.PredecessorReferenceDocType,
      P_GLAcctCreditDebitBalance.PredecessorReferenceDocCntxt,
      P_GLAcctCreditDebitBalance.PredecessorReferenceDocument,
      P_GLAcctCreditDebitBalance.PredecessorReferenceDocItem,
      //P_GLAcctCreditDebitBalance.PREC_SUBTA,

      //P_GLAcctCreditDebitBalance.GLAccount as racct,

      ////////////////////////////////////////////////////////////////////////////////////
      // .INCLUDE  ACDOC_SI_GL_ACCAS Unified Journal Entry: G/L additional account assignments
      ////////////////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.FunctionalArea,
      P_GLAcctCreditDebitBalance.BusinessArea,
      P_GLAcctCreditDebitBalance.Segment,
      P_GLAcctCreditDebitBalance.PartnerCostCenter,
      P_GLAcctCreditDebitBalance.PartnerProfitCenter,
      P_GLAcctCreditDebitBalance.PartnerFunctionalArea,
      P_GLAcctCreditDebitBalance.PartnerBusinessArea,
      P_GLAcctCreditDebitBalance.PartnerCompany,
      P_GLAcctCreditDebitBalance.PartnerSegment,

      /////////////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_FIX  Unified Journal Entry: Mandatory fields for G/L
      ////////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.DebitCreditCode,
      P_GLAcctCreditDebitBalance.FiscalYearVariant,

      //P_GLAcctCreditDebitBalance.PostingDate as budat,
      //cast( ( case when P_GLAcctCreditDebitBalance.IsPeriodBasedBalanceReporting = 'X' then '00000000'
      //                                                                                 else P_GLAcctCreditDebitBalance.PostingDate
      //        end )
      //as fis_budat ) as budat,
      P_GLAcctCreditDebitBalance.PostingDate,
      //P_GLAcctCreditDebitBalance.bldat,
      P_GLAcctCreditDebitBalance.AccountingDocumentType,
      P_GLAcctCreditDebitBalance.AccountingDocumentItem,
      P_GLAcctCreditDebitBalance.AssignmentReference,
      P_GLAcctCreditDebitBalance.PostingKey,
      P_GLAcctCreditDebitBalance.AccountingDocumentCategory,
      P_GLAcctCreditDebitBalance.TransactionTypeDetermination,
      P_GLAcctCreditDebitBalance.SubLedgerAcctLineItemType,
      P_GLAcctCreditDebitBalance.AccountingDocCreatedByUser,
      //P_GLAcctCreditDebitBalance.timestamp,
      P_GLAcctCreditDebitBalance.EliminationProfitCenter,
      P_GLAcctCreditDebitBalance.OriginObjectType,
      P_GLAcctCreditDebitBalance.GLAccountType,
      P_GLAcctCreditDebitBalance.ChartOfAccounts,
      P_GLAcctCreditDebitBalance.AlternativeGLAccount,
      P_GLAcctCreditDebitBalance.CountryChartOfAccounts,
      P_GLAcctCreditDebitBalance.CreationDateTime,

      ///////////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_GEN  Unified Journal Entry: Fields for several subledgers
      //////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.InvoiceReference,
      P_GLAcctCreditDebitBalance.InvoiceReferenceFiscalYear,
      P_GLAcctCreditDebitBalance.FollowOnDocumentType,
      P_GLAcctCreditDebitBalance.InvoiceItemReference,
      P_GLAcctCreditDebitBalance.ReferencePurchaseOrderCategory,
      P_GLAcctCreditDebitBalance.PurchasingDocument,
      P_GLAcctCreditDebitBalance.PurchasingDocumentItem,
      P_GLAcctCreditDebitBalance.AccountAssignmentNumber,
      P_GLAcctCreditDebitBalance.DocumentItemText,
      P_GLAcctCreditDebitBalance.Plant,
      P_GLAcctCreditDebitBalance.Supplier,
      P_GLAcctCreditDebitBalance.Customer,

      P_GLAcctCreditDebitBalance.Product,
      P_GLAcctCreditDebitBalance.SoldProduct,
      P_GLAcctCreditDebitBalance.SoldProductGroup,
      P_GLAcctCreditDebitBalance.ProductGroup,

      /////////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_FI  Unified Journal Entry: Fields for FI subledgers
      /////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.FinancialAccountType,
      P_GLAcctCreditDebitBalance.SpecialGLCode,
      P_GLAcctCreditDebitBalance.TaxCode,
      P_GLAcctCreditDebitBalance.HouseBank,
      P_GLAcctCreditDebitBalance.HouseBankAccount,
      P_GLAcctCreditDebitBalance.IsOpenItemManaged,
      //P_GLAcctCreditDebitBalance.augdt,
      P_GLAcctCreditDebitBalance.ClearingAccountingDocument,
      P_GLAcctCreditDebitBalance.ClearingDocFiscalYear,
      //P_GLAcctCreditDebitBalance.IsCleared as xaugp,


      /////////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_FAA  Unified Journal Entry: Fields for Asset Accounting
      /////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.AssetDepreciationArea,
      P_GLAcctCreditDebitBalance.MasterFixedAsset,
      P_GLAcctCreditDebitBalance.FixedAsset,
      P_GLAcctCreditDebitBalance.AssetValueDate,
      P_GLAcctCreditDebitBalance.AssetTransactionType,
      P_GLAcctCreditDebitBalance.AssetAcctTransClassfctn,
      P_GLAcctCreditDebitBalance.DepreciationFiscalPeriod,
      P_GLAcctCreditDebitBalance.GroupMasterFixedAsset,
      P_GLAcctCreditDebitBalance.GroupFixedAsset,
      //P_GLAcctCreditDebitBalance.settlement_rule,

      //////////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_ML Unified Journal Entry: Fields for Material Ledger
      //////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.CostEstimate,
      P_GLAcctCreditDebitBalance.InventorySpecialStockValnType,
      //P_GLAcctCreditDebitBalance.xobew,
      P_GLAcctCreditDebitBalance.InventorySpecialStockType,
      P_GLAcctCreditDebitBalance.InventorySpclStkSalesDocument,
      P_GLAcctCreditDebitBalance.InvtrySpclStockWBSElmntExtID,
      P_GLAcctCreditDebitBalance.InventorySpclStkSalesDocItm,
      P_GLAcctCreditDebitBalance.InvtrySpclStockWBSElmntIntID,
      P_GLAcctCreditDebitBalance.InventorySpclStockWBSElement,
      P_GLAcctCreditDebitBalance.PartnerWBSElementInternalID,
      P_GLAcctCreditDebitBalance.PartnerWBSElementExternalID,
      P_GLAcctCreditDebitBalance.InventorySpecialStockSupplier,
      P_GLAcctCreditDebitBalance.InventoryValuationType,
      P_GLAcctCreditDebitBalance.ValuationArea,

      ////////////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_CFIN   Unified Journal Entry: Fields for Central Finance
      //////////////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.SenderCompanyCode,
      P_GLAcctCreditDebitBalance.SenderGLAccount                      as racct_sender,
      P_GLAcctCreditDebitBalance.SenderAccountAssignment              as accas_sender,
      P_GLAcctCreditDebitBalance.SenderAccountAssignmentType          as accasty_sender,

      ////////////////////////////////////////////////////////////////////////////
      //  .INCLUDE  ACDOC_SI_CO  Unified Journal Entry: CO fields
      ///////////////////////////////////////////////////////////////////////////
      //P_GLAcctCreditDebitBalance.UtilsProfileConstcyChkGrp as hkgrp,
      //P_GLAcctCreditDebitBalance.ControllingDebitCreditCode as co_belkz,
      P_GLAcctCreditDebitBalance.ControllingObjectDebitType           as beltp,
      P_GLAcctCreditDebitBalance.QuantityIsIncomplete                 as muvflg,
      P_GLAcctCreditDebitBalance.OffsettingAccount                    as gkont,
      P_GLAcctCreditDebitBalance.OffsettingAccountType                as gkoar,
      P_GLAcctCreditDebitBalance.LineItemIsCompleted                  as erlkz,
      P_GLAcctCreditDebitBalance.PersonnelNumber                      as pernr,
      P_GLAcctCreditDebitBalance.ControllingObjectClass               as scope,
      P_GLAcctCreditDebitBalance.PartnerCompanyCode                   as pbukrs,
      P_GLAcctCreditDebitBalance.PartnerControllingObjectClass        as pscope,
      //P_GLAcctCreditDebitBalance.aufnr_org,
      P_GLAcctCreditDebitBalance.OriginCostCenter                     as ukostl,
      P_GLAcctCreditDebitBalance.OriginCostCtrActivityType            as ulstar,
      P_GLAcctCreditDebitBalance.OriginProduct,
      P_GLAcctCreditDebitBalance.VarianceOriginGLAccount,
      P_GLAcctCreditDebitBalance.AccountAssignment                    as accas,
      P_GLAcctCreditDebitBalance.AccountAssignmentType                as accasty,
      P_GLAcctCreditDebitBalance.ProjectNetwork                       as nplnr,
      P_GLAcctCreditDebitBalance.RelatedNetworkActivity               as nplnr_vorgn,
      P_GLAcctCreditDebitBalance.BusinessProcess                      as prznr,
      P_GLAcctCreditDebitBalance.CostObject                           as kstrg,
      //P_GLAcctCreditDebitBalance.bemot,
      P_GLAcctCreditDebitBalance.CustomerServiceNotification          as qmnum,
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
      P_GLAcctCreditDebitBalance.OperatingConcern                     as erkrs,
      P_GLAcctCreditDebitBalance.PartnerAccountAssignment             as paccas,
      P_GLAcctCreditDebitBalance.PartnerAccountAssignmentType         as paccasty,
      P_GLAcctCreditDebitBalance.PartnerCostCtrActivityType           as plstar,
      P_GLAcctCreditDebitBalance.PartnerOrder                         as paufnr,

      P_GLAcctCreditDebitBalance.PartnerOrderCategory                 as pautyp,
      P_GLAcctCreditDebitBalance.PartnerWBSElement                    as pps_posid,
      P_GLAcctCreditDebitBalance.PartnerProject                       as pps_pspid,
      P_GLAcctCreditDebitBalance.PartnerSalesDocument                 as pkdauf,
      P_GLAcctCreditDebitBalance.PartnerSalesDocumentItem             as pkdpos,
      P_GLAcctCreditDebitBalance.PartnerProjectNetwork                as pnplnr,
      P_GLAcctCreditDebitBalance.PartnerProjectNetworkActivity        as pnplnr_vorgn,
      P_GLAcctCreditDebitBalance.PartnerBusinessProcess               as pprznr,
      P_GLAcctCreditDebitBalance.PartnerCostObject                    as pkstrg,

      //////////////////////////////////////////////////////////////////////
      //  .INCLUDE  ACDOC_SI_COPA  Unified Journal Entry: CO-PA fields
      //////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.BillingDocumentType                  as fkart,
      P_GLAcctCreditDebitBalance.SalesOrganization                    as vkorg,
      P_GLAcctCreditDebitBalance.DistributionChannel                  as vtweg,
      P_GLAcctCreditDebitBalance.OrganizationDivision                 as spart,
      P_GLAcctCreditDebitBalance.CustomerGroup                        as kdgrp,

      //////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_PS  Unified Journal Entry: Fields for Public Sector
      /////////////////////////////////////////////////////////////////////
      //P_GLAcctCreditDebitBalance.re_bukrs,
      //P_GLAcctCreditDebitBalance.re_account,
      P_GLAcctCreditDebitBalance.FinancialManagementArea              as fikrs,
      P_GLAcctCreditDebitBalance.Fund                                 as rfund,
      P_GLAcctCreditDebitBalance.GrantID                              as rgrant_nbr,
      P_GLAcctCreditDebitBalance.BudgetPeriod                         as rbudget_pd,
      P_GLAcctCreditDebitBalance.PartnerFund                          as sfund,
      P_GLAcctCreditDebitBalance.PartnerGrant                         as sgrant_nbr,
      P_GLAcctCreditDebitBalance.PartnerBudgetPeriod                  as sbudget_pd,

      ///////////////////////////////////////////////////////////////////////
      // .INCLUDE ACDOC_SI_JVA  Unified Journal Entry: Fields for Joint Venture Accounting
      ///////////////////////////////////////////////////////////////////////
      P_GLAcctCreditDebitBalance.JointVenture                         as vname,
      P_GLAcctCreditDebitBalance.JointVentureEquityGroup              as egrup,
      P_GLAcctCreditDebitBalance.JointVentureCostRecoveryCode         as recid,
      //P_GLAcctCreditDebitBalance.vptnr,
      //P_GLAcctCreditDebitBalance.btype,
      P_GLAcctCreditDebitBalance.JointVentureEquityType               as etype,
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
      P_GLAcctCreditDebitBalance.SettlementReferenceDate              as dabrz,
      //P_GLAcctCreditDebitBalance.pswenr,
      //P_GLAcctCreditDebitBalance.psgenr,
      //P_GLAcctCreditDebitBalance.psgrnr,
      //P_GLAcctCreditDebitBalance.psmenr,
      //P_GLAcctCreditDebitBalance.precnnr,
      //P_GLAcctCreditDebitBalance.psnksl,
      //P_GLAcctCreditDebitBalance.psempsl,
      //P_GLAcctCreditDebitBalance.pdabrz,

      P_GLAcctCreditDebitBalance.CostCtrActivityType                  as lstar,
      P_GLAcctCreditDebitBalance.OrderID                              as aufnr,
      P_GLAcctCreditDebitBalance.OrderCategory                        as autyp,
      P_GLAcctCreditDebitBalance.WBSElementInternalID                 as ps_psp_pnr,
      P_GLAcctCreditDebitBalance.WBSElementExternalID                 as posid_edit,
      P_GLAcctCreditDebitBalance.WBSElement                           as ps_posid,
      P_GLAcctCreditDebitBalance.Project                              as ps_pspid,
      P_GLAcctCreditDebitBalance.ProjectInternalID                    as ps_prj_pnr,
      P_GLAcctCreditDebitBalance.ProjectExternalID                    as pspid_edit,
      P_GLAcctCreditDebitBalance.PartnerProjectInternalID,
      P_GLAcctCreditDebitBalance.PartnerProjectExternalID,
      P_GLAcctCreditDebitBalance.SalesOrder                           as kdauf,
      P_GLAcctCreditDebitBalance.SalesOrderItem                       as kdpos,

      P_GLAcctCreditDebitBalance.ClearingDate                         as augdt,

      P_GLAcctCreditDebitBalance.ConsolidationUnit,
      P_GLAcctCreditDebitBalance.PartnerConsolidationUnit,
      P_GLAcctCreditDebitBalance.Company,
      P_GLAcctCreditDebitBalance.ConsolidationChartOfAccounts,
      P_GLAcctCreditDebitBalance.CnsldtnFinancialStatementItem,
      P_GLAcctCreditDebitBalance.CnsldtnSubitemCategory,
      P_GLAcctCreditDebitBalance.CnsldtnSubitem,
      //###############################################
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.PostingDate between a.fiscal_period_start_date and a.Curr_Date then P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency
          else 0
          end  as fins_vhcur12)                                       as hsl_mtd,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper = a.fiscal_year_period then P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency
          else 0
          end  as fins_vhcur12)                                       as hsl_period,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper
               between a.CUR_QTR_FROM_PER and a.CUR_QTR_TO_PER
               then P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency
          else 0
          end  as fins_vhcur12)                                       as hsl_curr_qtr,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper
               between a.CUR_PREV_QTR_FROM_PER and a.CUR_PREV_QTR_TO_PER
               then P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency
          else 0
          end  as fins_vhcur12)                                       as hsl_prev_qtr,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper
               between a.PREV_YR_SAME_QTR_FROM_PER and a.PREV_YR_SAME_QTR_TO_PER
               then P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency
          else 0
          end  as fins_vhcur12)                                       as hsl_curr_qtr_prev_yr,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.FiscalYear = a.fiscal_year
               then P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency
          else 0
          end  as fins_vhcur12)                                       as hsl_ytd,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.FiscalYearInt = a.Prev2YearInt
               then P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency
          else 0
          end  as fins_vhcur12)                                       as hsl_prevyr2_ytd,
      //###############################################
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper = a.fiscal_year_period then P_GLAcctCreditDebitBalance.AmountInTransactionCurrency
          else 0
          end  as fins_vwcur12)                                       as wsl_period,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper
               between a.CUR_QTR_FROM_PER and a.CUR_QTR_TO_PER
               then P_GLAcctCreditDebitBalance.AmountInTransactionCurrency
          else 0
          end  as fins_vwcur12)                                       as wsl_qtr,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.FiscalYear = a.fiscal_year
               then P_GLAcctCreditDebitBalance.AmountInTransactionCurrency
          else 0
          end  as fins_vwcur12)                                       as wsl_ytd,
      //###############################################
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper = a.fiscal_year_period then P_GLAcctCreditDebitBalance.AmountInGlobalCurrency
          else 0
          end  as fins_vkcur12)                                       as ksl_period,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.fiscyearper
               between a.CUR_QTR_FROM_PER and a.CUR_QTR_TO_PER
               then P_GLAcctCreditDebitBalance.AmountInGlobalCurrency
          else 0
          end  as fins_vkcur12)                                       as ksl_qtr,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      cast(
          case
          when P_GLAcctCreditDebitBalance.FiscalYear = a.fiscal_year
               then P_GLAcctCreditDebitBalance.AmountInGlobalCurrency
          else 0
          end  as fins_vkcur12)                                       as ksl_ytd,
      //###############################################
      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.BalanceTransactionCurrency           as rtcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rtcur'} }
      P_GLAcctCreditDebitBalance.AmountInBalanceTransacCrcy           as tsl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.TransactionCurrency                  as rwcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rwcur'} }
      P_GLAcctCreditDebitBalance.AmountInTransactionCurrency          as wsl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.CompanyCodeCurrency                  as rhcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      P_GLAcctCreditDebitBalance.AmountInCompanyCodeCurrency          as hsl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.GlobalCurrency                       as rkcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rkcur'} }
      P_GLAcctCreditDebitBalance.AmountInGlobalCurrency               as ksl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FunctionalCurrency                   as FunctionalCurrency,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'FunctionalCurrency'} }
      P_GLAcctCreditDebitBalance.AmountInFunctionalCurrency           as AmountInFunctionalCurrency,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency1                 as rocur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rocur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency1         as osl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency2                 as rvcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rvcur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency2         as vsl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency3                 as rbcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rbcur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency3         as bsl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency4                 as rccur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rccur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency4         as csl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency5                 as rdcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rdcur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency5         as dsl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency6                 as recur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'recur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency6         as esl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency7                 as rfcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rfcur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency7         as fsl,

      @Semantics.currencyCode:true
      P_GLAcctCreditDebitBalance.FreeDefinedCurrency8                 as rgcur,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rgcur'} }
      P_GLAcctCreditDebitBalance.AmountInFreeDefinedCurrency8         as gsl,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInCoCodeCrcy              as hsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rhcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInCoCodeCrcy             as hsl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rwcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInTransCrcy               as wsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rwcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInTransCrcy              as wsl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rtcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInBalanceTransCrcy        as tsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rtcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInBalanceTransCrcy       as tsl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rkcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInGlobalCrcy              as ksl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rkcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInGlobalCrcy             as ksl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'FunctionalCurrency'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFunctionalCrcy          as DebitAmountInFunctionalCrcy,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'FunctionalCurrency'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFunctionalCrcy         as CreditAmountInFunctionalCrcy,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rocur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy1        as osl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rocur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy1       as osl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rvcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy2        as vsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rvcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy2       as vsl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rbcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy3        as bsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rbcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy3       as bsl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rccur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy4        as csl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rccur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy4       as csl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rdcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy5        as dsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rdcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy5       as dsl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'recur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy6        as esl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'recur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy6       as esl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rfcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy7        as fsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rfcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy7       as fsl_credit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rgcur'} }
      P_GLAcctCreditDebitBalance.DebitAmountInFreeDefinedCrcy8        as gsl_debit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'rgcur'} }
      P_GLAcctCreditDebitBalance.CreditAmountInFreeDefinedCrcy8       as gsl_credit,

      P_GLAcctCreditDebitBalance.FiscalPeriod                         as poper,

      P_GLAcctCreditDebitBalance.OffsettingChartOfAccounts,
      P_GLAcctCreditDebitBalance.JrnlEntryItemObsoleteReason,

      cast( 0 as fis_end_bal_hsl )                                    as hsl_end_bal,
      cast( 0 as fis_end_bal_wsl )                                    as wsl_end_bal,
      cast( 0 as fis_end_bal_tsl )                                    as tsl_end_bal,
      cast( 0 as fis_end_bal_ksl )                                    as ksl_end_bal,
      cast( 0 as fis_end_bal_fcsl_ui )                                as EndingBalanceAmtInFuncnlCrcy,
      cast( 0 as fis_end_bal_osl )                                    as osl_end_bal,
      cast( 0 as fis_end_bal_vsl )                                    as vsl_end_bal,
      cast( 0 as fis_end_bal_bsl )                                    as bsl_end_bal,
      cast( 0 as fis_end_bal_csl )                                    as csl_end_bal,
      cast( 0 as fis_end_bal_dsl )                                    as dsl_end_bal,
      cast( 0 as fis_end_bal_esl )                                    as esl_end_bal,
      cast( 0 as fis_end_bal_fsl )                                    as fsl_end_bal,
      cast( 0 as fis_end_bal_gsl )                                    as gsl_end_bal,

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
      P_GLAcctCreditDebitBalance._AccrualItemType,

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
where
       P_GLAcctCreditDebitBalance.Ledger        = '0L'
  and(
       P_GLAcctCreditDebitBalance.FiscalYearInt = a.FiscalYearInt
    or P_GLAcctCreditDebitBalance.FiscalYearInt = a.PrevYearInt
    or P_GLAcctCreditDebitBalance.FiscalYearInt = a.Prev2YearInt
  )
