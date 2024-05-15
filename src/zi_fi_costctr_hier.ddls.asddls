@AbapCatalog.sqlViewName: 'ZIFICOSTCTRHIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Cost Center Hierarchy'
define view ZI_FI_COSTCTR_HIER
with parameters
    P_HIER     : setnamenew
as select from setheader as a
join setleaf as b on a.setclass = b.setclass and
                       a.subclass = b.subclass and
                       a.setname = b.setname
{
key cast(a.subclass as kokrs) as Cntrl_Area,
key a.setname as Costctr_Hrchy,
key cast(b.valfrom as kostl) as Costctr_from,
key cast(b.valto as kostl) as Costctr_to,
   b.valsign,
   b.valoption,
   b.seqnr
} where 
    a.setclass = '0101'
    and a.setname = $parameters.P_HIER
    
