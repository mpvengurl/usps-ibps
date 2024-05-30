view: hour_type_t {
  sql_table_name: `ibps.hour_type_t` ;;

  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: hour_type_code {
    type: string
    sql: ${TABLE}.hour_type_code ;;
  }
  dimension: hour_type_name {
    type: string
    sql: ${TABLE}.hour_type_name ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [hour_type_name]
  }
}
