@AbapCatalog.sqlViewName: 'ZIGRFISCPERCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fiscal Period View'
define view ZI_GR_FISCPER_CDS
with parameters
P_FISCPER  : fis_jahrper_conv
as select from t000
{

 key cast(:P_FISCPER as fis_jahrper_conv) as CUR_PER,

  cast(concat(concat(substring(:P_FISCPER,1,4), substring(:P_FISCPER,6,2)),'01'  ) as abap.dats) as CUR_PER_FIRST_DD,
 
  cast(concat(substring(:P_FISCPER,1,4), '001') as fis_jahrper_conv) as CUR_YR_JAN_FROM,

  cast(concat(substring(:P_FISCPER,1,4), '012') as fis_jahrper_conv) as CUR_YR_DEC_TO,

  case substring(:P_FISCPER,5,3)
           when '001' then cast(concat(substring(:P_FISCPER,1,4), '001') as fis_jahrper_conv)
           when '002' then cast(concat(substring(:P_FISCPER,1,4), '001') as fis_jahrper_conv)
           when '003' then cast(concat(substring(:P_FISCPER,1,4), '001') as fis_jahrper_conv)
           when '004' then cast(concat(substring(:P_FISCPER,1,4), '004') as fis_jahrper_conv)
           when '005' then cast(concat(substring(:P_FISCPER,1,4), '004') as fis_jahrper_conv)
           when '006' then cast(concat(substring(:P_FISCPER,1,4), '004') as fis_jahrper_conv)
           when '007' then cast(concat(substring(:P_FISCPER,1,4), '007') as fis_jahrper_conv)
           when '008' then cast(concat(substring(:P_FISCPER,1,4), '007') as fis_jahrper_conv)
           when '009' then cast(concat(substring(:P_FISCPER,1,4), '007') as fis_jahrper_conv)
           when '010' then cast(concat(substring(:P_FISCPER,1,4), '010') as fis_jahrper_conv)
           when '011' then cast(concat(substring(:P_FISCPER,1,4), '010') as fis_jahrper_conv)
           when '012' then cast(concat(substring(:P_FISCPER,1,4), '010') as fis_jahrper_conv)
      end as CUR_QTR_FROM_PER,

  case substring(:P_FISCPER,5,3)
           when '001' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '002' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '003' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '004' then cast(concat(substring(:P_FISCPER,1,4), '006') as fis_jahrper_conv)
           when '005' then cast(concat(substring(:P_FISCPER,1,4), '006') as fis_jahrper_conv)
           when '006' then cast(concat(substring(:P_FISCPER,1,4), '006') as fis_jahrper_conv)
           when '007' then cast(concat(substring(:P_FISCPER,1,4), '009') as fis_jahrper_conv)
           when '008' then cast(concat(substring(:P_FISCPER,1,4), '009') as fis_jahrper_conv)
           when '009' then cast(concat(substring(:P_FISCPER,1,4), '009') as fis_jahrper_conv)
           when '010' then cast(concat(substring(:P_FISCPER,1,4), '012') as fis_jahrper_conv)
           when '011' then cast(concat(substring(:P_FISCPER,1,4), '012') as fis_jahrper_conv)
           when '012' then cast(concat(substring(:P_FISCPER,1,4), '012') as fis_jahrper_conv)
      end as CUR_QTR_TO_PER,

  case substring(:P_FISCPER,5,3)
           when '001' then   cast(concat(
                                 cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                 '010' ) as fis_jahrper_conv)
           when '002' then cast(concat(
                                 cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                 '010' ) as fis_jahrper_conv)
           when '003' then cast(concat(
                                 cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                 '010' ) as fis_jahrper_conv)
           when '004' then cast(concat(substring(:P_FISCPER,1,4), '001') as fis_jahrper_conv)
           when '005' then cast(concat(substring(:P_FISCPER,1,4), '001') as fis_jahrper_conv)
           when '006' then cast(concat(substring(:P_FISCPER,1,4), '001') as fis_jahrper_conv)
           when '007' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '008' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '009' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '010' then cast(concat(substring(:P_FISCPER,1,4), '007') as fis_jahrper_conv)
           when '011' then cast(concat(substring(:P_FISCPER,1,4), '007') as fis_jahrper_conv)
           when '012' then cast(concat(substring(:P_FISCPER,1,4), '007') as fis_jahrper_conv)
      end as CUR_PREV_QTR_FROM_PER,

  case substring(:P_FISCPER,5,3)
           when '001' then   cast(concat(
                                 cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                 '012' ) as fis_jahrper_conv)
           when '002' then cast(concat(
                                 cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                 '012' ) as fis_jahrper_conv)
           when '003' then cast(concat(
                                 cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                 '012' ) as fis_jahrper_conv)
           when '004' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '005' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '006' then cast(concat(substring(:P_FISCPER,1,4), '003') as fis_jahrper_conv)
           when '007' then cast(concat(substring(:P_FISCPER,1,4), '006') as fis_jahrper_conv)
           when '008' then cast(concat(substring(:P_FISCPER,1,4), '006') as fis_jahrper_conv)
           when '009' then cast(concat(substring(:P_FISCPER,1,4), '006') as fis_jahrper_conv)
           when '010' then cast(concat(substring(:P_FISCPER,1,4), '009') as fis_jahrper_conv)
           when '011' then cast(concat(substring(:P_FISCPER,1,4), '009') as fis_jahrper_conv)
           when '012' then cast(concat(substring(:P_FISCPER,1,4), '009') as fis_jahrper_conv)
      end as CUR_PREV_QTR_TO_PER,

  cast(concat(
  cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
  substring(:P_FISCPER,5,3) ) as fis_jahrper_conv) as PREV_YR_SAME_PER,

  cast(concat(
  cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
  '001' ) as fis_jahrper_conv) as PREV_YR_JAN_FROM,

  cast(concat(
  cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
  '012' ) as fis_jahrper_conv) as PREV_YR_DEC_TO,

  case substring(:P_FISCPER,5,3)
           when '001' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
           when '002' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
           when '003' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
           when '004' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '004') as fis_jahrper_conv)
           when '005' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '004') as fis_jahrper_conv)
           when '006' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '004') as fis_jahrper_conv)
           when '007' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '007') as fis_jahrper_conv)
           when '008' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '007') as fis_jahrper_conv)
           when '009' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '007') as fis_jahrper_conv)
           when '010' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '010') as fis_jahrper_conv)
           when '011' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '010') as fis_jahrper_conv)
           when '012' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '010') as fis_jahrper_conv)
      end as PREV_YR_SAME_QTR_FROM_PER,

  case substring(:P_FISCPER,5,3)
           when '001' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '002' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '003' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '004' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '005' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '006' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '007' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
           when '008' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
           when '009' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
           when '010' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '012') as fis_jahrper_conv)
           when '011' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '012') as fis_jahrper_conv)
           when '012' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '012') as fis_jahrper_conv)
      end as PREV_YR_SAME_QTR_TO_PER,

  case substring(:P_FISCPER,5,3)
           when '001' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '010') as fis_jahrper_conv)
           when '002' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '010') as fis_jahrper_conv)
           when '003' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '010') as fis_jahrper_conv)
           when '004' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
           when '005' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
           when '006' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
           when '007' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '008' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '009' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '010' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '011' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '012' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
      end as PREV_YR_PREV_QTR_FROM_PER,

  case substring(:P_FISCPER,5,3)
           when '001' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '012') as fis_jahrper_conv)
           when '002' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '012') as fis_jahrper_conv)
           when '003' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '012') as fis_jahrper_conv)
           when '004' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '005' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '006' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
           when '007' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '008' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '009' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
           when '010' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
           when '011' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
           when '012' then cast(concat(cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
      end as PREV_YR_PREV_QTR_TO_PER,

  cast(concat(
  cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)),
  '001' ) as fis_jahrper_conv) as PREV_YR2_JAN_FROM,

  cast(concat(
  cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)),
  '012' ) as fis_jahrper_conv) as PREV_YR2_DEC_TO,

  cast(concat(
  cast((cast(cast(substring(:P_FISCPER,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)),
  substring(:P_FISCPER,5,3) ) as fis_jahrper_conv) as PREV_YR2_SAME_PER

}
where mandt = $session.client
