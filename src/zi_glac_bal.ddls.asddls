@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.sqlViewName: 'ZIFIGLBALANCE'
@EndUserText.label: 'G/L Account Balance'
@VDM.viewType: #COMPOSITE
@AccessControl.authorizationCheck: #CHECK
@Analytics: { dataCategory: #CUBE }  //, dataExtraction.enabled: true }
//@ObjectModel.representativeKey: 'FiscalPeriodDate'
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #NOT_ALLOWED 
@Metadata.ignorePropagatedAnnotations: true 
@Metadata.allowExtensions: true
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED
@AccessControl.personalData.blocking: #REQUIRED 
@Consumption.dbHints:  ['AGGR_TARGET("ACDOCA")','NO_JOIN_THRU_AGGR']        
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_PROVIDER ]
@ObjectModel.modelingPattern: #ANALYTICAL_CUBE 

define view ZI_GLAC_BAL
as select from ZI_GLAC_BALANCE as P_GLAcctBalance
association[1]    to I_CompanyCode            as _CompanyCode                on $projection.CompanyCode = _CompanyCode.CompanyCode
association[0..1] to I_JournalEntry           as _JournalEntry               on $projection.CompanyCode        = _JournalEntry.CompanyCode and 
                                                                                $projection.FiscalYear         = _JournalEntry.FiscalYear and 
                                                                                $projection.AccountingDocument = _JournalEntry.AccountingDocument 
association [0..1] to I_FiscalYearForCompanyCode  as _FiscalYear             on $projection.FiscalYear         = _FiscalYear.FiscalYear
                                                                                and $projection.CompanyCode    = _FiscalYear.CompanyCode  
association[0..1] to I_ControllingArea        as _ControllingArea            on $projection.ControllingArea = _ControllingArea.ControllingArea

association[0..1] to I_Currency               as _BalanceTransactionCurrency on $projection.BalanceTransactionCurrency = _BalanceTransactionCurrency.Currency 
association[0..1] to I_Currency               as _TransactionCurrency        on $projection.TransactionCurrency = _TransactionCurrency.Currency                                                                                                              
association[1]    to I_Currency               as _CompanyCodeCurrency        on $projection.CompanyCodeCurrency = _CompanyCodeCurrency.Currency 
association[0..1] to I_Currency               as _GlobalCurrency             on $projection.GlobalCurrency = _GlobalCurrency.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency1       on $projection.FreeDefinedCurrency1 = _FreeDefinedCurrency1.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency2       on $projection.FreeDefinedCurrency2 = _FreeDefinedCurrency2.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency3       on $projection.FreeDefinedCurrency3 = _FreeDefinedCurrency3.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency4       on $projection.FreeDefinedCurrency4 = _FreeDefinedCurrency4.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency5       on $projection.FreeDefinedCurrency5 = _FreeDefinedCurrency5.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency6       on $projection.FreeDefinedCurrency6 = _FreeDefinedCurrency6.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency7       on $projection.FreeDefinedCurrency7 = _FreeDefinedCurrency7.Currency 
association[0..1] to I_Currency               as _FreeDefinedCurrency8       on $projection.FreeDefinedCurrency8 = _FreeDefinedCurrency8.Currency 

association[0..1] to I_Segment                as _Segment                    on $projection.Segment = _Segment.Segment
association[0..1] to I_Segment                as _PartnerSegment             on $projection.PartnerSegment = _PartnerSegment.Segment
association[0..*] to I_ProfitCenter           as _ProfitCenter               on $projection.ControllingArea = _ProfitCenter.ControllingArea and  
                                                                                $projection.ProfitCenter = _ProfitCenter.ProfitCenter
association[0..*] to I_ProfitCenter           as _PartnerProfitCenter        on $projection.ControllingArea = _PartnerProfitCenter.ControllingArea and  
                                                                                $projection.PartnerProfitCenter = _PartnerProfitCenter.ProfitCenter
association[0..1] to I_ProfitCenter           as _CurrentProfitCenter        on $projection.ControllingArea            = _CurrentProfitCenter.ControllingArea and
                                                                                $projection.ProfitCenter               = _CurrentProfitCenter.ProfitCenter and
                                                                                _CurrentProfitCenter.ValidityStartDate <= $session.system_date and
                                                                                _CurrentProfitCenter.ValidityEndDate   >= $session.system_date
association[0..*] to I_CostCenter             as _CostCenter                 on $projection.ControllingArea = _CostCenter.ControllingArea and  
                                                                                $projection.CostCenter = _CostCenter.CostCenter
association[0..1] to I_CostCenter             as _CurrentCostCenter          on $projection.ControllingArea          = _CurrentCostCenter.ControllingArea and
                                                                                $projection.CostCenter               = _CurrentCostCenter.CostCenter and
                                                                                _CurrentCostCenter.ValidityStartDate <= $session.system_date and
                                                                                _CurrentCostCenter.ValidityEndDate   >= $session.system_date
association[0..*] to I_CostCenter             as _PartnerCostCenter          on $projection.ControllingArea = _PartnerCostCenter.ControllingArea and  
                                                                                $projection.PartnerCostCenter = _PartnerCostCenter.CostCenter
association[0..1] to I_BusinessArea           as _BusinessArea               on $projection.BusinessArea = _BusinessArea.BusinessArea
association[0..1] to I_BusinessArea           as _PartnerBusinessArea        on $projection.PartnerBusinessArea = _PartnerBusinessArea.BusinessArea
association[0..1] to I_FunctionalArea         as _FunctionalArea             on $projection.FunctionalArea = _FunctionalArea.FunctionalArea
association[0..1] to I_FunctionalArea         as _PartnerFunctionalArea      on $projection.PartnerFunctionalArea = _PartnerFunctionalArea.FunctionalArea

association[0..1] to I_GLAccountInChartOfAccounts as _GLAccountInChartOfAccounts on $projection.ChartOfAccounts = _GLAccountInChartOfAccounts.ChartOfAccounts and 
                                                                                    $projection.GLAccount = _GLAccountInChartOfAccounts.GLAccount 

association[0..1] to I_GLAccountInChartOfAccounts as _GLAccountHierarchy     on $projection.ChartOfAccounts = _GLAccountHierarchy.ChartOfAccounts and 
                                                                                $projection.GLAccountHierarchy = _GLAccountHierarchy.GLAccount 

association[1]    to I_ChartOfAccounts        as _ChartOfAccounts            on $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts 
association[0..1] to I_GLAccountInCompanyCode as _GLAccountInCompanyCode     on $projection.CompanyCode                = _GLAccountInCompanyCode.CompanyCode and
                                                                                $projection.GLAccount                  = _GLAccountInCompanyCode.GLAccount

association[0..1] to I_AccountingDocumentType as _AccountingDocumentType     on $projection.AccountingDocumentType = _AccountingDocumentType.AccountingDocumentType
association[0..1] to I_FinancialAccountType   as _FinancialAccountType       on $projection.FinancialAccountType = _FinancialAccountType.FinancialAccountType
association[1]    to I_DebitCreditCode        as _DebitCreditCode            on $projection.DebitCreditCode = _DebitCreditCode.DebitCreditCode

association[0..1] to I_Material               as _Material                   on  $projection.Material = _Material.Material  //do not use any longer, use _Product
association[0..1] to I_Product                as _Product                    on  $projection.Product = _Product.Product
association[0..1] to I_Plant                  as _Plant                      on $projection.Plant = _Plant.Plant
association[0..1] to I_Ledger                 as _Ledger                     on $projection.Ledger = _Ledger.Ledger

association[0..1] to I_CustomerGroup          as _CustomerGroup              on $projection.CustomerGroup = _CustomerGroup.CustomerGroup
association[0..1] to I_MaterialGroup          as _MaterialGroup              on  $projection.MaterialGroup = _MaterialGroup.MaterialGroup //do not use any longer, use _ProductGroup
association[0..1] to I_ProductGroup           as _ProductGroup               on  $projection.ProductGroup = _ProductGroup.MaterialGroup
//association [0..1] to I_ProductGroup_2        as _ProductGroup_2             on  $projection.ProductGroup = _ProductGroup_2.ProductGroup  
association [0..1] to I_ProductGroup          as _SoldProductGroup           on  $projection.SoldProductGroup = _SoldProductGroup.MaterialGroup
  association [0..1] to I_ProductGroup_2      as _SoldProductGroup_2         on  $projection.SoldProductGroup = _SoldProductGroup_2.ProductGroup

association [0..1] to I_Customer              as _Customer                   on $projection.Customer = _Customer.Customer
association [0..1] to I_Supplier              as _Supplier                   on $projection.Supplier = _Supplier.Supplier

association [0..1] to I_CalendarDate          as _CalendarDate               on $projection.PostingDate = _CalendarDate.CalendarDate

association[0..1] to I_Ledger                 as _SourceLedger               on $projection.SourceLedger = _SourceLedger.Ledger

association[0..1] to I_PostingKey             as _PostingKey                 on $projection.PostingKey = _PostingKey.PostingKey
association[0..*] to I_ProfitCenter           as _EliminationProfitCenter    on $projection.ControllingArea = _EliminationProfitCenter.ControllingArea and  
                                                                                $projection.EliminationProfitCenter = _EliminationProfitCenter.ProfitCenter
association [0..1] to I_Supplier              as _InventorySpecialStockSupplier 
                                                                             on $projection.InventorySpecialStockSupplier = _InventorySpecialStockSupplier.Supplier
association[0..1] to I_GLAccountInChartOfAccounts as _AlternativeGLAccount   on $projection.CountryChartOfAccounts = _AlternativeGLAccount.ChartOfAccounts and 
                                                                             $projection.AlternativeGLAccount = _AlternativeGLAccount.GLAccount 

association[0..1] to I_SalesOrder                   as _SalesOrder                   on $projection.SalesOrder                      = _SalesOrder.SalesOrder
association[0..1] to I_SalesOrderItem               as _SalesOrderItem               on $projection.SalesOrder                      = _SalesOrderItem.SalesOrder and  
                                                                                        $projection.SalesOrderItem                  = _SalesOrderItem.SalesOrderItem
association[0..1] to I_SalesDocument                as _SalesDocument                on $projection.SalesDocument                   = _SalesDocument.SalesDocument
association[0..1] to I_SalesDocumentItem            as _SalesDocumentItem            on $projection.SalesDocument                   = _SalesDocumentItem.SalesDocument and  
                                                                                        $projection.SalesDocumentItem               = _SalesDocumentItem.SalesDocumentItem                                                                                        
association[0..1] to I_InternalOrder                as _InternalOrder                on $projection.OrderID                         = _InternalOrder.InternalOrder
association[0..1] to I_Order                        as _Order                        on $projection.OrderID                         = _Order.OrderID
//association[0..*] to I_CostAnalysisResource         as _CostAnalysisResource         on $projection.ControllingArea                 = _CostAnalysisResource.ControllingArea and  
//                                                                                        $projection.CostAnalysisResource            = _CostAnalysisResource.CostAnalysisResource 
                                                                                
association[0..1] to I_Employment                   as _Employment                   on $projection.PersonnelNumber                 = _Employment.EmploymentInternalID and
                                                                                        $projection.PostingDate                    <= _Employment.EndDate
association [0..1] to I_PersonWorkAgreement_1        as _PersonWorkAgreement_1         on  $projection.PersonnelNumber    = _PersonWorkAgreement_1.PersonWorkAgreement   

association[0..1] to I_FinancialTransactionType     as _FinancialTransactionType      on $projection.FinancialTransactionType       = _FinancialTransactionType.FinancialTransactionType
association[0..1] to I_BusinessTransactionType      as _BusinessTransactionType       on $projection.BusinessTransactionType        = _BusinessTransactionType.BusinessTransactionType

association[0..1] to I_ReferenceDocumentType        as _ReferenceDocumentType         on $projection.ReferenceDocumentType          = _ReferenceDocumentType.ReferenceDocumentType
association[0..1] to I_ReferenceDocumentType        as _PredecessorReferenceDocType   on $projection.PredecessorReferenceDocType    = _PredecessorReferenceDocType.ReferenceDocumentType
association[0..1] to I_AccountingDocumentCategory   as _AccountingDocumentCategory    on $projection.AccountingDocumentCategory     = _AccountingDocumentCategory.AccountingDocumentCategory

association[0..1] to I_User                         as _User                          on $projection.AccountingDocCreatedByUser     = _User.UserID

association[0..1] to I_GLAccountType                as _GLAccountType                 on $projection.GLAccountType                  = _GLAccountType.GLAccountType
association[0..1] to I_FinancialAccountType         as _OffsettingAccountType         on $projection.OffsettingAccountType          = _OffsettingAccountType.FinancialAccountType

association[0..1] to I_GLAccountInChartOfAccounts   as _SenderGLAccount               on $projection.ChartOfAccounts                = _SenderGLAccount.ChartOfAccounts and 
                                                                                         $projection.SenderGLAccount                = _SenderGLAccount.GLAccount 
// old association kept for compatibility. DO NOT USE                                                                                         
association [0..1] to I_GLAccountInChartOfAccounts  as _OffsettingAccount             on  $projection.ChartOfAccounts               = _OffsettingAccount.ChartOfAccounts
                                                                                      and $projection.OffsettingAccount             = _OffsettingAccount.GLAccount

association [0..1] to I_OffsettingAccount           as _OffsettingAccountWithBP       on  $projection.OffsettingChartOfAccounts     = _OffsettingAccountWithBP.ChartOfAccounts
                                                                                      and $projection.OffsettingAccountType         = _OffsettingAccountWithBP.OffsettingAccountType
                                                                                      and $projection.OffsettingAccount             = _OffsettingAccountWithBP.OffsettingAccount                                                                                                                                                                          
association[0..1] to I_ChartOfAccounts              as _OffsettingChartOfAccounts     on $projection.OffsettingChartOfAccounts      = _OffsettingChartOfAccounts.ChartOfAccounts                                                                                     
association[0..1] to I_ChartOfAccounts              as _CountryChartOfAccounts        on $projection.CountryChartOfAccounts         = _CountryChartOfAccounts.ChartOfAccounts

association[0..1] to I_PurchasingDocument           as _PurchasingDocument            on $projection.PurchasingDocument             = _PurchasingDocument.PurchasingDocument 
association[0..1] to I_PurchasingDocumentItem       as _PurchasingDocumentItem        on $projection.PurchasingDocument             = _PurchasingDocumentItem.PurchasingDocument and  
                                                                                         $projection.PurchasingDocumentItem         = _PurchasingDocumentItem.PurchasingDocumentItem
association[0..1] to I_SpecialGLCode                as _SpecialGLCode                 on $projection.SpecialGLCode                  = _SpecialGLCode.SpecialGLCode and
                                                                                         $projection.FinancialAccountType           = _SpecialGLCode.FinancialAccountType
association[0..*] to I_TaxCode                      as _TaxCode                       on $projection.TaxCode                        = _TaxCode.TaxCode

association[0..1] to I_Housebank                    as _HouseBank                     on $projection.CompanyCode                    = _HouseBank.CompanyCode and
                                                                                         $projection.HouseBank                      = _HouseBank.HouseBank

association[1..1] to I_AccountingDocument           as _ClearingAccountingDocument    on $projection.CompanyCode                    = _ClearingAccountingDocument.CompanyCode and 
                                                                                         $projection.FiscalYear                     = _ClearingAccountingDocument.FiscalYear and 
                                                                                         $projection.ClearingAccountingDocument     = _ClearingAccountingDocument.AccountingDocument 
association [0..1] to I_JournalEntry                as _ClearingJournalEntry          on $projection.CompanyCode                    = _ClearingJournalEntry.CompanyCode
                                                                                         and $projection.ClearingJournalEntryFiscalYear = _ClearingJournalEntry.FiscalYear
                                                                                         and $projection.ClearingJournalEntry           = _ClearingJournalEntry.AccountingDocument
association [0..1] to I_FiscalYearForCompanyCode    as _ClearingJrnlEntryFiscalYear   on $projection.ClearingJournalEntryFiscalYear = _ClearingJrnlEntryFiscalYear.FiscalYear
                                                                                         and $projection.CompanyCode                    = _ClearingJrnlEntryFiscalYear.CompanyCode

association [0..1] to I_MasterFixedAsset            as _MasterFixedAsset              on $projection.CompanyCode                    = _MasterFixedAsset.CompanyCode and
                                                                                         $projection.MasterFixedAsset               = _MasterFixedAsset.MasterFixedAsset
association[0..1] to I_FixedAsset                   as _FixedAsset                    on $projection.CompanyCode                    = _FixedAsset.CompanyCode and
                                                                                         $projection.MasterFixedAsset               = _FixedAsset.MasterFixedAsset and
                                                                                         $projection.FixedAsset                     = _FixedAsset.FixedAsset
association [0..1] to I_MasterFixedAsset            as _GroupMasterFixedAsset         on $projection.CompanyCode                    = _GroupMasterFixedAsset.CompanyCode and
                                                                                         $projection.GroupMasterFixedAsset          = _GroupMasterFixedAsset.MasterFixedAsset
association[0..1] to I_FixedAsset                   as _GroupFixedAsset               on $projection.CompanyCode                    = _GroupFixedAsset.CompanyCode and
                                                                                         $projection.GroupMasterFixedAsset          = _GroupFixedAsset.MasterFixedAsset and
                                                                                         $projection.GroupFixedAsset                = _GroupFixedAsset.FixedAsset
association[0..1] to I_BusinessProcess              as _BusinessProcess               on $projection.ControllingArea                = _BusinessProcess.ControllingArea and                                                                                        
                                                                                         $projection.BusinessProcess                = _BusinessProcess.BusinessProcess
//association[0..1] to I_ControllingObject            as _CostObject                    on $projection.CostObject                     = _CostObject.ControllingObject
association[0..*] to I_CostCenterActivityType       as _PartnerCostCtrActivityType    on $projection.ControllingArea                = _PartnerCostCtrActivityType.ControllingArea and     
                                                                                         $projection.PartnerCostCtrActivityType     = _PartnerCostCtrActivityType.CostCtrActivityType
association[0..1] to I_InternalOrder                as _PartnerOrder                  on $projection.PartnerOrder                   = _PartnerOrder.InternalOrder
association [0..1] to I_Order                       as _PartnerOrder_2                on  $projection.PartnerOrder                  = _PartnerOrder_2.OrderID       
association[0..1] to I_OrderCategory                as _PartnerOrderCategory          on $projection.PartnerOrderCategory           = _PartnerOrderCategory.OrderCategory
association [0..1] to I_WBSElementBasicData         as _WBSElementBasicData           on  $projection.WBSElementInternalID          = _WBSElementBasicData.WBSElementInternalID  
association [0..1] to I_WBSElementByExternalID      as _WBSElementExternalID          on  $projection.WBSElementExternalID          = _WBSElementExternalID.WBSElementExternalID
association[0..1] to I_WBSElementByInternalKey      as _WBSElementInternalID          on $projection.WBSElementInternalID           = _WBSElementInternalID.WBSElementInternalID
association[0..1] to I_WBSElement                   as _WBSElement                    on $projection.WBSElement                     = _WBSElement.WBSElement
association[0..1] to I_WBSElement                   as _PartnerWBSElement             on $projection.PartnerWBSElement              = _PartnerWBSElement.WBSElement
association[0..1] to I_Project                      as _PartnerProject                on $projection.PartnerProject                 = _PartnerProject.Project
association[0..1] to I_SalesDocument                as _PartnerSalesDocument          on $projection.PartnerSalesDocument           = _PartnerSalesDocument.SalesDocument
association[0..1] to I_SalesDocumentItem            as _PartnerSalesDocumentItem      on $projection.PartnerSalesDocument           = _PartnerSalesDocumentItem.SalesDocument and  
                                                                                         $projection.PartnerSalesDocumentItem       = _PartnerSalesDocumentItem.SalesDocumentItem
association[0..1] to I_BusinessProcess              as _PartnerBusinessProcess        on $projection.ControllingArea                = _PartnerBusinessProcess.ControllingArea and                                                                                        
                                                                                         $projection.PartnerBusinessProcess         = _PartnerBusinessProcess.BusinessProcess

association[0..1] to I_BillingDocumentType          as _BillingDocumentType           on $projection.BillingDocumentType            = _BillingDocumentType.BillingDocumentType 

association[0..1] to I_SalesOrganization            as _SalesOrganization             on $projection.SalesOrganization              = _SalesOrganization.SalesOrganization 
association[0..1] to I_DistributionChannel          as _DistributionChannel           on $projection.DistributionChannel            = _DistributionChannel.DistributionChannel 

association[0..1] to I_Material                     as _SoldMaterial                  on  $projection.SoldMaterial                  = _SoldMaterial.Material //do not use any longer, use _SoldProduct
association[0..1] to I_Product                      as _SoldProduct                   on  $projection.SoldProduct                   = _SoldProduct.Product

association[0..1] to I_Fund                         as _Fund                          on $projection.FinancialManagementArea        = _Fund.FinancialManagementArea and                                                                                        
                                                                                         $projection.Fund                           = _Fund.Fund
association[0..1] to I_Fund                         as _PartnerFund                   on $projection.FinancialManagementArea        = _PartnerFund.FinancialManagementArea and                                                                                        
                                                                                         $projection.PartnerFund                    = _PartnerFund.Fund
association[0..*] to I_FundsCenter                  as _FundsCenter                   on $projection.FinancialManagementArea        = _FundsCenter.FinancialManagementArea and                                                                                        
                                                                                         $projection.FundsCenter                    = _FundsCenter.FundsCenter
association[0..1] to I_CompanyCode                  as _PartnerCompanyCode            on $projection.PartnerCompanyCode             = _PartnerCompanyCode.CompanyCode
                                                                                      
association[0..1] to I_InventoryValuationType       as _InventorySpecialStockValnType  on $projection.InventorySpecialStockValnType = _InventorySpecialStockValnType.InventoryValuationType

association[0..1] to I_InventorySpecialStockType    as _InventorySpecialStockType      on $projection.InventorySpecialStockType     =  _InventorySpecialStockType.InventorySpecialStockType
association[0..1] to I_InvtrySpecialStockValnType   as _InventorySpclStockValnType    on  $projection.InvtrySpecialStockValnType_2  = _InventorySpclStockValnType.InventorySpecialStockValnType

association[0..1] to I_SalesDocument                as _InventorySpclStkSalesDocument  on $projection.InventorySpclStkSalesDocument =  _InventorySpclStkSalesDocument.SalesDocument

association[0..1] to I_SalesDocumentItem            as _InventorySpclStkSalesDocItm    on $projection.InventorySpclStkSalesDocument = _InventorySpclStkSalesDocItm.SalesDocument and  
                                                                                          $projection.InventorySpclStkSalesDocItm   = _InventorySpclStkSalesDocItm.SalesDocumentItem

association[0..1] to I_WBSElementByInternalKey      as _InvtrySpclStockWBSElmntIntID   on $projection.InvtrySpclStockWBSElmntIntID  = _InvtrySpclStockWBSElmntIntID.WBSElementInternalID
association[0..1] to I_WBSElement                   as _InventorySpclStockWBSElement   on $projection.InventorySpclStockWBSElement  = _InventorySpclStockWBSElement.WBSElement
association [0..1]  to I_WBSElementBasicData          as _InvtrySpclStkWBSElmntBscData  on  $projection.InvtrySpclStockWBSElmntIntID = _InvtrySpclStkWBSElmntBscData.WBSElementInternalID     
    
association[0..1] to I_InventoryValuationType       as _InventoryValuationType         on $projection.InventoryValuationType        = _InventoryValuationType.InventoryValuationType

//association[0..1] to I_ControllingObject            as _OriginSenderObject             on $projection.OriginSenderObject            =  _OriginSenderObject.ControllingObject 

association[0..1] to I_ControllingObjectClass       as _ControllingObjectClass         on $projection.ControllingObjectClass        =  _ControllingObjectClass.ControllingObjectClass

association[1..1] to I_Partnercompany               as _PartnerCompany                 on $projection.PartnerCompany                = _PartnerCompany.PartnerCompany

association[0..1] to I_ControllingObjectClass       as _PartnerControllingObjectClass  on $projection.PartnerControllingObjectClass =  _PartnerControllingObjectClass.ControllingObjectClass

association[0..*] to I_CostCenter                   as _OriginCostCenter               on $projection.ControllingArea               = _OriginCostCenter.ControllingArea and  
                                                                                          $projection.OriginCostCenter              = _OriginCostCenter.CostCenter
                                                                           
association[0..*] to I_CostCenterActivityType       as _CostCtrActivityType            on $projection.ControllingArea               = _CostCtrActivityType.ControllingArea and     
                                                                                          $projection.CostCtrActivityType           = _CostCtrActivityType.CostCtrActivityType

association[0..*] to I_CostCenterActivityType       as _OriginCostCtrActivityType      on $projection.ControllingArea               = _OriginCostCtrActivityType.ControllingArea and     
                                                                                          $projection.OriginCostCtrActivityType           = _OriginCostCtrActivityType.CostCtrActivityType  
                                                                                       
association[0..1] to I_OrderCategory                as _OrderCategory                  on $projection.OrderCategory                 =  _OrderCategory.OrderCategory

//association[0..1] to I_NetworkActivity             as _RelatedNetworkActivity         on $projection.ProjectNetwork                =  _RelatedNetworkActivity.ProjectNetwork and
//                                                                                          $projection.RelatedNetworkActivity        =  _RelatedNetworkActivity.NetworkActivity 

//association[0..1] to I_NetworkActivity             as _PartnerProjectNetworkActivity  on $projection.PartnerProjectNetwork         =  _PartnerProjectNetworkActivity.ProjectNetwork and
//                                                                                          $projection.PartnerProjectNetworkActivity =  _PartnerProjectNetworkActivity.NetworkActivity 
                                                                                                                                                                                                                                                                  

association[0..1] to I_MovementCategory             as _MovementCategory               on $projection.AssetAcctTransClassfctn       = _MovementCategory.AssetAcctTransClassfctn                                                                                                                                                                                                                                                            
association[0..1] to I_AssetTransactionType         as _AssetTransactionType           on $projection.AssetTransactionType          = _AssetTransactionType.AssetTransactionType                                                                                                                                                                                                                                                            

association[0..1] to I_BudgetPeriod                 as _BudgetPeriod                   on $projection.BudgetPeriod                  = _BudgetPeriod.BudgetPeriod                                                                                                                                                                                                                                                            

//association[0..*] to I_CostOriginGroup              as _CostOriginGroup                on $projection.ControllingArea               = _CostOriginGroup.ControllingArea and                                                                                                                                                                                                                                                            
//// not contained in view                                                                  $projection.CostOriginType                = _CostOriginGroup.CostOriginType and                                                                                                                                                                                                                                                           
//                                                                                          $projection.CostOriginGroup               = _CostOriginGroup.CostOriginGroup                                                                                                                                                                                                                                                            

association[0..1] to I_FinancialManagementArea      as _FinancialManagementArea        on $projection.FinancialManagementArea       = _FinancialManagementArea.FinancialManagementArea                                                                                                                                                                                                                                                            
//association[0..1] to I_FundedProgram                as _FundedProgram                  on $projection.FinancialManagementArea       = _FundedProgram.FinancialManagementArea and 
//                                                                                          $projection.FundedProgram                 = _FundedProgram.FundedProgram                                                                                                                                                                                                                                                           

association[0..1] to I_HouseBankAccount             as _HouseBankAccount               on $projection.CompanyCode                   = _HouseBankAccount.CompanyCode and
                                                                                          $projection.HouseBank                     = _HouseBankAccount.HouseBank and                                                                                                                                                                                                                                                           
                                                                                          $projection.HouseBankAccount              = _HouseBankAccount.HouseBankAccount                                                                                                                                                                                                                                                            

association[0..1] to I_LogicalSystem                as _LogicalSystem                  on $projection.LogicalSystem                 = _LogicalSystem.LogicalSystem                                                                                                                                                                                                                                                            

association[0..1] to I_OperatingConcern             as _OperatingConcern               on $projection.OperatingConcern              = _OperatingConcern.OperatingConcern                                                                                                                                                                                                                                                            

association[0..1] to I_ProjectNetwork               as _ProjectNetwork                 on $projection.ProjectNetwork                =  _ProjectNetwork.ProjectNetwork

association[0..1] to I_Purreqvaluationarea          as _PurReqValuationArea            on $projection.ValuationArea                 =  _PurReqValuationArea.ValuationArea

association[0..1] to I_FiscalYearVariant            as _FiscalYearVariant              on $projection.FiscalYearVariant             = _FiscalYearVariant.FiscalYearVariant

association [0..1] to I_FiscalCalendarDate          as _FiscalCalendarDate             on $projection.FiscalYearVariant = _FiscalCalendarDate.FiscalYearVariant and 
                                                                                          $projection.PostingDate = _FiscalCalendarDate.CalendarDate

association [0..1] to I_ServiceDocumentType         as _ServiceDocumentType           on $projection.ServiceDocumentType            = _ServiceDocumentType.ServiceDocumentType
  
association [0..1] to I_SrvcDocByDocumentType       as _ServiceDocument               on $projection.ServiceDocumentType            = _ServiceDocument.ServiceDocumentType
                                                                                         and $projection.ServiceDocument            = _ServiceDocument.ServiceDocument 
                                                                                                     
association [0..1] to I_SrvcDocItemByDocumentType   as _ServiceDocumentItem           on $projection.ServiceDocumentType            = _ServiceDocumentItem.ServiceDocumentType
                                                                                         and $projection.ServiceDocument            = _ServiceDocumentItem.ServiceDocument
                                                                                         and $projection.ServiceDocumentItem        = _ServiceDocumentItem.ServiceDocumentItem    
                                                                                         
association [0..1] to I_ServiceDocumentType         as _PartnerServiceDocumentType           on $projection.PartnerServiceDocumentType            = _PartnerServiceDocumentType.ServiceDocumentType
  
association [0..1] to I_SrvcDocByDocumentType       as _PartnerServiceDocument               on $projection.PartnerServiceDocumentType            = _PartnerServiceDocument.ServiceDocumentType
                                                                                         and $projection.PartnerServiceDocument            = _PartnerServiceDocument.ServiceDocument 
                                                                                                     
association [0..1] to I_SrvcDocItemByDocumentType   as _PartnerServiceDocumentItem           on $projection.PartnerServiceDocumentType            = _PartnerServiceDocumentItem.ServiceDocumentType
                                                                                         and $projection.PartnerServiceDocument            = _PartnerServiceDocumentItem.ServiceDocument
                                                                                         and $projection.PartnerServiceDocumentItem        = _PartnerServiceDocumentItem.ServiceDocumentItem      
  association [0..1] to I_ServiceDocumentType          as _ServiceContractType           on  $projection.ServiceContractType        = _ServiceContractType.ServiceDocumentType
  
  association [0..1] to I_SrvcDocByDocumentType        as _ServiceContract               on  $projection.ServiceContractType        = _ServiceContract.ServiceDocumentType
                                                                                         and $projection.ServiceContract            = _ServiceContract.ServiceDocument 
                                                                                                     
  association [0..1] to I_SrvcDocItemByDocumentType    as _ServiceContractItem           on  $projection.ServiceContractType        = _ServiceContractItem.ServiceDocumentType
                                                                                         and $projection.ServiceContract            = _ServiceContractItem.ServiceDocument
                                                                                         and $projection.ServiceContractItem        = _ServiceContractItem.ServiceDocumentItem  
 
association [0..1] to I_ProjectByExternalID         as _ProjectExternalID             on  $projection.ProjectExternalID = _ProjectExternalID.ProjectExternalID

association [0..1] to I_GLAccountFlowType           as _GLAccountFlowType             on  $projection.GLAccountFlowType = _GLAccountFlowType.GLAccountFlowType
association [0..1] to I_LedgerCompanyCodeCrcyRoles  as _LedgerCompanyCodeCrcyRoles    on  $projection.CompanyCode = _LedgerCompanyCodeCrcyRoles.CompanyCode
                                                                                      and $projection.Ledger      = _LedgerCompanyCodeCrcyRoles.Ledger
association [0..1] to I_Grant                        as _Grant                         on  $projection.GrantID                 = _Grant.GrantID
association [0..1] to I_Grant                        as _PartnerGrant                  on  $projection.PartnerGrant            = _PartnerGrant.GrantID

{
@ObjectModel.foreignKey.association: '_Ledger'      
key cast( P_GLAcctBalance.rldnr as fis_rldnr preserving type) as Ledger,
@ObjectModel.foreignKey.association: '_CompanyCode' 
key cast( P_GLAcctBalance.rbukrs as fis_bukrs preserving type) as CompanyCode,

key cast( P_GLAcctBalance.fiscyearper as jahrper preserving type) as fiscyearper,
     
@ObjectModel.foreignKey.association: '_FiscalYear'
key cast( P_GLAcctBalance.gjahr as fis_gjahr preserving type) as FiscalYear,
@ObjectModel.foreignKey.association: '_SourceLedger'      
key cast( P_GLAcctBalance.rldnr_pers as fins_ledger_pers preserving type) as SourceLedger,
@ObjectModel.foreignKey.association: '_JournalEntry'
key belnr as AccountingDocument,
key docln as LedgerGLLineItem,
@ObjectModel.foreignKey.association: '_GLAccountFlowType'
key GLAccountFlowType,
key P_GLAcctBalance.FiscalPeriodDate,

cast( P_GLAcctBalance.gjahr as abap.int2) as FiscalYearInt,

P_GLAcctBalance.ryear as LedgerFiscalYear,
//P_GLAcctBalance.rrcty as GLRecordType,

///////////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_00  Unified Journal Entry: Transaction, Currencies, Units
///////////////////////////////////////////////////////////////////////////////
@ObjectModel.foreignKey.association: '_FinancialTransactionType'
P_GLAcctBalance.rmvct as FinancialTransactionType,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_BusinessTransactionType'
P_GLAcctBalance.bttype as BusinessTransactionType,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_ReferenceDocumentType'
cast( P_GLAcctBalance.awtyp as fis_awtyp ) as ReferenceDocumentType,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_LogicalSystem'
P_GLAcctBalance.awsys as LogicalSystem,
P_GLAcctBalance.aworg as ReferenceDocumentContext,
P_GLAcctBalance.awref as ReferenceDocument,
P_GLAcctBalance.awitem as ReferenceDocumentItem,
P_GLAcctBalance.awitgrp as ReferenceDocumentItemGroup,
//P_GLAcctBalance.SUBTA,
//@Semantics.booleanIndicator 
P_GLAcctBalance.xreversing as IsReversal,
//@Semantics.booleanIndicator 
P_GLAcctBalance.xreversed as IsReversed,
//P_GLAcctBalance.XTRUEREV,
//P_GLAcctBalance.AWTYP_REV,
P_GLAcctBalance.aworg_rev as ReversalReferenceDocumentCntxt,
P_GLAcctBalance.awref_rev as ReversalReferenceDocument,
//P_GLAcctBalance.SUBTA_REV,
//@Semantics.booleanIndicator 
P_GLAcctBalance.xsettling as IsSettlement,
//@Semantics.booleanIndicator 
P_GLAcctBalance.xsettled as IsSettled,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PredecessorReferenceDocType'
P_GLAcctBalance.prec_awtyp as PredecessorReferenceDocType,
P_GLAcctBalance.prec_aworg as PredecessorReferenceDocCntxt,
P_GLAcctBalance.prec_awref as PredecessorReferenceDocument,
P_GLAcctBalance.prec_awitem as PredecessorReferenceDocItem,
//P_GLAcctBalance.PREC_SUBTA,

@ObjectModel.foreignKey.association: '_GLAccountInChartOfAccounts'      
P_GLAcctBalance.racct as GLAccount,
@ObjectModel.foreignKey.association: '_GLAccountHierarchy'      
P_GLAcctBalance.racct as GLAccountHierarchy,

////////////////////////////////////////////////////////////////////////////////////
// .INCLUDE  ACDOC_SI_GL_ACCAS Unified Journal Entry: G/L additional account assignments
////////////////////////////////////////////////////////////////////////////////////
@ObjectModel.foreignKey.association: '_ProfitCenter'      
P_GLAcctBalance.prctr as ProfitCenter,
@ObjectModel.foreignKey.association: '_FunctionalArea'      
P_GLAcctBalance.rfarea as FunctionalArea,
@ObjectModel.foreignKey.association: '_BusinessArea'      
P_GLAcctBalance.rbusa as BusinessArea,
@ObjectModel.foreignKey.association: '_ControllingArea'      
P_GLAcctBalance.kokrs as ControllingArea,
@ObjectModel.foreignKey.association: '_Segment'      
P_GLAcctBalance.segment as Segment,
@ObjectModel.foreignKey.association: '_PartnerCostCenter'      
P_GLAcctBalance.scntr as PartnerCostCenter,
@ObjectModel.foreignKey.association: '_PartnerProfitCenter'      
P_GLAcctBalance.pprctr as PartnerProfitCenter,
@ObjectModel.foreignKey.association: '_PartnerFunctionalArea'      
P_GLAcctBalance.sfarea as PartnerFunctionalArea,
@ObjectModel.foreignKey.association: '_PartnerBusinessArea'      
P_GLAcctBalance.sbusa as PartnerBusinessArea,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerCompany'
P_GLAcctBalance.rassc as PartnerCompany,
@ObjectModel.foreignKey.association: '_PartnerSegment'      
P_GLAcctBalance.psegment as PartnerSegment,

/////////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_FIX  Unified Journal Entry: Mandatory fields for G/L
////////////////////////////////////////////////////////////////////////////
@ObjectModel.foreignKey.association: '_DebitCreditCode'      
P_GLAcctBalance.drcrk as DebitCreditCode,
@ObjectModel.foreignKey.association: '_FiscalYearVariant'  
P_GLAcctBalance.periv as FiscalYearVariant,
@ObjectModel.foreignKey.association: '_FiscalCalendarDate'     
P_GLAcctBalance.budat as PostingDate,
//P_GLAcctBalance.bldat,
@ObjectModel.foreignKey.association: '_AccountingDocumentType'      
P_GLAcctBalance.blart as AccountingDocumentType,
P_GLAcctBalance.buzei as AccountingDocumentItem,
P_GLAcctBalance.zuonr as AssignmentReference,
@ObjectModel.foreignKey.association: '_PostingKey'      
P_GLAcctBalance.bschl as PostingKey,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_AccountingDocumentCategory'
P_GLAcctBalance.bstat as AccountingDocumentCategory,
P_GLAcctBalance.ktosl as TransactionTypeDetermination,
P_GLAcctBalance.slalittype as SubLedgerAcctLineItemType,
P_GLAcctBalance.usnam as AccountingDocCreatedByUser,
//P_GLAcctBalance.timestamp,
@ObjectModel.foreignKey.association: '_EliminationProfitCenter'      
P_GLAcctBalance.eprctr as EliminationProfitCenter,
P_GLAcctBalance.rhoart as OriginObjectType,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_GLAccountType'
P_GLAcctBalance.glaccount_type as GLAccountType,
@ObjectModel.foreignKey.association: '_ChartOfAccounts'      
P_GLAcctBalance.ktopl as ChartOfAccounts,
@ObjectModel.foreignKey.association: '_AlternativeGLAccount'
P_GLAcctBalance.lokkt as AlternativeGLAccount,
@ObjectModel.foreignKey.association: '_CountryChartOfAccounts'
P_GLAcctBalance.ktop2 as CountryChartOfAccounts,
P_GLAcctBalance.CreationDateTime,

///////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_GEN  Unified Journal Entry: Fields for several subledgers
//////////////////////////////////////////////////////////////////////////
P_GLAcctBalance.rebzg as InvoiceReference,
P_GLAcctBalance.rebzj as InvoiceReferenceFiscalYear,
P_GLAcctBalance.rebzz as FollowOnDocumentType,
P_GLAcctBalance.rebzt as InvoiceItemReference,
P_GLAcctBalance.rbest as ReferencePurchaseOrderCategory,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PurchasingDocument'
P_GLAcctBalance.ebeln as PurchasingDocument,
P_GLAcctBalance.ebelp as PurchasingDocumentItem,
P_GLAcctBalance.zekkn as AccountAssignmentNumber,
@Semantics.text: true
P_GLAcctBalance.sgtxt as DocumentItemText,

@ObjectModel.foreignKey.association: '_Plant'      
P_GLAcctBalance.werks as Plant,
@ObjectModel.foreignKey.association: '_Supplier'      
P_GLAcctBalance.lifnr as Supplier,
@ObjectModel.foreignKey.association: '_Customer'      
P_GLAcctBalance.kunnr as Customer,

@API.element.releaseState: #DEPRECATED
@API.element.successor:   'Product'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'Product'
@ObjectModel.foreignKey.association: '_Material'      
cast( P_GLAcctBalance.matnr as fis_productnumber_depr preserving type ) as Material,

@ObjectModel.foreignKey.association: '_Product'
//cast (P_GLAcctBalance.matnr as productnumber) as Product,  already done in I_GLAccountLineItem(RawData)
P_GLAcctBalance.matnr as Product,
@API.element.releaseState: #DEPRECATED
@API.element.successor:   'SoldProduct'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'SoldProduct'
cast( P_GLAcctBalance.matnr_copa as fis_matnr_pa_depr preserving type ) as SoldMaterial,

@ObjectModel.foreignKey.association: '_SoldProduct'
cast (matnr_copa as fins_matnr_pa preserving type) as SoldProduct, 

@API.element.releaseState: #DEPRECATED
@API.element.successor:   'SoldProductGroup'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'SoldProductGroup'
@ObjectModel.foreignKey.association: '_MaterialGroup'      
cast( P_GLAcctBalance.matkl as fis_matkl_pa_depr preserving type ) as MaterialGroup,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_SoldProductGroup'   
P_GLAcctBalance.matkl as SoldProductGroup,
@Analytics.internalName: #LOCAL 
//@API.element.releaseState: #DEPRECATED
//@API.element.successor:   'SoldProductGroup'
//@VDM.lifecycle.status:    #DEPRECATED
//@VDM.lifecycle.successor: 'SoldProductGroup'
@ObjectModel.foreignKey.association: '_ProductGroup'
cast (matkl_mm as productgroup preserving type) as ProductGroup, 
//cast (matkl as productgroup preserving type) as ProductGroup, 

/////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_FI  Unified Journal Entry: Fields for FI subledgers
/////////////////////////////////////////////////////////////////////////
@ObjectModel.foreignKey.association: '_FinancialAccountType'      
P_GLAcctBalance.koart as FinancialAccountType,
@ObjectModel.foreignKey.association: '_SpecialGLCode'
P_GLAcctBalance.umskz as SpecialGLCode,
P_GLAcctBalance.mwskz as TaxCode,
@ObjectModel.foreignKey.association: '_HouseBank'
P_GLAcctBalance.hbkid as HouseBank, 
@ObjectModel.foreignKey.association: '_HouseBankAccount'
P_GLAcctBalance.hktid as HouseBankAccount,
//@Semantics.booleanIndicator 
P_GLAcctBalance.xopvw as IsOpenItemManaged,
//P_GLAcctBalance.augdt,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    'ClearingJournalEntry'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'ClearingJournalEntry' 
@ObjectModel.foreignKey.association: '_ClearingAccountingDocument'
cast( P_GLAcctBalance.augbl as fis_augbl_depre preserving type ) as ClearingAccountingDocument,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    'ClearingJournalEntryFiscalYear'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'ClearingJournalEntryFiscalYear'   
cast( P_GLAcctBalance.auggj as fis_auggj_no_conv_depre preserving type ) as ClearingDocFiscalYear,

cast( P_GLAcctBalance.augbl as fis_augbl preserving type ) as ClearingJournalEntry,
cast( P_GLAcctBalance.auggj as fis_auggj_no_conv preserving type ) as ClearingJournalEntryFiscalYear,

//P_GLAcctBalance.xaugp as IsCleared,


/////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_FAA  Unified Journal Entry: Fields for Asset Accounting
/////////////////////////////////////////////////////////////////////////
P_GLAcctBalance.afabe as AssetDepreciationArea,
@ObjectModel.foreignKey.association: '_MasterFixedAsset'
P_GLAcctBalance.anln1 as MasterFixedAsset,
@ObjectModel.foreignKey.association: '_FixedAsset'
P_GLAcctBalance.anln2 as FixedAsset,
P_GLAcctBalance.bzdat as AssetValueDate,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_AssetTransactionType'
P_GLAcctBalance.anbwa as AssetTransactionType,
P_GLAcctBalance.movcat as AssetAcctTransClassfctn,
P_GLAcctBalance.depr_period as DepreciationFiscalPeriod,
@ObjectModel.foreignKey.association: '_GroupMasterFixedAsset'
P_GLAcctBalance.anlgr as GroupMasterFixedAsset,
@ObjectModel.foreignKey.association: '_GroupFixedAsset'
P_GLAcctBalance.anlgr2 as GroupFixedAsset,
//P_GLAcctBalance.settlement_rule,

//////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_ML Unified Journal Entry: Fields for Material Ledger
//////////////////////////////////////////////////////////////////////////
P_GLAcctBalance.kalnr as CostEstimate,
@API.element.releaseState: #DEPRECATED
@API.element.successor:   'InvtrySpecialStockValnType_2'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'InvtrySpecialStockValnType_2'          
@ObjectModel.foreignKey.association: '_InventorySpecialStockValnType'
P_GLAcctBalance.kzbws as InventorySpecialStockValnType,
@ObjectModel.foreignKey.association: '_InventorySpclStockValnType'      
@Analytics.internalName: #LOCAL
cast(P_GLAcctBalance.kzbws as fis_inventoryspclstockvalntype preserving type) as InvtrySpecialStockValnType_2,

//P_GLAcctBalance.xobew,
@ObjectModel.foreignKey.association: '_InventorySpecialStockType'
P_GLAcctBalance.sobkz as InventorySpecialStockType,
@ObjectModel.foreignKey.association: '_InventorySpclStkSalesDocument'
P_GLAcctBalance.mat_kdauf as InventorySpclStkSalesDocument,
@ObjectModel.foreignKey.association: '_InventorySpclStkSalesDocItm'
P_GLAcctBalance.mat_kdpos as InventorySpclStkSalesDocItm,
@ObjectModel.foreignKey.association: '_InvtrySpclStockWBSElmntIntID'
P_GLAcctBalance.mat_pspnr as InvtrySpclStockWBSElmntIntID,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_InvtrySpclStockWBSElmntExtID'
cast( P_GLAcctBalance.InvtrySpclStockWBSElmntExtID as fis_invspstock_wbsext_no_conv preserving type ) as InvtrySpclStockWBSElmntExtID,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    'InvtrySpclStockWBSElmntExtID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'InvtrySpclStockWBSElmntExtID'
@ObjectModel.foreignKey.association: '_InventorySpclStockWBSElement'
P_GLAcctBalance.mat_ps_posid as InventorySpclStockWBSElement,
@ObjectModel.foreignKey.association: '_InventorySpecialStockSupplier'
P_GLAcctBalance.mat_lifnr as InventorySpecialStockSupplier,
@ObjectModel.foreignKey.association: '_InventoryValuationType'
P_GLAcctBalance.bwtar as InventoryValuationType,
@ObjectModel.foreignKey.association: '_Purreqvaluationarea'
P_GLAcctBalance.bwkey as ValuationArea,

////////////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_CFIN   Unified Journal Entry: Fields for Central Finance
//////////////////////////////////////////////////////////////////////////////
P_GLAcctBalance.SenderCompanyCode,
P_GLAcctBalance.racct_sender as SenderGLAccount,
P_GLAcctBalance.accas_sender as SenderAccountAssignment,
P_GLAcctBalance.accasty_sender as SenderAccountAssignmentType,

////////////////////////////////////////////////////////////////////////////
//  .INCLUDE  ACDOC_SI_CO  Unified Journal Entry: CO fields
///////////////////////////////////////////////////////////////////////////
//P_GLAcctBalance.hkgrp as UtilsProfileConstcyChkGrp,
//P_GLAcctBalance.co_belkz as ControllingDebitCreditCode,
P_GLAcctBalance.beltp as ControllingObjectDebitType,
P_GLAcctBalance.muvflg as QuantityIsIncomplete,
@ObjectModel.foreignKey.association: '_OffsettingAccountWithBP'
P_GLAcctBalance.gkont as OffsettingAccount,
@ObjectModel.foreignKey.association: '_OffsettingAccountType'
P_GLAcctBalance.gkoar as OffsettingAccountType,
@ObjectModel.foreignKey.association: '_OffsettingChartOfAccounts'
P_GLAcctBalance.OffsettingChartOfAccounts,
P_GLAcctBalance.erlkz as LineItemIsCompleted,
P_GLAcctBalance.pernr as PersonnelNumber,
@ObjectModel.foreignKey.association: '_ControllingObjectClass'
P_GLAcctBalance.scope as ControllingObjectClass,
@ObjectModel.foreignKey.association: '_PartnerCompanyCode'
P_GLAcctBalance.pbukrs as PartnerCompanyCode,
@ObjectModel.foreignKey.association: '_PartnerControllingObjectClass'
P_GLAcctBalance.pscope as PartnerControllingObjectClass,
//P_GLAcctBalance.aufnr_org,
@ObjectModel.foreignKey.association: '_OriginCostCenter'
P_GLAcctBalance.ukostl as OriginCostCenter,
@ObjectModel.foreignKey.association: '_OriginCostCtrActivityType'
P_GLAcctBalance.ulstar as OriginCostCtrActivityType,
P_GLAcctBalance.OriginProduct,
P_GLAcctBalance.VarianceOriginGLAccount,
P_GLAcctBalance.accas as AccountAssignment,
P_GLAcctBalance.accasty as AccountAssignmentType,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_ProjectNetwork'
P_GLAcctBalance.nplnr as ProjectNetwork,
P_GLAcctBalance.nplnr_vorgn as RelatedNetworkActivity,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_BusinessProcess'
P_GLAcctBalance.prznr as BusinessProcess,
P_GLAcctBalance.kstrg as CostObject,
//P_GLAcctBalance.bemot,
P_GLAcctBalance.qmnum as CustomerServiceNotification,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_ServiceDocumentType'
P_GLAcctBalance.ServiceDocumentType,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_ServiceDocument'
P_GLAcctBalance.ServiceDocument,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_ServiceDocumentItem'
P_GLAcctBalance.ServiceDocumentItem,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PartnerServiceDocumentType'
P_GLAcctBalance.PartnerServiceDocumentType,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PartnerServiceDocument'
P_GLAcctBalance.PartnerServiceDocument,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PartnerServiceDocumentItem'
P_GLAcctBalance.PartnerServiceDocumentItem,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_ServiceContractType'
ServiceContractType,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_ServiceContract'
ServiceContract,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_ServiceContractItem'
ServiceContractItem,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_TimeSheetOvertimeCat'
TimeSheetOvertimeCategory,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_OperatingConcern'
P_GLAcctBalance.erkrs as OperatingConcern,
P_GLAcctBalance.paccas as PartnerAccountAssignment,
P_GLAcctBalance.paccasty as PartnerAccountAssignmentType,
P_GLAcctBalance.plstar as PartnerCostCtrActivityType,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerOrder_2'
P_GLAcctBalance.PartnerOrder_2  as PartnerOrder,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerOrderCategory'
P_GLAcctBalance.pautyp as PartnerOrderCategory,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerWBSElement'
@API.element.releaseState: #DEPRECATED
@API.element.successor:    'PartnerWBSElementExternalID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'PartnerWBSElementExternalID'
P_GLAcctBalance.pps_posid as PartnerWBSElement,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerProject'
@API.element.releaseState: #DEPRECATED
@API.element.successor:    'PartnerProjectExternalID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'PartnerProjectExternalID'
P_GLAcctBalance.pps_pspid as PartnerProject,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerSalesDocument'
P_GLAcctBalance.pkdauf as PartnerSalesDocument,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerSalesDocumentItem'
P_GLAcctBalance.pkdpos as PartnerSalesDocumentItem,
P_GLAcctBalance.pnplnr as PartnerProjectNetwork,
P_GLAcctBalance.pnplnr_vorgn as PartnerProjectNetworkActivity,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerBusinessProcess'
P_GLAcctBalance.pprznr as PartnerBusinessProcess,
P_GLAcctBalance.pkstrg as PartnerCostObject,


//////////////////////////////////////////////////////////////////////
//  .INCLUDE  ACDOC_SI_COPA  Unified Journal Entry: CO-PA fields
//////////////////////////////////////////////////////////////////////
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_BillingDocumentType'
P_GLAcctBalance.fkart as BillingDocumentType,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_SalesOrganization'
P_GLAcctBalance.vkorg as SalesOrganization,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_DistributionChannel'
P_GLAcctBalance.vtweg as DistributionChannel,
P_GLAcctBalance.spart as OrganizationDivision,

@ObjectModel.foreignKey.association: '_CustomerGroup'      
P_GLAcctBalance.kdgrp as CustomerGroup,

//////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_PS  Unified Journal Entry: Fields for Public Sector
/////////////////////////////////////////////////////////////////////
//P_GLAcctBalance.re_bukrs,
//P_GLAcctBalance.re_account,

///////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_JVA  Unified Journal Entry: Fields for Joint Venture Accounting
///////////////////////////////////////////////////////////////////////
P_GLAcctBalance.vname as JointVenture,
P_GLAcctBalance.egrup as JointVentureEquityGroup,
P_GLAcctBalance.recid as JointVentureCostRecoveryCode,
//P_GLAcctBalance.vptnr,
//P_GLAcctBalance.btype,
P_GLAcctBalance.etype as JointVentureEquityType,
//P_GLAcctBalance.prodper,

///////////////////////////////////////////////////////////////////////
// .INCLUDE ACDOC_SI_RE STRU  0 0 Unified Journal Entry: Fields for Real Estate
///////////////////////////////////////////////////////////////////////
//P_GLAcctBalance.swenr,
//P_GLAcctBalance.sgenr,
//P_GLAcctBalance.sgrnr,
//P_GLAcctBalance.smenr,
//P_GLAcctBalance.recnnr,
//P_GLAcctBalance.snksl,
//P_GLAcctBalance.sempsl,
P_GLAcctBalance.dabrz as SettlementReferenceDate,
//P_GLAcctBalance.pswenr,
//P_GLAcctBalance.psgenr,
//P_GLAcctBalance.psgrnr,
//P_GLAcctBalance.psmenr,
//P_GLAcctBalance.precnnr,
//P_GLAcctBalance.psnksl,
//P_GLAcctBalance.psempsl,
//P_GLAcctBalance.pdabrz,

@ObjectModel.foreignKey.association: '_CostCenter'      
P_GLAcctBalance.rcntr as CostCenter,
P_GLAcctBalance.lstar as CostCtrActivityType,
//cast(P_GLAcctBalance.aufnr as fis_internalorder) as InternalOrder,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_Order'
P_GLAcctBalance.aufnr as OrderID,
@ObjectModel.foreignKey.association: '_OrderCategory'
P_GLAcctBalance.autyp as OrderCategory,
@ObjectModel.foreignKey.association: '_WBSElementInternalID'
P_GLAcctBalance.ps_psp_pnr as WBSElementInternalID,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_WBSElementExternalID'
P_GLAcctBalance.posid_edit as WBSElementExternalID,
@ObjectModel.foreignKey.association: '_WBSElement'      
@API.element.releaseState: #DEPRECATED
@API.element.successor:    'WBSElementExternalID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'WBSElementExternalID'
P_GLAcctBalance.ps_posid as WBSElement,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerWBSElementBasicData'
P_GLAcctBalance.PartnerWBSElementInternalID,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerWBSElementExternalID'
P_GLAcctBalance.PartnerWBSElementExternalID,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    'ProjectExternalID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: 'ProjectExternalID'
P_GLAcctBalance.ps_pspid as Project,
P_GLAcctBalance.ps_prj_pnr as ProjectInternalID,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_ProjectExternalID'
P_GLAcctBalance.pspid_edit as ProjectExternalID,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerProjectBasicData'
P_GLAcctBalance.PartnerProjectInternalID,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerProjectExternalID'
P_GLAcctBalance.PartnerProjectExternalID,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_SalesOrder'
P_GLAcctBalance.kdauf as SalesOrder,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_SalesOrderItem'
P_GLAcctBalance.kdpos as SalesOrderItem,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_SalesDocument'
cast(P_GLAcctBalance.kdauf as vbeln_va) as SalesDocument,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_SalesDocumentItem'
cast(P_GLAcctBalance.kdpos as posnr_va) as SalesDocumentItem,

P_GLAcctBalance.augdt as ClearingDate,
@ObjectModel.foreignKey.association: '_ConsolidationUnit'      
P_GLAcctBalance.ConsolidationUnit,
@ObjectModel.foreignKey.association: '_PartnerConsolidationUnit'  
P_GLAcctBalance.PartnerConsolidationUnit,
@ObjectModel.foreignKey.association: '_Company'  
P_GLAcctBalance.Company, 
@ObjectModel.foreignKey.association: '_ConsolidationChartOfAccounts' 
P_GLAcctBalance.ConsolidationChartOfAccounts,
@ObjectModel.foreignKey.association: '_CnsldtnFinancialStatementItem' 
P_GLAcctBalance.CnsldtnFinancialStatementItem,
@ObjectModel.foreignKey.association: '_CnsldtnSubitemCategory' 
P_GLAcctBalance.CnsldtnSubitemCategory,
@ObjectModel.foreignKey.association: '_CnsldtnSubitem' 
P_GLAcctBalance.CnsldtnSubitem,  
P_GLAcctBalance.JrnlEntryItemObsoleteReason,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_BalanceTransactionCurrency'      
P_GLAcctBalance.rtcur  as BalanceTransactionCurrency,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'BalanceTransactionCurrency'} } P_GLAcctBalance.tsl  as AmountInBalanceTransacCrcy,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_TransactionCurrency'      
P_GLAcctBalance.rwcur as TransactionCurrency,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'TransactionCurrency'} } P_GLAcctBalance.wsl as AmountInTransactionCurrency,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_CompanyCodeCurrency'      
P_GLAcctBalance.rhcur as CompanyCodeCurrency,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} } P_GLAcctBalance.hsl as AmountInCompanyCodeCurrency,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_GlobalCurrency'      
P_GLAcctBalance.rkcur as GlobalCurrency,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'GlobalCurrency'} } P_GLAcctBalance.ksl as AmountInGlobalCurrency,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FunctionalCurrency'      
P_GLAcctBalance.FunctionalCurrency as FunctionalCurrency,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FunctionalCurrency'} } P_GLAcctBalance.AmountInFunctionalCurrency as AmountInFunctionalCurrency,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency1'      
P_GLAcctBalance.rocur as FreeDefinedCurrency1,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency1'} } P_GLAcctBalance.osl as AmountInFreeDefinedCurrency1,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency2'      
P_GLAcctBalance.rvcur as FreeDefinedCurrency2,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency2'} } P_GLAcctBalance.vsl as AmountInFreeDefinedCurrency2,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency3'      
P_GLAcctBalance.rbcur as FreeDefinedCurrency3,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency3'} } P_GLAcctBalance.bsl as AmountInFreeDefinedCurrency3,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency4'      
P_GLAcctBalance.rccur as FreeDefinedCurrency4,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency4'} } P_GLAcctBalance.csl as AmountInFreeDefinedCurrency4,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency5'      
P_GLAcctBalance.rdcur as FreeDefinedCurrency5,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency5'} } P_GLAcctBalance.dsl as AmountInFreeDefinedCurrency5,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency6'      
P_GLAcctBalance.recur as FreeDefinedCurrency6,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency6'} } P_GLAcctBalance.esl as AmountInFreeDefinedCurrency6,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency7'      
P_GLAcctBalance.rfcur as FreeDefinedCurrency7,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency7'} } P_GLAcctBalance.fsl as AmountInFreeDefinedCurrency7,

@Semantics.currencyCode:true
@ObjectModel.foreignKey.association: '_FreeDefinedCurrency8'      
P_GLAcctBalance.rgcur as FreeDefinedCurrency8,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency8'} } P_GLAcctBalance.gsl as AmountInFreeDefinedCurrency8,


@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} } 
P_GLAcctBalance.hsl_debit as DebitAmountInCoCodeCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} } 
P_GLAcctBalance.hsl_credit as CreditAmountInCoCodeCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'TransactionCurrency'} } 
P_GLAcctBalance.wsl_debit as DebitAmountInTransCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'TransactionCurrency'} } 
P_GLAcctBalance.wsl_credit as CreditAmountInTransCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'BalanceTransactionCurrency'} } 
P_GLAcctBalance.tsl_debit as DebitAmountInBalanceTransCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'BalanceTransactionCurrency'} } 
P_GLAcctBalance.tsl_credit as CreditAmountInBalanceTransCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'GlobalCurrency'} } 
P_GLAcctBalance.ksl_debit as DebitAmountInGlobalCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'GlobalCurrency'} } 
P_GLAcctBalance.ksl_credit as CreditAmountInGlobalCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FunctionalCurrency'} } 
P_GLAcctBalance.DebitAmountInFunctionalCrcy as DebitAmountInFunctionalCrcy,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FunctionalCurrency'} } 
P_GLAcctBalance.CreditAmountInFunctionalCrcy as CreditAmountInFunctionalCrcy,


@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency1'} } 
P_GLAcctBalance.osl_debit as DebitAmountInFreeDefinedCrcy1,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency1'} } 
P_GLAcctBalance.osl_credit as CreditAmountInFreeDefinedCrcy1,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency2'} } 
P_GLAcctBalance.vsl_debit as DebitAmountInFreeDefinedCrcy2,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency2'} } 
P_GLAcctBalance.vsl_credit as CreditAmountInFreeDefinedCrcy2,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency3'} } 
P_GLAcctBalance.bsl_debit as DebitAmountInFreeDefinedCrcy3,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency3'} } 
P_GLAcctBalance.bsl_credit as CreditAmountInFreeDefinedCrcy3,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency4'} } 
P_GLAcctBalance.csl_debit as DebitAmountInFreeDefinedCrcy4,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency4'} } 
P_GLAcctBalance.csl_credit as CreditAmountInFreeDefinedCrcy4,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency5'} } 
P_GLAcctBalance.dsl_debit as DebitAmountInFreeDefinedCrcy5,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency5'} } 
P_GLAcctBalance.dsl_credit as CreditAmountInFreeDefinedCrcy5,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency6'} } 
P_GLAcctBalance.esl_debit as DebitAmountInFreeDefinedCrcy6,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency6'} } 
P_GLAcctBalance.esl_credit as CreditAmountInFreeDefinedCrcy6,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency7'} } 
P_GLAcctBalance.fsl_debit as DebitAmountInFreeDefinedCrcy7,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency7'} } 
P_GLAcctBalance.fsl_credit as CreditAmountInFreeDefinedCrcy7,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency8'} } 
P_GLAcctBalance.gsl_debit as DebitAmountInFreeDefinedCrcy8,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency8'} } 
P_GLAcctBalance.gsl_credit as CreditAmountInFreeDefinedCrcy8,

P_GLAcctBalance.poper as FiscalPeriod,

@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} } 
P_GLAcctBalance.hsl_end_bal as EndingBalanceAmtInCoCodeCrcy,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'TransactionCurrency'} } 
P_GLAcctBalance.wsl_end_bal as EndingBalanceAmtInTransCrcy,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'BalanceTransactionCurrency'} } 
P_GLAcctBalance.tsl_end_bal as EndingBalanceAmtInBalTransCrcy,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'GlobalCurrency'} } 
P_GLAcctBalance.ksl_end_bal as EndingBalanceAmtInGlobalCrcy,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FunctionalCurrency'} } 
P_GLAcctBalance.EndingBalanceAmtInFuncnlCrcy as EndingBalanceAmtInFuncnlCrcy,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency1'} } 
P_GLAcctBalance.osl_end_bal as EndingBalAmtInFreeDfndCrcy1,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency2'} } 
P_GLAcctBalance.vsl_end_bal as EndingBalAmtInFreeDfndCrcy2,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency3'} } 
P_GLAcctBalance.bsl_end_bal as EndingBalAmtInFreeDfndCrcy3,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency4'} } 
P_GLAcctBalance.csl_end_bal as EndingBalAmtInFreeDfndCrcy4,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency5'} } 
P_GLAcctBalance.dsl_end_bal as EndingBalAmtInFreeDfndCrcy5,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency6'} } 
P_GLAcctBalance.esl_end_bal as EndingBalAmtInFreeDfndCrcy6,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency7'} } 
P_GLAcctBalance.fsl_end_bal as EndingBalAmtInFreeDfndCrcy7,
@DefaultAggregation: #SUM
@Semantics: { amount : {currencyCode: 'FreeDefinedCurrency8'} } 
P_GLAcctBalance.gsl_end_bal as EndingBalAmtInFreeDfndCrcy8,

P_GLAcctBalance.AccrualObjectType,
P_GLAcctBalance.AccrualObject,
P_GLAcctBalance.AccrualSubobject,
P_GLAcctBalance.AccrualItemType,
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.AccrualObjectLogicalSystem,
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.AccrualReferenceObject,
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.AccrualValueDate,  
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_CashLedgerCompanyCode'
P_GLAcctBalance.CashLedgerCompanyCode,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_CashLedgerAccount'
P_GLAcctBalance.CashLedgerAccount,

@ObjectModel.foreignKey.association: '_FinancialManagementArea'
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.fikrs as FinancialManagementArea,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_FundsCenter'
P_GLAcctBalance.FundsCenter,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_FundedProgram'
P_GLAcctBalance.FundedProgram,

@ObjectModel.foreignKey.association: '_Fund'
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.rfund as Fund,
@ObjectModel.foreignKey.association: '_Grant'
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.rgrant_nbr as GrantID,

@ObjectModel.foreignKey.association: '_BudgetPeriod'
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.rbudget_pd as BudgetPeriod,

@ObjectModel.foreignKey.association: '_PartnerFund'
@Analytics.internalName: #LOCAL 
P_GLAcctBalance.sfund as PartnerFund,
@Analytics.internalName: #LOCAL 
@ObjectModel.foreignKey.association: '_PartnerGrant'
P_GLAcctBalance.sgrant_nbr as PartnerGrant,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PartnerBudgetPeriod'
P_GLAcctBalance.sbudget_pd as PartnerBudgetPeriod,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PubSecBudgetAccount'
P_GLAcctBalance.PubSecBudgetAccount,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PubSecBudgetAccountCoCode'
P_GLAcctBalance.PubSecBudgetAccountCoCode,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PubSecBudgetCnsmpnDate'
PubSecBudgetCnsmpnDate,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PubSecBudgetCnsmpnFsclPeriod'
P_GLAcctBalance.PubSecBudgetCnsmpnFsclPeriod,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PubSecBudgetCnsmpnFsclYear'
P_GLAcctBalance.PubSecBudgetCnsmpnFsclYear,
@Analytics.internalName: #LOCAL
P_GLAcctBalance.PubSecBudgetIsRelevant,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PubSecBudgetCnsmpnType'
P_GLAcctBalance.PubSecBudgetCnsmpnType,
@Analytics.internalName: #LOCAL
@ObjectModel.foreignKey.association: '_PubSecBudgetCnsmpnAmtType'
P_GLAcctBalance.PubSecBudgetCnsmpnAmtType,
//cast( concat( P_GLAcctBalance.budat, P_GLAcctBalance.poper  ) as fis_fiscalperioddate ) as FiscalPeriodDate,
//cast( concat(  P_GLAcctBalance.poper, P_GLAcctBalance.budat  ) as FIS_FISCALPERIODDATE ) as FiscalPeriodDate,

P_GLAcctBalance.FlowOfFundsLedgerFiscalYear,

_CompanyCode,
_JournalEntry,
_FiscalYear,
_ControllingArea,
_BalanceTransactionCurrency,
_TransactionCurrency,
_CompanyCodeCurrency,
_GlobalCurrency,
_FunctionalCurrency,
_FreeDefinedCurrency1,
_FreeDefinedCurrency2,
_FreeDefinedCurrency3,
_FreeDefinedCurrency4,
_FreeDefinedCurrency5,
_FreeDefinedCurrency6,
_FreeDefinedCurrency7,
_FreeDefinedCurrency8,
_Segment,
_PartnerSegment,
_ProfitCenter,
_CurrentProfitCenter,
_PartnerProfitCenter,
_CostCenter,
_CurrentCostCenter,
_PartnerCostCenter,
_BusinessArea,
_PartnerBusinessArea,
_FunctionalArea,
_PartnerFunctionalArea,
_GLAccountInChartOfAccounts,
_GLAccountHierarchy,
_ChartOfAccounts,
_GLAccountInCompanyCode,
_AccountingDocumentType,
_FinancialAccountType,
_DebitCreditCode, 
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_Product'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_Product'
_Material,
_Product,
_Plant,
_Ledger,
_CustomerGroup,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_SoldProductGroup_2'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_SoldProductGroup_2'
_MaterialGroup,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_SoldProductGroup_2'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_SoldProductGroup_2'
_SoldProductGroup,
_SoldProductGroup_2,    
//@API.element.releaseState: #DEPRECATED
//@API.element.successor:    '_ProductGroup_2'
//@VDM.lifecycle.status:    #DEPRECATED
//@VDM.lifecycle.successor: '_ProductGroup_2'
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_SoldProductGroup_2'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_SoldProductGroup_2'
_ProductGroup,
//_ProductGroup_2,
_Customer,
_Supplier,
_CalendarDate,
_SourceLedger,
_PostingKey,
_EliminationProfitCenter,
_InventorySpecialStockSupplier,
_AlternativeGLAccount,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_SalesDocument'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_SalesDocument'
_SalesOrder,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_SalesDocumentItem'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_SalesDocumentItem'
_SalesOrderItem,
_SalesDocument,
_SalesDocumentItem,
_InternalOrder,
_Order,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_PersonWorkAgreement_1'
@VDM.lifecycle.status:     #DEPRECATED
@VDM.lifecycle.successor:  '_PersonWorkAgreement_1'
_Employment,
_PersonWorkAgreement_1,
_FinancialTransactionType,
_BusinessTransactionType,
_ReferenceDocumentType,
_PredecessorReferenceDocType,
_PartnerCompanyCode,
_AccountingDocumentCategory,
_User,
_GLAccountType,
_OffsettingAccountType,
_OffsettingChartOfAccounts,
_OffsettingAccount,
_OffsettingAccountWithBP,
_SenderGLAccount,
_CountryChartOfAccounts,
_PurchasingDocument,
_PurchasingDocumentItem,
_SpecialGLCode,
_TaxCode,
_HouseBank,
_ClearingJrnlEntryFiscalYear,
_ClearingJournalEntry,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_ClearingJournalEntry'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_ClearingJournalEntry'
_ClearingAccountingDocument,
_MasterFixedAsset,
_FixedAsset,
_GroupMasterFixedAsset,
_GroupFixedAsset,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_InventorySpclStockValnType'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_InventorySpclStockValnType'
_InventorySpecialStockValnType,
_InventorySpclStockValnType,
_InventorySpecialStockType,
_InventorySpclStkSalesDocument,
_InventorySpclStkSalesDocItm,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_InvtrySpclStkWBSElmntBscData'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor:  '_InvtrySpclStkWBSElmntBscData'
_InvtrySpclStockWBSElmntIntID,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_InvtrySpclStockWBSElmntExtID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor:  '_InvtrySpclStockWBSElmntExtID'
_InventorySpclStockWBSElement,
_InvtrySpclStkWBSElmntBscData,
_InventoryValuationType,
_ControllingObjectClass,
_PartnerControllingObjectClass,
_OriginCostCenter,
_CostCtrActivityType,
_OriginCostCtrActivityType,
_OrderCategory,
//_RelatedNetworkActivity,
//_PartnerProjectNetworkActivity,
      
_BusinessProcess,
_PartnerCostCtrActivityType,
@API.element.releaseState: #DEPRECATED
@API.element.successor:   '_PartnerOrder_2'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_PartnerOrder_2'
_PartnerOrder,
_PartnerOrder_2,
_PartnerOrderCategory,
@API.element.releaseState: #DEPRECATED
@API.element.successor:   '_PartnerWBSElementExternalID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_PartnerWBSElementExternalID'
_PartnerWBSElement,
@API.element.releaseState: #DEPRECATED
@API.element.successor:   '_PartnerProjectExternalID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_PartnerProjectExternalID'
_PartnerProject,
_PartnerSalesDocument,
_PartnerSalesDocumentItem,
_PartnerBusinessProcess,

@API.element.releaseState: #DEPRECATED
@API.element.successor:   '_WBSElementExternalID'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_WBSElementExternalID'
_WBSElement,
@API.element.releaseState: #DEPRECATED
@API.element.successor:   '_WBSElementBasicData'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_WBSElementBasicData'
_WBSElementInternalID,
_WBSElementExternalID,
_WBSElementBasicData,
      
_BillingDocumentType,
      
_SalesOrganization,
_DistributionChannel,
     
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_SoldProduct'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_SoldProduct'      
_SoldMaterial,
_SoldProduct,   
      
_MovementCategory,
_AssetTransactionType,
      
_HouseBankAccount,
      
_LogicalSystem,
      
_OperatingConcern,
      
_PartnerCompany,
      
_ProjectNetwork,
      
_PurReqValuationArea,

_FiscalCalendarDate,

_FiscalYearVariant,

_ServiceDocumentType,

_ServiceDocument,

_ServiceDocumentItem,

_PartnerServiceDocumentType,

_PartnerServiceDocument,

_PartnerServiceDocumentItem,

_PartnerProjectExternalID,
_PartnerProjctExtrnalIDText,
_PartnerWBSElementExternalID,
_PartnerWBSElemntExtrnalIDText,
_PartnerProjectBasicData,
_PartnerProjectBasicDataText,
_PartnerWBSElementBasicData,
_PartnerWBSElmntBasicDataText,
@API.element.releaseState: #DEPRECATED
@API.element.successor:    '_InvtrySpclStkWBSElmntBscData'
@VDM.lifecycle.status:    #DEPRECATED
@VDM.lifecycle.successor: '_InvtrySpclStkWBSElmntBscData'  
_InvtrySpclStockWBSElmntBD,
_InvtrySpclStockWBSElmntExtID,
_ProjectExternalID,

_ServiceContract,
_ServiceContractType,
_ServiceContractItem,
_TimeSheetOvertimeCat,
_AccrualObjectType,
_AccrualObject,
_AccrualSubobject,
_AccrualItemType, 
_GLAccountFlowType,
_LedgerCompanyCodeCrcyRoles,

_CashLedgerCompanyCode,
_CashLedgerAccount,
_FinancialManagementArea,
_FundsCenter,
_FundedProgram,
_Fund,
_Grant,
_BudgetPeriod,
_PartnerFund,
_PartnerGrant,
_PartnerBudgetPeriod,
_PubSecBudgetAccountCoCode,
_PubSecBudgetAccount,
_PubSecBudgetCnsmpnDate,
_PubSecBudgetCnsmpnFsclPeriod,
_PubSecBudgetCnsmpnFsclYear,
_PubSecBudgetCnsmpnType,
_PubSecBudgetCnsmpnAmtType,  

_ConsolidationUnit,
_PartnerConsolidationUnit,
_Company,
_ConsolidationChartOfAccounts,
_CnsldtnFinancialStatementItem,
_CnsldtnSubitemCategory,
_CnsldtnSubitem,
_CustomerCompany,
_SupplierCompany,
//       // Just for Authorization Check!!! DO NOT USE!!! WILL BE DEPRECATED!!!
P_GLAcctBalance.GLAccountAuthorizationGroup,
P_GLAcctBalance.SupplierBasicAuthorizationGrp,
P_GLAcctBalance.CustomerBasicAuthorizationGrp,
P_GLAcctBalance.AcctgDocTypeAuthorizationGroup,
P_GLAcctBalance.OrderType,
P_GLAcctBalance.SalesOrderType,
P_GLAcctBalance.AssetClass

}   
