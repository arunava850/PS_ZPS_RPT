// SQL View Name
@AbapCatalog.sqlViewName: 'ZCGRITMCUBEFSI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true

// Auth Check 
@AccessControl.authorizationCheck: #CHECK

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
@EndUserText.label: 'GR Consolidation Cube (FS Item Hier)'

define view ZC_GR_ITM_FSI_CUBE
with parameters
P_FISCPER  : fis_jahrper_conv,
P_MODE     : abap.char(3),
P_HIER     : fincs_ithry
 as select from ZI_CONS_GR_DATA(P_FISCPER  : $parameters.P_FISCPER,
                                   P_MODE     : $parameters.P_MODE,
                                   P_HIER     : $parameters.P_HIER) 
association [1..1] to I_CnsldtnLedger                as _Ledger           on  $projection.ConsolidationLedger = _Ledger.ConsolidationLedger  
association [1..1] to I_CnsldtnDimension             as _Dimension        on  $projection.ConsolidationDimension = _Dimension.ConsolidationDimension
association [1..1] to I_CnsldtnVersion               as _Version          on  $projection.ConsolidationVersion = _Version.ConsolidationVersion
association [1..1] to I_CnsldtnGroupWithEmptyValue   as _CnsldtnGroup     on  $projection.ConsolidationDimension = _CnsldtnGroup.ConsolidationDimension and
                                                                              $projection.ConsolidationGroup     = _CnsldtnGroup.ConsolidationGroup
association [1..1] to I_CnsldtnChartOfAccounts       as _ChartOfAccounts  on  $projection.ConsolidationChartOfAccounts = _ChartOfAccounts.ConsolidationChartOfAccounts
association [1..1] to I_GroupReportingFSItem         as _FinStmntItm      on  $projection.ConsolidationChartOfAccounts = _FinStmntItm.ConsolidationChartOfAccounts and
                                                                              $projection.FinancialStatementItem       = _FinStmntItm.FinancialStatementItem
association [1..1] to I_Globalcompany                as _Company          on  $projection.Company = _Company.Company
association [1..1] to I_CnsldtnDocumentType          as _DocumentType     on  $projection.ConsolidationDimension    = _DocumentType.ConsolidationDimension and
                                                                              $projection.consolidationdocumenttype = _DocumentType.ConsolidationDocumentType
association [0..1] to I_CnsldtnUnit_2                as _PartnerUnit      on  $projection.ConsolidationDimension   = _PartnerUnit.ConsolidationDimension and
                                                                              $projection.partnerconsolidationunit = _PartnerUnit.ConsolidationUnit
association [0..1] to I_Currency                     as _TransCurrency    on  $projection.transactioncurrency = _TransCurrency.Currency
association [0..1] to I_Currency                     as _LocalCurrency    on  $projection.localcurrency = _LocalCurrency.Currency
association [0..1] to I_Currency                     as _GroupCurrency    on  $projection.GroupCurrency = _GroupCurrency.Currency
association [0..1] to I_UnitOfMeasure                as _BaseUnit         on  $projection.baseunit = _BaseUnit.UnitOfMeasure
association [1..1] to I_CnsldtnUnit_2                as _CnsldtnUnit      on  $projection.ConsolidationDimension = _CnsldtnUnit.ConsolidationDimension and
                                                                              $projection.ConsolidationUnit      = _CnsldtnUnit.ConsolidationUnit
association [0..1] to I_CompanyCode                  as _CompanyCode      on  $projection.CompanyCode = _CompanyCode.CompanyCode
{
       @EndUserText.label: 'FS Hierarchy'
       @Environment.sql.passValue: true
       key FsItemHierarchy,
    
       @EndUserText.label: 'Cons. Ledger'
       @Environment.sql.passValue: true
       @ObjectModel.foreignKey.association: '_Ledger'
       key  ConsolidationLedger,

       @EndUserText.label: 'Cons. Dimension'
       @Environment.sql.passValue: true
       @ObjectModel.foreignKey.association: '_Dimension'
       key  ConsolidationDimension,

       @EndUserText.label: 'GL Record Type'
       @Environment.sql.passValue: true
       GLRecordType,

       @EndUserText.label: 'Cons. Version'
       @Environment.sql.passValue: true
       @ObjectModel.foreignKey.association: '_Version'
       ConsolidationVersion,

       @EndUserText.label: 'Fiscal Year Variant'
       @Semantics.fiscal.yearVariant: true
       FiscalYearVariant,

       @EndUserText.label: 'Company'
       @ObjectModel.foreignKey.association: '_Company'
       Company,

       @EndUserText.label: 'Consolidation Unit'
       @Environment.sql.passValue: true
       @ObjectModel.foreignKey.association: '_CnsldtnUnit'
       ConsolidationUnit,

       @EndUserText.label: 'Cons. Chart Of Accts'
       @ObjectModel.foreignKey.association: '_ChartOfAccounts'
       ConsolidationChartOfAccounts,

       @EndUserText.label: 'FS Item'
       @Environment.sql.passValue: true
       @ObjectModel.foreignKey.association: '_FinStmntItm'
       FinancialStatementItem,

       @EndUserText.label: 'Cons. Group'
       @Environment.sql.passValue: true
       @ObjectModel.foreignKey.association: '_CnsldtnGroup'
       ConsolidationGroup,

       @EndUserText.label: 'Company Code'
       @Environment.sql.passValue: true
       @ObjectModel.foreignKey.association: '_CompanyCode'
       CompanyCode,

       @EndUserText.label: 'Report Run Mode'
       report_mode,
       
       @EndUserText.label: 'Group Currency'
       @Semantics.currencyCode:true
       @ObjectModel.foreignKey.association: '_GroupCurrency'
       GroupCurrency,

       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode:'GroupCurrency'
       @EndUserText.label: 'CY QTD Amount in GC'
       CY_QTD_AmountInGC,
       
       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode:'GroupCurrency'
       @EndUserText.label: 'PY QTD Amount in GC'
       PY_QTD_AmountInGC,
       
       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode:'GroupCurrency'
       @EndUserText.label: 'CY YTD Amount in GC'
       CY_YTD_AmountInGC,
       
       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode:'GroupCurrency'
       @EndUserText.label: 'PY YTD Amount in GC'
       PY_YTD_AmountInGC,
       
       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode:'GroupCurrency'
       @EndUserText.label: 'PY2 YTD Amount in GC'
       PY2YTD_AmountInGC,
       
       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode:'GroupCurrency'
       @EndUserText.label: 'QTD Change'
       QTD_Change,
       
       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode:'GroupCurrency'
       @EndUserText.label: 'YTD Change'
       YTD_Change,
       

       _Ledger,
       _Dimension,
       _Version,
       _ChartOfAccounts,
       _FinStmntItm,
       _Company,
       _CompanyCode,       
       _GroupCurrency,
       _CnsldtnUnit,
       _CnsldtnGroup
}
