@AbapCatalog.sqlViewName: 'ZBRPT95'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developed and Extended Facilities1'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZB_RPT_95 
with parameters   
   p_qtr           : abap.char(1),
   p_year          : abap.char(4)  
            
as select from I_GLAccountLineItem as a inner join ska1 as b on a.GLAccount = b.saknr
                                                                                                                                
 {
 
  key Ledger,
  key CompanyCode,
  key FiscalYear,
  key SourceLedger,
  key AccountingDocument,
  key LedgerGLLineItem,
  LedgerFiscalYear,
  FiscalPeriod,
  b.bilkt as GroupAcc,
  GLAccount,
  ProfitCenter,
  FunctionalArea,
  BusinessArea,
  ControllingArea,
  PostingDate, 
 
  case  $parameters.p_qtr 
       when '1' then concat($parameters.p_year,'0331') 
       when '2' then concat($parameters.p_year,'0630') 
       when '3' then concat($parameters.p_year,'0930') 
       when '4' then concat($parameters.p_year,'1231') end as CustomDt,
       
  GlobalCurrency,
  @DefaultAggregation: #SUM
  AmountInGlobalCurrency
} 
   where SourceLedger = '0L' and Ledger = '0L'
    
    
