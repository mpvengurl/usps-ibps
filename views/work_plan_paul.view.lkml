
view: work_plan_paul {



  derived_table: {
    sql: with splitWeeks as (
        select distinct cal.accounting_period, cal.split_week_number, cal.fiscal_year_month, min(cal.calendar_day) as first_day_of_split_week from  `usps-demo-421820.ibps.calendar_t` cal
        group by 1, 2, 3
      )
      select
      plan.budget_week, plan.finance_number, plan.fiscal_year, plan.function_code, plan.labor_distribution_code, plan.plan_hours, plan.split_week_number
      , cal.accounting_period, cal.fiscal_year_month, cal.first_day_of_split_week
      , ldc.hour_type_code , ldc.hour_type_name , ldc.labor_distribution_name
      , fNo.area_region_code , fNo.area_region_name , fNo.cost_ascertaining_group , fNo.district_division_code , fNo.district_division_name
      , fNo.finance_number_name, fNo.finance_number_type , fNo.function_distribution_code , fNo.function_distribution_name , fNo.hierarchy_id lead_finance_number
      , fNo.lead_finance_number_name , fNo.pricing_group_number , fNo.reporting_group_code
      , function.function_name
      from `usps-demo-421820.ibps.work_hour_plan_t` plan
      left join splitWeeks cal on plan.split_week_number = cal.split_week_number
      left join `usps-demo-421820.ibps.labor_distribution_t` ldc on plan.labor_distribution_code = ldc.labor_distribution_code
      left join `usps-demo-421820.ibps.finance_number_t` fNo on plan.finance_number = fNO.finance_number
      left join `usps-demo-421820.ibps.function_t` function on ldc.function_code = function.function_code
      ;;
  # datagroup_trigger:usps_ibps_default_datagroup
  }

  measure: total_plan_hours {
    sql: ${plan_hours} ;;
    type: sum
    value_format: "0.0,,\" M\""
    drill_fields: [function_code, function_name, labor_distribution_code, labor_distribution_name, total_plan_hours ]
  }

  dimension: budget_week {
    type: string
    sql: ${TABLE}.budget_week ;;
  }

  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }

  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }

  dimension: labor_distribution_code {
    type: string
    sql: ${TABLE}.labor_distribution_code ;;
  }

  dimension: plan_hours {
    type: number
    sql: ${TABLE}.plan_hours ;;
  }

  dimension: split_week_number {
    type: string
    sql: ${TABLE}.split_week_number ;;
  }

  dimension: accounting_period {
    type: string
    sql: ${TABLE}.accounting_period ;;
  }


  dimension: fiscal_year_month {
    type: string
    sql: ${TABLE}.fiscal_year_month ;;
  }

  dimension_group: first_day_of_split_week {
    label: "Day of work hour"
    type: time
    sql: ${TABLE}.first_day_of_split_week ;;
  }


  dimension: hour_type_code {
    type: string
    sql: ${TABLE}.hour_type_code ;;
  }

  dimension: hour_type_name {
    type: string
    sql: ${TABLE}.hour_type_name ;;
  }


  dimension: labor_distribution_name {
    type: string
    sql: ${TABLE}.labor_distribution_name ;;
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


  set: detail {
    fields: [
        budget_week,
  finance_number,
  fiscal_year,
  function_code,
  labor_distribution_code,
  plan_hours,
  split_week_number,
  accounting_period,
  fiscal_year_month,
  first_day_of_split_week_time,
  hour_type_code,
  hour_type_name,
  labor_distribution_name,
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
