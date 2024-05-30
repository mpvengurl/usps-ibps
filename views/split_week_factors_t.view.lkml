view: split_week_factors_t {
  sql_table_name: `ibps.split_week_factors_t` ;;

  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: split_week_factor {
    type: string
    sql: ${TABLE}.split_week_factor ;;
  }
  dimension: split_week_number {
    type: string
    sql: ${TABLE}.split_week_number ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
  }
}
