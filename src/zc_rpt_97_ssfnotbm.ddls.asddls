@AbapCatalog.sqlViewName: 'ZVRPT97CONS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Report 97'
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@OData.publish: true
@ObjectModel.representativeKey: 'mainnode'
//@ObjectModel.usageType.serviceQuality: #A
//@ObjectModel.usageType.sizeCategory: #S
//@ObjectModel.usageType.dataClass: #CUSTOMIZING
@AbapCatalog: {
                buffering.status: #NOT_ALLOWED }

@Analytics.settings.maxProcessingEffort: #HIGH
@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata: { ignorePropagatedAnnotations: true,
             allowExtensions: true }
@ObjectModel: { supportedCapabilities: [ #ANALYTICAL_QUERY ],
                modelingPattern: #ANALYTICAL_QUERY,
                usageType: { sizeCategory: #XXL,
                             serviceQuality: #D,
                             dataClass: #MIXED } }
define view ZC_RPT_97_SSFNOTBM
  with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
  as select from ZI_RPT97_3
                 ( P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate )

{
key counter,
key mainnode,
key subnode,
key Ledger,
key CompanyCode,
key FiscalYear,
key SourceLedger,
key AccountingDocument,
key LedgerGLLineItem,
key GLAccountFlowType,
GLAccountGroup,
GLAccount,
GLAccountHierarchy,
ProfitCenter,
FiscalYearVariant,
FiscalYearPeriod,
PostingDate,
GLAccountType,
ChartOfAccounts,
Plant,
Supplier,
Customer,
Material,
FinancialAccountType,
CompanyCodeCurrency,
AmountInCompanyCodeCurrency,
FiscalPeriod,
CQtrPostingDt,
CMonPostingDt,
CYrPostingDt,
CMonDescPostingDt,
@EndUserText.label: 'Store Location'
Location ,
Facilities,
NodeValue,
Storage,
NOI,
Mainnodetxt,
 @AnalyticsDetails.query.axis: #COLUMNS
subnodetxt,
/* Associations */
_MText,
_SText

}
