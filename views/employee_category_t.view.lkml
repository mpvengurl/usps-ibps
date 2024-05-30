view: employee_category_t {
  sql_table_name: `ibps.employee_category_t` ;;

  dimension: __employee_category_code {
    type: string
    sql: ${TABLE}.`  employee_category_code` ;;
  }
  dimension: _employee_category_name {
    type: string
    sql: ${TABLE}.` employee_category_name` ;;
  }
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
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [_employee_category_name]
  }
}
