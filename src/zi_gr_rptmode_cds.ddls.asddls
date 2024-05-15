@AbapCatalog.sqlViewName: 'ZIGRRPTMODECDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Group Reporting Modes'
define view ZI_GR_RPTMODE_CDS
with parameters
P_MODE  : abap.char(3)
as select from t000
{
cast(:P_MODE as abap.char(3)) as RPT_MODE    
}
where mandt = $session.client
