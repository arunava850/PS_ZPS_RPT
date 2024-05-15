@AbapCatalog.sqlViewName: 'ZIGRHIERCATG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Group Reporting Hierarchy with Category'
define view ZI_GR_HIER_CATG
with parameters
p_coa : fc_itclg 
as select from uhdt_hid 
{
hier_hid,
hier_catg,
ver_id,
cast(concat(concat(concat(concat(hier_catg, '/'),:p_coa),'/'),hier_hid) as hryid) as ZHIER_HID    
}
