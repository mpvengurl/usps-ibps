view: work_hour_plan_t {
  sql_table_name: `ibps.work_hour_plan_t` ;;

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
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: plan_hours {
    type: number
    sql: ${TABLE}.plan_hours ;;
  }
  dimension: split_week_number {
    type: string
    sql: ${TABLE}.split_week_number ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: total_plan_hours {
    type: sum
    sql: ${TABLE}.plan_hours ;;
    drill_fields: [function_code,labor_distribution_code,total_plan_hours]
  }
}
