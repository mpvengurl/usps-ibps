view: finance_number_t {
  sql_table_name: `ibps.finance_number_t` ;;

  dimension: Primary_key {
    type: string
    primary_key: yes
    sql: ${TABLE}.fiscal_year|| ${TABLE}.finance_number;;
  }

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }
  dimension: area_region_name {
    type: string
    sql: ${TABLE}.area_region_name ;;
  }
  # dimension: cost_ascertaining_group {
  #   type: string
  #   sql: ${TABLE}.cost_ascertaining_group ;;
  # }
  # dimension_group: create_date {
  #   type: time
  #   timeframes: [raw, time, date, week, month, quarter, year]
  #   sql: ${TABLE}.create_date_time ;;
  # }
  # dimension: customer_satisfaction_number_code {
  #   type: string
  #   sql: ${TABLE}.customer_satisfaction_number_code ;;
  # }
  # dimension: customer_satisfaction_number_name {
  #   type: string
  #   sql: ${TABLE}.customer_satisfaction_number_name ;;
  # }
  # dimension: customer_services_operations_manager_group {
  #   type: string
  #   sql: ${TABLE}.customer_services_operations_manager_group ;;
  # }
  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }
  dimension: district_division_name {
    type: string
    sql: ${TABLE}.district_division_name ;;
  }
  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }
  dimension: finance_number_name {
    label: "Finance Name"
    type: string
    sql: ${TABLE}.finance_number_name ;;
  }
  # dimension: finance_number_type {
  #   type: string
  #   sql: ${TABLE}.finance_number_type ;;
  # }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  # dimension: function_distribution_code {
  #   type: string
  #   sql: ${TABLE}.function_distribution_code ;;
  # }
  # dimension: function_distribution_name {
  #   type: string
  #   sql: ${TABLE}.function_distribution_name ;;
  # }
  # dimension: hierarchy_id {
  #   type: string
  #   sql: ${TABLE}.hierarchy_id ;;
  # }
  # dimension_group: last_update_date {
  #   type: time
  #   timeframes: [raw, time, date, week, month, quarter, year]
  #   sql: ${TABLE}.last_update_date_time ;;
  # }
  # dimension: lead_finance_number {
  #   type: string
  #   sql: ${TABLE}.lead_finance_number ;;
  # }
  # dimension: lead_finance_number_name {
  #   type: string
  #   sql: ${TABLE}.lead_finance_number_name ;;
  # }
  # dimension: manager_of_post_office_operations {
  #   type: string
  #   sql: ${TABLE}.manager_of_post_office_operations ;;
  # }
  # dimension: manager_of_post_office_operations_name {
  #   type: string
  #   sql: ${TABLE}.manager_of_post_office_operations_name ;;
  # }
  # dimension: office_lvl {
  #   type: string
  #   sql: ${TABLE}.office_lvl ;;
  # }
  # dimension: pricing_group_number {
  #   type: string
  #   sql: ${TABLE}.pricing_group_number ;;
  # }
  # dimension: reporting_group_code {
  #   type: string
  #   sql: ${TABLE}.reporting_group_code ;;
  # }
  # dimension: user_modified {
  #   type: string
  #   sql: ${TABLE}.user_modified ;;
  # }
  # measure: count {
  #   type: count
  #   drill_fields: [detail*]
  # }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  finance_number_name,
  # manager_of_post_office_operations_name,
  district_division_name,
  # lead_finance_number_name,
  # function_distribution_name,
  area_region_name,
  # customer_satisfaction_number_name
  ]
  }

}
