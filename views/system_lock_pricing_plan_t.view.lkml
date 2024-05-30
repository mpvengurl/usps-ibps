view: system_lock_pricing_plan_t {
  sql_table_name: `ibps.system_lock_pricing_plan_t` ;;

  dimension: accounting_period {
    hidden: yes
    sql: ${TABLE}.accounting_period ;;
  }
  dimension: area_region_code {
    hidden: yes
    sql: ${TABLE}.area_region_code ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: district_division_code {
    hidden: yes
    sql: ${TABLE}.district_division_code ;;
  }
  dimension: employee_category_code {
    hidden: yes
    sql: ${TABLE}.employee_category_code ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: function_code {
    hidden: yes
    sql: ${TABLE}.function_code ;;
  }
  dimension: hour_type_code {
    hidden: yes
    sql: ${TABLE}.hour_type_code ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: lock_status {
    type: yesno
    sql: ${TABLE}.lock_status ;;
  }
  dimension: pricing_group_number {
    hidden: yes
    sql: ${TABLE}.pricing_group_number ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
  }
}

view: system_lock_pricing_plan_t__function_code {

  dimension: system_lock_pricing_plan_t__function_code {
    type: string
    sql: system_lock_pricing_plan_t__function_code ;;
  }
}

view: system_lock_pricing_plan_t__hour_type_code {

  dimension: system_lock_pricing_plan_t__hour_type_code {
    type: string
    sql: system_lock_pricing_plan_t__hour_type_code ;;
  }
}

view: system_lock_pricing_plan_t__area_region_code {

  dimension: system_lock_pricing_plan_t__area_region_code {
    type: string
    sql: system_lock_pricing_plan_t__area_region_code ;;
  }
}

view: system_lock_pricing_plan_t__accounting_period {

  dimension: system_lock_pricing_plan_t__accounting_period {
    type: string
    sql: system_lock_pricing_plan_t__accounting_period ;;
  }
}

view: system_lock_pricing_plan_t__pricing_group_number {

  dimension: system_lock_pricing_plan_t__pricing_group_number {
    type: string
    sql: system_lock_pricing_plan_t__pricing_group_number ;;
  }
}

view: system_lock_pricing_plan_t__district_division_code {

  dimension: system_lock_pricing_plan_t__district_division_code {
    type: string
    sql: system_lock_pricing_plan_t__district_division_code ;;
  }
}

view: system_lock_pricing_plan_t__employee_category_code {

  dimension: system_lock_pricing_plan_t__employee_category_code {
    type: string
    sql: system_lock_pricing_plan_t__employee_category_code ;;
  }
}
