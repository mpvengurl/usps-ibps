view: revenue_group_t {
  sql_table_name: `ibps.revenue_group_t` ;;

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
  dimension: revenue_group_code {
    type: string
    sql: ${TABLE}.revenue_group_code ;;
  }
  dimension: revenue_group_name {
    type: string
    sql: ${TABLE}.revenue_group_name ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [revenue_group_name]
  }
}
