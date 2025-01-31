view: work_load_indicator_plan_t {
  sql_table_name: `ibps.work_load_indicator_plan_t` ;;

  dimension: Primary_key {
    type: string
    primary_key: yes
    sql: ${TABLE}.fiscal_year || ${TABLE}.finance_number ||${TABLE}.function_code ;;
  }


  dimension: budget_week {
    type: string
    sql: ${TABLE}.budget_week ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: finance_number {
    type: string
    sql: ${TABLE}.finance_number ;;
  }
  dimension: fiscal_year {
    type: string
    sql:${TABLE}.fiscal_year;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: plan_wlis {
    type: number
    sql: ${TABLE}.plan_wlis ;;
  }
  dimension: split_week_number {
    type: string
    sql: ${TABLE}.split_week_number ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  dimension: work_load_indicator_code {
    type: string
    sql: ${TABLE}.work_load_indicator_code ;;
  }
  measure: Activity_measure {
    type: sum
    sql: ${TABLE}.plan_wlis ;;
  }
}
