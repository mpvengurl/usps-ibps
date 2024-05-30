view: fiscal_year_t {
  sql_table_name: `ibps.fiscal_year_t` ;;

  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: fiscal_year_name {
    type: string
    sql: ${TABLE}.fiscal_year_name ;;
  }
  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
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
    drill_fields: [fiscal_year_name]
  }
}
