view: system_lock_work_hour_plan_t {
  sql_table_name: `ibps.system_lock_work_hour_plan_t` ;;

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
  dimension: finance_number {
    hidden: yes
    sql: ${TABLE}.finance_number ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: function_code {
    hidden: yes
    sql: ${TABLE}.function_code ;;
  }
  dimension: labor_distribution_code {
    hidden: yes
    sql: ${TABLE}.labor_distribution_code ;;
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
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  dimension: week_number {
    hidden: yes
    sql: ${TABLE}.week_number ;;
  }
  measure: count {
    type: count
  }
}

view: system_lock_work_hour_plan_t__week_number {

  dimension: system_lock_work_hour_plan_t__week_number {
    type: string
    sql: system_lock_work_hour_plan_t__week_number ;;
  }
}

view: system_lock_work_hour_plan_t__function_code {

  dimension: system_lock_work_hour_plan_t__function_code {
    type: string
    sql: system_lock_work_hour_plan_t__function_code ;;
  }
}

view: system_lock_work_hour_plan_t__finance_number {

  dimension: system_lock_work_hour_plan_t__finance_number {
    type: string
    sql: system_lock_work_hour_plan_t__finance_number ;;
  }
}

view: system_lock_work_hour_plan_t__area_region_code {

  dimension: system_lock_work_hour_plan_t__area_region_code {
    type: string
    sql: system_lock_work_hour_plan_t__area_region_code ;;
  }
}

view: system_lock_work_hour_plan_t__district_division_code {

  dimension: system_lock_work_hour_plan_t__district_division_code {
    type: string
    sql: system_lock_work_hour_plan_t__district_division_code ;;
  }
}

view: system_lock_work_hour_plan_t__labor_distribution_code {

  dimension: system_lock_work_hour_plan_t__labor_distribution_code {
    type: string
    sql: system_lock_work_hour_plan_t__labor_distribution_code ;;
  }
}
