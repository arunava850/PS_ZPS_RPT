@AbapCatalog.sqlViewName: 'ZIDTFISCPERCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Date Based Fiscal Period View'
define view ZI_DT_FISCPER_CDS
  with parameters
    P_VARNT : fis_periv,
    P_DATE  : abap.dats
  as select from P_FiscalYearPeriod as A
{
  key A.fiscal_year_variant,
  key A.fiscal_year_period,
  key cast($parameters.P_DATE as dats)                                                   as Curr_Date,
      A.fiscal_period_start_date,
      A.fiscal_period_end_date,
      A.is_special_period,
      A.fiscal_year_start_date,
      A.fiscal_year_end_date,
      A.fiscal_year,
      cast(A.fiscal_year as abap.int2)                                                   as FiscalYearInt,
      (cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as PrevYearInt,
      (cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as Prev2YearInt,
      A.fiscal_period,

      case substring(A.fiscal_year_period,5,3)
               when '001' then cast(concat(substring(A.fiscal_year_period,1,4), '001') as fis_jahrper_conv)
               when '002' then cast(concat(substring(A.fiscal_year_period,1,4), '001') as fis_jahrper_conv)
               when '003' then cast(concat(substring(A.fiscal_year_period,1,4), '001') as fis_jahrper_conv)
               when '004' then cast(concat(substring(A.fiscal_year_period,1,4), '004') as fis_jahrper_conv)
               when '005' then cast(concat(substring(A.fiscal_year_period,1,4), '004') as fis_jahrper_conv)
               when '006' then cast(concat(substring(A.fiscal_year_period,1,4), '004') as fis_jahrper_conv)
               when '007' then cast(concat(substring(A.fiscal_year_period,1,4), '007') as fis_jahrper_conv)
               when '008' then cast(concat(substring(A.fiscal_year_period,1,4), '007') as fis_jahrper_conv)
               when '009' then cast(concat(substring(A.fiscal_year_period,1,4), '007') as fis_jahrper_conv)
               when '010' then cast(concat(substring(A.fiscal_year_period,1,4), '010') as fis_jahrper_conv)
               when '011' then cast(concat(substring(A.fiscal_year_period,1,4), '010') as fis_jahrper_conv)
               when '012' then cast(concat(substring(A.fiscal_year_period,1,4), '010') as fis_jahrper_conv)
          end                                                                            as CUR_QTR_FROM_PER,

      case substring(A.fiscal_year_period,5,3)
               when '001' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '002' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '003' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '004' then cast(concat(substring(A.fiscal_year_period,1,4), '006') as fis_jahrper_conv)
               when '005' then cast(concat(substring(A.fiscal_year_period,1,4), '006') as fis_jahrper_conv)
               when '006' then cast(concat(substring(A.fiscal_year_period,1,4), '006') as fis_jahrper_conv)
               when '007' then cast(concat(substring(A.fiscal_year_period,1,4), '009') as fis_jahrper_conv)
               when '008' then cast(concat(substring(A.fiscal_year_period,1,4), '009') as fis_jahrper_conv)
               when '009' then cast(concat(substring(A.fiscal_year_period,1,4), '009') as fis_jahrper_conv)
               when '010' then cast(concat(substring(A.fiscal_year_period,1,4), '012') as fis_jahrper_conv)
               when '011' then cast(concat(substring(A.fiscal_year_period,1,4), '012') as fis_jahrper_conv)
               when '012' then cast(concat(substring(A.fiscal_year_period,1,4), '012') as fis_jahrper_conv)
          end                                                                            as CUR_QTR_TO_PER,

      case substring(A.fiscal_year_period,5,3)
               when '001' then   cast(concat(
                                     cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                     '010' ) as fis_jahrper_conv)
               when '002' then cast(concat(
                                     cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                     '010' ) as fis_jahrper_conv)
               when '003' then cast(concat(
                                     cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                     '010' ) as fis_jahrper_conv)
               when '004' then cast(concat(substring(A.fiscal_year_period,1,4), '001') as fis_jahrper_conv)
               when '005' then cast(concat(substring(A.fiscal_year_period,1,4), '001') as fis_jahrper_conv)
               when '006' then cast(concat(substring(A.fiscal_year_period,1,4), '001') as fis_jahrper_conv)
               when '007' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '008' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '009' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '010' then cast(concat(substring(A.fiscal_year_period,1,4), '007') as fis_jahrper_conv)
               when '011' then cast(concat(substring(A.fiscal_year_period,1,4), '007') as fis_jahrper_conv)
               when '012' then cast(concat(substring(A.fiscal_year_period,1,4), '007') as fis_jahrper_conv)
          end                                                                            as CUR_PREV_QTR_FROM_PER,

      case substring(A.fiscal_year_period,5,3)
               when '001' then   cast(concat(
                                     cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                     '012' ) as fis_jahrper_conv)
               when '002' then cast(concat(
                                     cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                     '012' ) as fis_jahrper_conv)
               when '003' then cast(concat(
                                     cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
                                     '012' ) as fis_jahrper_conv)
               when '004' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '005' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '006' then cast(concat(substring(A.fiscal_year_period,1,4), '003') as fis_jahrper_conv)
               when '007' then cast(concat(substring(A.fiscal_year_period,1,4), '006') as fis_jahrper_conv)
               when '008' then cast(concat(substring(A.fiscal_year_period,1,4), '006') as fis_jahrper_conv)
               when '009' then cast(concat(substring(A.fiscal_year_period,1,4), '006') as fis_jahrper_conv)
               when '010' then cast(concat(substring(A.fiscal_year_period,1,4), '009') as fis_jahrper_conv)
               when '011' then cast(concat(substring(A.fiscal_year_period,1,4), '009') as fis_jahrper_conv)
               when '012' then cast(concat(substring(A.fiscal_year_period,1,4), '009') as fis_jahrper_conv)
          end                                                                            as CUR_PREV_QTR_TO_PER,

      cast(concat(
        cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
        substring(A.fiscal_year_period,5,3) ) as fis_jahrper_conv)                       as PREV_YR_SAME_PER,

      cast(concat(
      cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
      '001' ) as fis_jahrper_conv)                                                       as PREV_YR_JAN_FROM,

      cast(concat(
      cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)),
      '012' ) as fis_jahrper_conv)                                                       as PREV_YR_DEC_TO,

      case substring(A.fiscal_year_period,5,3)
               when '001' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
               when '002' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
               when '003' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
               when '004' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '004') as fis_jahrper_conv)
               when '005' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '004') as fis_jahrper_conv)
               when '006' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '004') as fis_jahrper_conv)
               when '007' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '007') as fis_jahrper_conv)
               when '008' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '007') as fis_jahrper_conv)
               when '009' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '007') as fis_jahrper_conv)
               when '010' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '010') as fis_jahrper_conv)
               when '011' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '010') as fis_jahrper_conv)
               when '012' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '010') as fis_jahrper_conv)
          end                                                                            as PREV_YR_SAME_QTR_FROM_PER,

      case substring(A.fiscal_year_period,5,3)
               when '001' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '002' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '003' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '004' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '005' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '006' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '007' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
               when '008' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
               when '009' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
               when '010' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '012') as fis_jahrper_conv)
               when '011' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '012') as fis_jahrper_conv)
               when '012' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '012') as fis_jahrper_conv)
          end                                                                            as PREV_YR_SAME_QTR_TO_PER,

      case substring(A.fiscal_year_period,5,3)
               when '001' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '010') as fis_jahrper_conv)
               when '002' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '010') as fis_jahrper_conv)
               when '003' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '010') as fis_jahrper_conv)
               when '004' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
               when '005' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
               when '006' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '001') as fis_jahrper_conv)
               when '007' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '008' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '009' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '010' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '011' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '012' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
          end                                                                            as PREV_YR_PREV_QTR_FROM_PER,

      case substring(A.fiscal_year_period,5,3)
               when '001' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '012') as fis_jahrper_conv)
               when '002' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '012') as fis_jahrper_conv)
               when '003' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)), '012') as fis_jahrper_conv)
               when '004' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '005' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '006' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '003') as fis_jahrper_conv)
               when '007' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '008' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '009' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '006') as fis_jahrper_conv)
               when '010' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
               when '011' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
               when '012' then cast(concat(cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 1) as abap.char(11)), '009') as fis_jahrper_conv)
          end                                                                            as PREV_YR_PREV_QTR_TO_PER,

      cast(concat(
      cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)),
      '001' ) as fis_jahrper_conv)                                                       as PREV_YR2_JAN_FROM,

      cast(concat(
      cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)),
      '012' ) as fis_jahrper_conv)                                                       as PREV_YR2_DEC_TO,

      cast(concat(
      cast((cast(cast(substring(A.fiscal_year_period,1,4) as abap.numc(4)) as abap.int2) - 2) as abap.char(11)),
      substring(A.fiscal_year_period,5,3) ) as fis_jahrper_conv)                         as PREV_YR2_SAME_PER
}
where
      A.fiscal_year_variant      =  :P_VARNT
  and A.fiscal_period_start_date <= :P_DATE
  and A.fiscal_period_end_date   >= :P_DATE
