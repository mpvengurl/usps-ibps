view: revenue_plan_t {
  sql_table_name: `ibps.revenue_plan_t` ;;

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
  dimension: fiscal_year_month {
    type: string
    sql: ${TABLE}.fiscal_year_month ;;
  }
  dimension: function_distribution_code {
    type: string
    sql: ${TABLE}.function_distribution_code ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: plan_dollars {
    type: number
    sql: ${TABLE}.plan_dollars ;;
  }
  dimension: revenue_group_code {
    type: string
    sql: ${TABLE}.revenue_group_code ;;
  }
  dimension: revenue_sub_line_number_code {
    type: string
    sql: ${TABLE}.revenue_sub_line_number_code ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
  }
}
