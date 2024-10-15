
view: pricing_plan_paul {
  derived_table: {
    sql: with pricingPlan as (
          select pp.function_code, pp.pricing_group_number, pp.hour_type_code, pp.employee_category_code, pp.pricing_mix_percentage, pp.accounting_period, min(cal.calendar_day) first_day_of_accounting_period, AVG(pp.pricing_rate) as composite_pricing_rate
          FROM  `ibps.pricing_plan_t` pp
          left join `ibps.calendar_t` cal on pp.accounting_period = cal.accounting_period
          where pricing_group_number is not null
          GROUP BY 1, 2, 3, 4, 5, 6
      )
      select whp.function_code, cal.accounting_period
            , whp.plan_hours as plan_hours
            , pricingPlan.employee_category_code
            , pricingPlan.pricing_mix_percentage
            , pricingPlan.composite_pricing_rate
            , composite_pricing_rate * plan_hours as dollars
            , pricingPlan.first_day_of_accounting_period
            , fNo.area_region_code , fNo.area_region_name , fNo.cost_ascertaining_group , fNo.district_division_code , fNo.district_division_name
            , fNo.finance_number_name, fNo.finance_number_type , fNo.function_distribution_code , fNo.function_distribution_name , fNo.hierarchy_id lead_finance_number
            , fNo.lead_finance_number_name , fNo.pricing_group_number , fNo.reporting_group_code
            , fn.function_name
            from `ibps.work_hour_plan_t` whp
              left join `ibps.finance_number_t` fNo on whp.finance_number = fNo.finance_number
              left join `ibps.calendar_t` cal on whp.split_week_number = cal.split_week_number
              left join pricingPlan on (fNo.pricing_group_number = pricingPlan.pricing_group_number AND whp.function_code = pricingPlan.function_code)
              left join `ibps.function_t` fn on pricingPlan.function_code = fn.function_code
              WHERE fn.function_name is not null
              AND pricingPlan.accounting_period = cal.accounting_period
              ;;
  # datagroup_trigger:usps_ibps_default_datagroup
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }

  dimension: accounting_period {
    type: string
    sql: ${TABLE}.accounting_period ;;
  }

  dimension: plan_hours {
    type: number
    sql: ${TABLE}.plan_hours ;;
  }

  dimension: employee_category_code {
    type: string
    sql: ${TABLE}.employee_category_code ;;
  }

  dimension: pricing_mix_percentage {
    type: number
    sql: ${TABLE}.pricing_mix_percentage ;;
  }

  dimension: composite_pricing_rate {
    type: number
    sql: ${TABLE}.composite_pricing_rate ;;
  }

  dimension: dollars {
    type: number
    sql: ${TABLE}.dollars ;;
  }

  dimension_group: first_day_of_accounting_period {
    type: time
    sql: ${TABLE}.first_day_of_accounting_period ;;
  }

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }

  dimension: area_region_name {
    type: string
    sql: ${TABLE}.area_region_name ;;
  }

  dimension: cost_ascertaining_group {
    type: string
    sql: ${TABLE}.cost_ascertaining_group ;;
  }

  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }

  dimension: district_division_name {
    type: string
    sql: ${TABLE}.district_division_name ;;
  }

  dimension: finance_number_name {
    type: string
    sql: ${TABLE}.finance_number_name ;;
  }

  dimension: finance_number_type {
    type: string
    sql: ${TABLE}.finance_number_type ;;
  }

  dimension: function_distribution_code {
    type: string
    sql: ${TABLE}.function_distribution_code ;;
  }

  dimension: function_distribution_name {
    type: string
    sql: ${TABLE}.function_distribution_name ;;
  }

  dimension: lead_finance_number {
    type: string
    sql: ${TABLE}.lead_finance_number ;;
  }

  dimension: lead_finance_number_name {
    type: string
    sql: ${TABLE}.lead_finance_number_name ;;
  }

  dimension: pricing_group_number {
    type: string
    sql: ${TABLE}.pricing_group_number ;;
  }

  dimension: reporting_group_code {
    type: string
    sql: ${TABLE}.reporting_group_code ;;
  }

  dimension: function_name {
    type: string
    sql: ${TABLE}.function_name ;;
  }
measure: sum_of_dollars {
  type: sum
  sql: ${TABLE}.dollars / 1000000;;
  value_format: "$ 0.000,,\" M\""
}

  measure: sum_of_planhours {
    type: sum
    sql: ${TABLE}.plan_hours / 10000;;
    value_format: "0.000,,\" M\""
  }

  set: detail {
    fields: [
        function_code,
  accounting_period,
  plan_hours,
  employee_category_code,
  pricing_mix_percentage,
  composite_pricing_rate,
  dollars,
  first_day_of_accounting_period_time,
  area_region_code,
  area_region_name,
  cost_ascertaining_group,
  district_division_code,
  district_division_name,
  finance_number_name,
  finance_number_type,
  function_distribution_code,
  function_distribution_name,
  lead_finance_number,
  lead_finance_number_name,
  pricing_group_number,
  reporting_group_code,
  function_name
    ]
  }
}
