connection: "ibps"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: budget_default_datagroup {
  # sql_trigger: SELECT MAX(last_update_date_time) FROM `ibps.pricing_plan_t`;;
  max_cache_age: "1 hour"
}

persist_with: budget_default_datagroup
explore: revenue_details {}

named_value_format: usd_in_millions {
  value_format: "0.000,,\" M\""
  strict_value_format: yes
}

explore: expenses {
  from: d_expenses_salaries
}

# explore: Expenses {
#   label: "Finance Details"
#   fields: [
#     Expenses.finance_number,
#     Expenses.finance_number_name,
#     line_number_plan_t.Totalexpense,
#     Expenses.area_region_code,
#     Expenses.area_region_name,
#     Expenses.district_division_code,
#     Expenses.district_division_name,
#     Expenses.fiscal_year,
#     line_number_plan_t.line_number_code,

#     derived_salaries_benefits.function_code,
#     derived_salaries_benefits.line,
#     # function_t.function_name,
#     line_number_plan_t.fiscal_year_month,
#     line_number_t.line_number_name,
#     derived_salaries_benefits.fiscal_year_month,
#     derived_salaries_benefits.Salary_benefit_expense
#     # work_load_indicator_plan_t.work_load_indicator_code,
#     # work_load_indicator_plan_t.function_code,
#     # work_load_indicator_plan_t.Activity_measure,
#     # work_load_indicator_plan_t.split_week_number,
#     # work_load_indicator_t.work_load_indicator_name
#   ]
#   from: finance_number_t
#   view_label: "Finance Number"
#   join: line_number_plan_t{
#     view_label: "Line_number_plan_t"
#     type: inner
#     sql_on: ${Expenses.finance_number}=${line_number_plan_t.finance_number} and ${Expenses.fiscal_year}=${line_number_plan_t.fiscal_year} ;;
#     relationship: one_to_many
#   }
#   join: line_number_t
#   {
#     type: inner
#     sql_on: ${line_number_plan_t.line_number_code}=${line_number_t.line_number_code} and ${line_number_plan_t.fiscal_year}=${line_number_t.fiscal_year} ;;
#     relationship: many_to_one
#   }
#   join: derived_salaries_benefits{
#     view_label: "Salaries and Benefit "
#     type: inner
#     sql_on: ${Expenses.finance_number}=${derived_salaries_benefits.finance_number} and ${Expenses.fiscal_year}=${derived_salaries_benefits.fiscal_year} ;;
#     relationship: one_to_many
#   }
#   join: function_t{
#     type: inner
#     sql_on: ${derived_salaries_benefits.function_code}=${function_t.function_code} and ${derived_salaries_benefits.fiscal_year}=${function_t.fiscal_year} ;;
#     relationship: many_to_one
#   }
  # join: work_load_indicator_plan_t{
  #   view_label: "WLIs"
  #   type: left_outer
  #   sql_on: ${Expenses.finance_number}=${work_load_indicator_plan_t.finance_number} and ${Expenses.fiscal_year}=${work_load_indicator_plan_t.fiscal_year} ;;
  #   relationship: one_to_many
  # }
  # join: work_load_indicator_t{
  #   type: left_outer
  #   sql_on: ${work_load_indicator_plan_t.work_load_indicator_code}=${work_load_indicator_t.work_load_indicator_code} and ${work_load_indicator_plan_t.fiscal_year}=${work_load_indicator_t.fiscal_year} ;;
  #   relationship: many_to_one
  # }



explore: derived_salaries_benefits {}

explore: Work_Plan_Activities{
  from: work_load_indicator_plan_t
  join: work_load_indicator_t{
    type: left_outer
    sql_on: ${Work_Plan_Activities.work_load_indicator_code}=${work_load_indicator_t.work_load_indicator_code} and ${Work_Plan_Activities.fiscal_year}=${work_load_indicator_t.fiscal_year} ;;
    relationship: many_to_one
  }
  ##Make a native derived table
  # join: derived_calendar_t {
  #   sql_on: ${calendar_t.split_week_number}=${Work_Plan_Activities.split_week_number} and ${calendar_t.fiscal_year}=${Work_Plan_Activities.fiscal_year};;
  #   relationship: many_to_one
  # }
}


explore: work_hour_plan_t {
  label: "Work Plan"
  join: calendar_t {
    type: left_outer
    relationship: many_to_one
    sql_on: ${calendar_t.split_week_number}=${work_hour_plan_t.split_week_number};;
  }
  join: labor_distribution_t {
    type: left_outer
    sql_on: ${work_hour_plan_t.labor_distribution_code}=${labor_distribution_t.labor_distribution_code};;
    relationship:many_to_one
  }
  join: finance_number_t {
    type: left_outer
    sql_on: ${work_hour_plan_t.finance_number}=${finance_number_t.finance_number};;
    relationship:many_to_one
  }
  join: function_t {
    type: left_outer
    sql_on: ${work_hour_plan_t.function_code}=${function_t.function_code};;
    relationship:many_to_one
  }
}

explore: function_t {}
explore: bopr_paul {
  label: "Budget Data Model"
}

explore: work_plan_paul {}

explore: pricing_plan_paul {}

# explore: employee_category_t {}

# explore: calendar_t {}

# explore: budget_approved_t {}

# explore: area_region_month_status_t {}

# explore: budget_transmittal_letter_t {
#     join: budget_transmittal_letter_t__area_region_code {
#       view_label: "Budget Transmittal Letter T: Area Region Code"
#       sql: LEFT JOIN UNNEST(${budget_transmittal_letter_t.area_region_code}) as budget_transmittal_letter_t__area_region_code ;;
#       relationship: one_to_many
#     }
# }

# explore: district_division_t {}

# explore: announcement_t {}

# explore: area_region_t {}

# explore: fiscal_year_t {}

# explore: finance_number_t {}

# explore: finance_number_org_updates_t {}

# explore: hq_line_number_plan_t {}

# explore: fncm_finance_number_t {}

# explore: function_t {}

# explore: hq_line_number_plan_t_error_records {
#     join: hq_line_number_plan_t_error_records__attributes {
#       view_label: "Hq Line Number Plan T Error Records: Attributes"
#       sql: LEFT JOIN UNNEST(${hq_line_number_plan_t_error_records.attributes}) as hq_line_number_plan_t_error_records__attributes ;;
#       relationship: one_to_many
#     }
# }

# explore: hq_revenue_plan_t_error_records {
#     join: hq_revenue_plan_t_error_records__attributes {
#       view_label: "Hq Revenue Plan T Error Records: Attributes"
#       sql: LEFT JOIN UNNEST(${hq_revenue_plan_t_error_records.attributes}) as hq_revenue_plan_t_error_records__attributes ;;
#       relationship: one_to_many
#     }
# }

# explore: hq_revenue_plan_t {}

# explore: hq_work_hour_plan_t_error_records {
#     join: hq_work_hour_plan_t_error_records__attributes {
#       view_label: "Hq Work Hour Plan T Error Records: Attributes"
#       sql: LEFT JOIN UNNEST(${hq_work_hour_plan_t_error_records.attributes}) as hq_work_hour_plan_t_error_records__attributes ;;
#       relationship: one_to_many
#     }
# }

# explore: hq_work_hour_plan_t {}

# explore: ibpsplan_jnbs_t {}

# explore: labor_distribution_t {}

# explore: line_number_plan_t {}

# explore: line_number_group_t {}

# explore: nonvalid_combination_t {}

# explore: pricing_group_t_org_updates_t {}

explore: line_number_t {}

explore: pricing_group_t {}

explore: hour_type_t {}

explore: pricing_plan_t {}

explore: revenue_group_t {}

explore: revenue_plan_t {}

explore: role_t {}

explore: revenue_sub_line_number_t {}

explore: split_week_factors_t {}

explore: spread_line_number_plan_name_t {}

explore: spread_line_number_plan_t {}

explore: spread_work_hour_plan_name_t {}

explore: spread_line_number_plan_top_ten_t {}

explore: spread_work_hour_plan_t {}

explore: spread_work_load_indicator_plan_name_t {}

explore: spread_work_load_indicator_plan_top_ten_t {}

explore: spread_work_hour_plan_top_ten_t {}

explore: spread_work_load_indicator_plan_t {}

explore: system_lock_pricing_plan_t {
    join: system_lock_pricing_plan_t__function_code {
      view_label: "System Lock Pricing Plan T: Function Code"
      sql: LEFT JOIN UNNEST(${system_lock_pricing_plan_t.function_code}) as system_lock_pricing_plan_t__function_code ;;
      relationship: one_to_many
    }
    join: system_lock_pricing_plan_t__hour_type_code {
      view_label: "System Lock Pricing Plan T: Hour Type Code"
      sql: LEFT JOIN UNNEST(${system_lock_pricing_plan_t.hour_type_code}) as system_lock_pricing_plan_t__hour_type_code ;;
      relationship: one_to_many
    }
    join: system_lock_pricing_plan_t__area_region_code {
      view_label: "System Lock Pricing Plan T: Area Region Code"
      sql: LEFT JOIN UNNEST(${system_lock_pricing_plan_t.area_region_code}) as system_lock_pricing_plan_t__area_region_code ;;
      relationship: one_to_many
    }
    join: system_lock_pricing_plan_t__accounting_period {
      view_label: "System Lock Pricing Plan T: Accounting Period"
      sql: LEFT JOIN UNNEST(${system_lock_pricing_plan_t.accounting_period}) as system_lock_pricing_plan_t__accounting_period ;;
      relationship: one_to_many
    }
    join: system_lock_pricing_plan_t__pricing_group_number {
      view_label: "System Lock Pricing Plan T: Pricing Group Number"
      sql: LEFT JOIN UNNEST(${system_lock_pricing_plan_t.pricing_group_number}) as system_lock_pricing_plan_t__pricing_group_number ;;
      relationship: one_to_many
    }
    join: system_lock_pricing_plan_t__district_division_code {
      view_label: "System Lock Pricing Plan T: District Division Code"
      sql: LEFT JOIN UNNEST(${system_lock_pricing_plan_t.district_division_code}) as system_lock_pricing_plan_t__district_division_code ;;
      relationship: one_to_many
    }
    join: system_lock_pricing_plan_t__employee_category_code {
      view_label: "System Lock Pricing Plan T: Employee Category Code"
      sql: LEFT JOIN UNNEST(${system_lock_pricing_plan_t.employee_category_code}) as system_lock_pricing_plan_t__employee_category_code ;;
      relationship: one_to_many
    }
}

explore: system_lock_revenue_plan_t {
    join: system_lock_revenue_plan_t__month {
      view_label: "System Lock Revenue Plan T: Month"
      sql: LEFT JOIN UNNEST(${system_lock_revenue_plan_t.month}) as system_lock_revenue_plan_t__month ;;
      relationship: one_to_many
    }
    join: system_lock_revenue_plan_t__finance_number {
      view_label: "System Lock Revenue Plan T: Finance Number"
      sql: LEFT JOIN UNNEST(${system_lock_revenue_plan_t.finance_number}) as system_lock_revenue_plan_t__finance_number ;;
      relationship: one_to_many
    }
    join: system_lock_revenue_plan_t__area_region_code {
      view_label: "System Lock Revenue Plan T: Area Region Code"
      sql: LEFT JOIN UNNEST(${system_lock_revenue_plan_t.area_region_code}) as system_lock_revenue_plan_t__area_region_code ;;
      relationship: one_to_many
    }
    join: system_lock_revenue_plan_t__revenue_group_code {
      view_label: "System Lock Revenue Plan T: Revenue Group Code"
      sql: LEFT JOIN UNNEST(${system_lock_revenue_plan_t.revenue_group_code}) as system_lock_revenue_plan_t__revenue_group_code ;;
      relationship: one_to_many
    }
    join: system_lock_revenue_plan_t__district_division_code {
      view_label: "System Lock Revenue Plan T: District Division Code"
      sql: LEFT JOIN UNNEST(${system_lock_revenue_plan_t.district_division_code}) as system_lock_revenue_plan_t__district_division_code ;;
      relationship: one_to_many
    }
    join: system_lock_revenue_plan_t__function_distribution_code {
      view_label: "System Lock Revenue Plan T: Function Distribution Code"
      sql: LEFT JOIN UNNEST(${system_lock_revenue_plan_t.function_distribution_code}) as system_lock_revenue_plan_t__function_distribution_code ;;
      relationship: one_to_many
    }
    join: system_lock_revenue_plan_t__revenue_sub_line_number_code {
      view_label: "System Lock Revenue Plan T: Revenue Sub Line Number Code"
      sql: LEFT JOIN UNNEST(${system_lock_revenue_plan_t.revenue_sub_line_number_code}) as system_lock_revenue_plan_t__revenue_sub_line_number_code ;;
      relationship: one_to_many
    }
}

explore: system_lock_line_number_plan_t {
    join: system_lock_line_number_plan_t__month {
      view_label: "System Lock Line Number Plan T: Month"
      sql: LEFT JOIN UNNEST(${system_lock_line_number_plan_t.month}) as system_lock_line_number_plan_t__month ;;
      relationship: one_to_many
    }
    join: system_lock_line_number_plan_t__finance_number {
      view_label: "System Lock Line Number Plan T: Finance Number"
      sql: LEFT JOIN UNNEST(${system_lock_line_number_plan_t.finance_number}) as system_lock_line_number_plan_t__finance_number ;;
      relationship: one_to_many
    }
    join: system_lock_line_number_plan_t__area_region_code {
      view_label: "System Lock Line Number Plan T: Area Region Code"
      sql: LEFT JOIN UNNEST(${system_lock_line_number_plan_t.area_region_code}) as system_lock_line_number_plan_t__area_region_code ;;
      relationship: one_to_many
    }
    join: system_lock_line_number_plan_t__line_number_code {
      view_label: "System Lock Line Number Plan T: Line Number Code"
      sql: LEFT JOIN UNNEST(${system_lock_line_number_plan_t.line_number_code}) as system_lock_line_number_plan_t__line_number_code ;;
      relationship: one_to_many
    }
    join: system_lock_line_number_plan_t__line_number_group_code {
      view_label: "System Lock Line Number Plan T: Line Number Group Code"
      sql: LEFT JOIN UNNEST(${system_lock_line_number_plan_t.line_number_group_code}) as system_lock_line_number_plan_t__line_number_group_code ;;
      relationship: one_to_many
    }
    join: system_lock_line_number_plan_t__district_division_code {
      view_label: "System Lock Line Number Plan T: District Division Code"
      sql: LEFT JOIN UNNEST(${system_lock_line_number_plan_t.district_division_code}) as system_lock_line_number_plan_t__district_division_code ;;
      relationship: one_to_many
    }
    join: system_lock_line_number_plan_t__function_distribution_code {
      view_label: "System Lock Line Number Plan T: Function Distribution Code"
      sql: LEFT JOIN UNNEST(${system_lock_line_number_plan_t.function_distribution_code}) as system_lock_line_number_plan_t__function_distribution_code ;;
      relationship: one_to_many
    }
}

explore: system_lock_work_load_indicator_plan_t {
    join: system_lock_work_load_indicator_plan_t__week_number {
      view_label: "System Lock Work Load Indicator Plan T: Week Number"
      sql: LEFT JOIN UNNEST(${system_lock_work_load_indicator_plan_t.week_number}) as system_lock_work_load_indicator_plan_t__week_number ;;
      relationship: one_to_many
    }
    join: system_lock_work_load_indicator_plan_t__function_code {
      view_label: "System Lock Work Load Indicator Plan T: Function Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_load_indicator_plan_t.function_code}) as system_lock_work_load_indicator_plan_t__function_code ;;
      relationship: one_to_many
    }
    join: system_lock_work_load_indicator_plan_t__finance_number {
      view_label: "System Lock Work Load Indicator Plan T: Finance Number"
      sql: LEFT JOIN UNNEST(${system_lock_work_load_indicator_plan_t.finance_number}) as system_lock_work_load_indicator_plan_t__finance_number ;;
      relationship: one_to_many
    }
    join: system_lock_work_load_indicator_plan_t__area_region_code {
      view_label: "System Lock Work Load Indicator Plan T: Area Region Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_load_indicator_plan_t.area_region_code}) as system_lock_work_load_indicator_plan_t__area_region_code ;;
      relationship: one_to_many
    }
    join: system_lock_work_load_indicator_plan_t__district_division_code {
      view_label: "System Lock Work Load Indicator Plan T: District Division Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_load_indicator_plan_t.district_division_code}) as system_lock_work_load_indicator_plan_t__district_division_code ;;
      relationship: one_to_many
    }
    join: system_lock_work_load_indicator_plan_t__work_load_indicator_code {
      view_label: "System Lock Work Load Indicator Plan T: Work Load Indicator Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_load_indicator_plan_t.work_load_indicator_code}) as system_lock_work_load_indicator_plan_t__work_load_indicator_code ;;
      relationship: one_to_many
    }
}

explore: user_settings_t {}

# explore: work_hour_plan_t {}

explore: system_lock_work_hour_plan_t {
    join: system_lock_work_hour_plan_t__week_number {
      view_label: "System Lock Work Hour Plan T: Week Number"
      sql: LEFT JOIN UNNEST(${system_lock_work_hour_plan_t.week_number}) as system_lock_work_hour_plan_t__week_number ;;
      relationship: one_to_many
    }
    join: system_lock_work_hour_plan_t__function_code {
      view_label: "System Lock Work Hour Plan T: Function Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_hour_plan_t.function_code}) as system_lock_work_hour_plan_t__function_code ;;
      relationship: one_to_many
    }
    join: system_lock_work_hour_plan_t__finance_number {
      view_label: "System Lock Work Hour Plan T: Finance Number"
      sql: LEFT JOIN UNNEST(${system_lock_work_hour_plan_t.finance_number}) as system_lock_work_hour_plan_t__finance_number ;;
      relationship: one_to_many
    }
    join: system_lock_work_hour_plan_t__area_region_code {
      view_label: "System Lock Work Hour Plan T: Area Region Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_hour_plan_t.area_region_code}) as system_lock_work_hour_plan_t__area_region_code ;;
      relationship: one_to_many
    }
    join: system_lock_work_hour_plan_t__district_division_code {
      view_label: "System Lock Work Hour Plan T: District Division Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_hour_plan_t.district_division_code}) as system_lock_work_hour_plan_t__district_division_code ;;
      relationship: one_to_many
    }
    join: system_lock_work_hour_plan_t__labor_distribution_code {
      view_label: "System Lock Work Hour Plan T: Labor Distribution Code"
      sql: LEFT JOIN UNNEST(${system_lock_work_hour_plan_t.labor_distribution_code}) as system_lock_work_hour_plan_t__labor_distribution_code ;;
      relationship: one_to_many
    }
}

explore: work_load_indicator_plan_t {}

explore: work_load_indicator_t {}

explore: user_t {}

# explore: custom_split_week_hour_plan_t {
#  join:  work_hours_plan_t{
#    view_label: "Join split_week_factors_t.fiscal_year to work_hours_plan_t.fiscal_year"
#    sql_on: ${split_week_factors_t.fiscal_year} = ${work_hours_plan_t.fiscal_year} ;;
#  }
#  join: custom_join_split_week_number {
#    view_label: "Join split_week_factors_t.split_week_number to work_hours_plan_t. split_week_number"
#    sql_on: $(split_week_factors_t.split_week_number} = ${work_hours_plan_t.split_week_number} ;;
#  }
#  join: custom_join_budget_week {
#    view_label: "Join calendar_t.budget_week to work_hour_plan_t.budget_week"
#    sql_on: ${calendar_t.budget_week} = ${work_hour_plan_t.budget_week} ;;
#  }
#}

# Custom Code for pricing
explore: pricing_plan_join_t {
# Custom code - mpv - pricing_plan_t
  join: function_t {
    type: left_outer
    relationship: many_to_one
    sql_on: ${pricing_plan_join_t.function_code} = ${function_t.function_code};;
  }
  join: hour_type_t {
    type: left_outer
    relationship:  many_to_one
    sql_on: ${hour_type_t.fiscal_year} = ${pricing_plan_join_t.fiscal_year}  AND ${hour_type_t.hour_type_code} = ${pricing_plan_join_t.hour_type_code} ;;
  }
# Custom code completed - pricing_plan_t
}

explore: finance_number_join_t {
# Custom code - mpv - finance_number_t
  join: work_hour_plan_t {
    type: left_outer
    relationship: many_to_one
    sql_on: ${finance_number_join_t.fiscal_year} = ${work_hour_plan_t.fiscal_year} AND ${finance_number_join_t.finance_number} = ${work_hour_plan_t.finance_number};;
  }
  join: split_week_factors_t {
    type: left_outer
    relationship:  many_to_one
    sql_on: ${work_hour_plan_t.fiscal_year} = ${split_week_factors_t.fiscal_year}  AND ${work_hour_plan_t.split_week_number} = ${split_week_factors_t.split_week_number};;
  }
  # Custom code completed - finance_number_t
}
