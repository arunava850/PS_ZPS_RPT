@AbapCatalog.sqlViewName: 'ZISNNODETEXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TXT'
@ObjectModel.representativeKey: 'SubNode'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING

define view ZI_SNODE_TXT
  as select from ztrpt_fi_mstrtxt
{
  key rptid                      as ReportId,
  key subnode                    as SubNode,
      //      @ObjectModel.foreignKey.association: '_Language'
      //      @Semantics.language: true
  key spras                      as Spras,
      mainnode                   as MainNode,
      @Semantics.text: true
      concat(subnodeseq,subnode) as subnodetxt
}
where

  subnodeseq <> '000'
