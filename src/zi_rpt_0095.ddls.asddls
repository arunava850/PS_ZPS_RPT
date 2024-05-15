@AbapCatalog.sqlViewName: 'ZIRPT0095'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Developed & Expanded with Prof Hier'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZI_RPT_0095
with parameters
    P_FromPostingDate : fis_budat_from,
    P_ToPostingDate   : fis_budat_to
    
as select from ZB_2_RPT_0095 as a inner join ZB_RPT_0095
(P_FromPostingDate: $parameters.P_FromPostingDate, P_ToPostingDate: $parameters.P_ToPostingDate ) as b

on a.NodeValue = b.ProfitCenter

{
    
    key a.HierarchyParentNode as HierarchyParentNode,
    key b.Ledger,
    key b.CompanyCode,
    key b.FiscalYear,
    key b.SourceLedger,
    key b.AccountingDocument,
    key b.LedgerGLLineItem,
    key b.GLAccountFlowType,
    key b.FiscalPeriodDate,
    
    a.Facilities,  
    a.NodeValue as NodeValue,
    b.GLAccount,
    b.ProfitCenter,
    b.PostingDate,
    b.GlobalCurrency, 
    b.ZYEAR,
    b.ZLYEAR,
    b.ZLYMTH, 
    b.ZLQUARTER,
    b.ZMONTH,
    
    case when ZMONTH = '01' then '1'
         when ZMONTH = '02' then '1'
         when ZMONTH = '03' then '1'
         when ZMONTH = '04' then '2'
         when ZMONTH = '05' then '2'
         when ZMONTH = '06' then '2'
         when ZMONTH = '07' then '3'
         when ZMONTH = '08' then '3'
         when ZMONTH = '09' then '3'
         when ZMONTH = '10' then '4'
         when ZMONTH = '11' then '4'
         when ZMONTH = '12' then '4' end as CQtr, 
    
    case when ZLYEAR = substring(b.PostingDate,1,4) //and b.ZMONTH >= substring(b.PostingDate,5,2)
              then substring(b.PostingDate,5,2)                                          end as LYQTR,
    
    case when ZYEAR = substring(b.PostingDate,1,4) 
              //then substring($parameters.P_ToPostingDate,1,4)                            end as CYEAR,
              then substring(b.PostingDate,1,4)                                          end as CYEAR,
        
    case when ZYEAR = substring(b.PostingDate,1,4)  //and b.ZMONTH >= substring(b.PostingDate,5,2)
              then substring(b.PostingDate,5,2)                                          end as CYQTR,
                  
    case when ZYEAR = substring(b.PostingDate,1,4) // and b.ZMONTH = substring(b.PostingDate,5,2)
              //then substring($parameters.P_ToPostingDate,5,2)                            end as CCMONTH,
              then substring(b.PostingDate,5,2)                                          end as CCMONTH,
    
    case when ZLYEAR = substring(b.PostingDate,1,4) 
              //then substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-365,'NULL'),1,4) end as LYEAR,
              then substring(b.PostingDate,1,4)                                          end as LYEAR,
    
    case when ZL2LYEAR = substring(b.PostingDate,1,4) 
              //then substring(DATS_ADD_DAYS($parameters.P_ToPostingDate,-730,'NULL'),1,4) end as L2LYEAR,  
              then substring(b.PostingDate,1,4)                                          end as L2LYEAR,
      
    @AnalyticsDetails.query.axis: #ROWS
    @DefaultAggregation: #SUM
    b.AmountInGlobalCurrency
    

    } 
        where FiscalYear <> '0000'   
           
