@AbapCatalog.sqlViewName: 'ZIFIPROFITCTRHR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Profit Center Hierarchy'
define view ZI_FI_PROFITCTR_HIER
with parameters
P_HIER     : setnamenew
as select from setheader as a
join setleaf as b on a.setclass = b.setclass and
                       a.subclass = b.subclass and
                       a.setname = b.setname
{
key cast(a.subclass as kokrs) as Cntrl_Area,
key a.setname as Profitctr_Hrchy,
key cast(b.valfrom as prctr) as Profitctr_from,
key cast(b.valto as prctr) as Profitctr_to,
   b.valsign,
   b.valoption,
   b.seqnr
} where 
    a.setclass = '0106'
    and a.setname = $parameters.P_HIER
