@AbapCatalog.sqlViewName: 'ZIGRPTMODELOV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Report Run Mode LOV'
define view ZI_GR_RPTMODE_LOV
  as select from t000
{
  'MTD' as RptMode
}
union select from t000
{
  'YTD' as RptMode
}
