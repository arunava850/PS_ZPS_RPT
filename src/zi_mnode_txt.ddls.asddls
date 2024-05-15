@AbapCatalog.sqlViewName: 'ZIMNNODETEXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TXT'
@ObjectModel.representativeKey: 'Mainnode'
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING

define view ZI_MNODE_TXT
  as select from ztrpt_fi_mstrtxt
{
  key rptid                        as ReportId,
  key mainnode                     as Mainnode,
      //      @ObjectModel.foreignKey.association: '_Language'
      //      @Semantics.language: true
  key spras                        as Spras,
      @Semantics.text: true
      concat(mainnodeseq,mainnode) as Mainnodetxt
}
where
  subnodeseq = '000'
