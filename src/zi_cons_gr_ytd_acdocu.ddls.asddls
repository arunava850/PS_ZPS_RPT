// SQL View Name
@AbapCatalog.sqlViewName: 'ZGR_YTD_DATA'

//Complier Checks
@AbapCatalog.compiler.compareFilter: true

//Preserve Key
@AbapCatalog.preserveKey: true

//Authorization Checks
@AccessControl.authorizationCheck: #NOT_REQUIRED

//View Name
@EndUserText.label: 'Consolidated YTD Data'

//View Definition
define view ZI_CONS_GR_YTD_ACDOCU                 
with parameters
    P_FISCPER  : fis_jahrper_conv,
    P_MODE     : abap.char(3),
    P_HIER     : fincs_ithry
as 

//Current Year YTD Values
select from 
ZI_GR_FISCPER_CDS( P_FISCPER : $parameters.P_FISCPER  ) as a     
join ZI_GR_RPTMODE_CDS( P_MODE : $parameters.P_MODE ) as b on b.RPT_MODE = 'MTD'  or b.RPT_MODE = 'YTD'       
join ZI_CONS_HIER_ACDOCU(P_HIER : $parameters.P_HIER ) as c  on c.FsItemHierarchy = $parameters.P_HIER   and
                                                                c.FiscalYearPeriod between a.CUR_YR_JAN_FROM and a.CUR_QTR_TO_PER and
                                                                c.hryvalfrom      <= a.CUR_PER_FIRST_DD  and
                                                                c.hryvalto        >=  a.CUR_PER_FIRST_DD                       
{
  key c.FsItemHierarchy,   
  key c.ConsolidationLedger,
  key c.ConsolidationDimension,
  key c.ConsolidationChartOfAccounts,  
  key c.Company,
  key c.ConsolidationUnit,
  key c.FinancialStatementItem, 
      c.ConsolidationVersion,
      c.GroupCurrency,
      c.ConsolidationGroup,
      c.CompanyCode,
      c.FiscalYearVariant,
      c.GLRecordType,
      b.RPT_MODE as record_mode,
      sum(c.AmountInGroupCurrency) as CY_YTD_AmountInGC,
      cast(0 as fincs_ksl ) as PY_YTD_AmountInGC,
      cast(0 as fincs_ksl ) as PY2YTD_AmountInGC
}
    group by
      c.FsItemHierarchy,   
      c.ConsolidationLedger,
      c.ConsolidationDimension,
      c.ConsolidationChartOfAccounts,  
      c.Company,
      c.ConsolidationUnit,
      c.FinancialStatementItem, 
      c.ConsolidationVersion,
      c.GroupCurrency,
      c.ConsolidationGroup,
      c.CompanyCode,
      c.FiscalYearVariant,
      c.GLRecordType,
      b.RPT_MODE
      
union

//Prior Year YTD Values
select from 
ZI_GR_FISCPER_CDS( P_FISCPER : $parameters.P_FISCPER  ) as a 
join ZI_GR_RPTMODE_CDS( P_MODE : $parameters.P_MODE ) as b on b.RPT_MODE = 'MTD'  or b.RPT_MODE = 'YTD'                   
join ZI_CONS_HIER_ACDOCU(P_HIER : $parameters.P_HIER ) as c  on c.FsItemHierarchy = $parameters.P_HIER   and
                                                                c.FiscalYearPeriod between a.PREV_YR_JAN_FROM and a.PREV_YR_SAME_QTR_TO_PER and
                                                                c.hryvalfrom      <= a.CUR_PER_FIRST_DD  and
                                                                c.hryvalto        >=  a.CUR_PER_FIRST_DD                       
{
  key c.FsItemHierarchy,   
  key c.ConsolidationLedger,
  key c.ConsolidationDimension,
  key c.ConsolidationChartOfAccounts,  
  key c.Company,
  key c.ConsolidationUnit,
  key c.FinancialStatementItem, 
      c.ConsolidationVersion,
      c.GroupCurrency,
      c.ConsolidationGroup,
      c.CompanyCode,
      c.FiscalYearVariant,
      c.GLRecordType,
      b.RPT_MODE as record_mode,
      cast(0 as fincs_ksl ) as CY_YTD_AmountInGC,
      sum(c.AmountInGroupCurrency) as PY_YTD_AmountInGC,
      cast(0 as fincs_ksl ) as PY2YTD_AmountInGC
}
     group by
      c.FsItemHierarchy,   
      c.ConsolidationLedger,
      c.ConsolidationDimension,
      c.ConsolidationChartOfAccounts,  
      c.Company,
      c.ConsolidationUnit,
      c.FinancialStatementItem, 
      c.ConsolidationVersion,
      c.GroupCurrency,
      c.ConsolidationGroup,
      c.CompanyCode,
      c.FiscalYearVariant,
      c.GLRecordType,
      b.RPT_MODE
      
union

//Prior Prior (CY-2) Year YTD Values for the Reporting Mode MTD
select from 
ZI_GR_FISCPER_CDS( P_FISCPER : $parameters.P_FISCPER  ) as a 
join ZI_GR_RPTMODE_CDS( P_MODE : $parameters.P_MODE ) as b on b.RPT_MODE = 'MTD'  or b.RPT_MODE = 'YTD'                    
join ZI_CONS_HIER_ACDOCU(P_HIER : $parameters.P_HIER ) as c  on c.FsItemHierarchy = $parameters.P_HIER and
                                                                c.FiscalYearPeriod between a.PREV_YR2_JAN_FROM and a.PREV_YR2_DEC_TO 
                                                                and c.hryvalfrom      <= a.CUR_PER_FIRST_DD  and
                                                                c.hryvalto        >=  a.CUR_PER_FIRST_DD                       
{
  key c.FsItemHierarchy,   
  key c.ConsolidationLedger,
  key c.ConsolidationDimension,
  key c.ConsolidationChartOfAccounts,  
  key c.Company,
  key c.ConsolidationUnit,
  key c.FinancialStatementItem, 
      c.ConsolidationVersion,
      c.GroupCurrency,
      c.ConsolidationGroup,
      c.CompanyCode, 
      c.FiscalYearVariant,
      c.GLRecordType,
      b.RPT_MODE as record_mode,
      cast(0 as fincs_ksl ) as CY_YTD_AmountInGC,
      cast(0 as fincs_ksl ) as PY_YTD_AmountInGC,
      sum(c.AmountInGroupCurrency) as PY2YTD_AmountInGC
}
   group by
      c.FsItemHierarchy,   
      c.ConsolidationLedger,
      c.ConsolidationDimension,
      c.ConsolidationChartOfAccounts,  
      c.Company,
      c.ConsolidationUnit,
      c.FinancialStatementItem, 
      c.ConsolidationVersion,
      c.GroupCurrency,
      c.ConsolidationGroup,
      c.CompanyCode,
      c.FiscalYearVariant,
      c.GLRecordType,
      b.RPT_MODE
