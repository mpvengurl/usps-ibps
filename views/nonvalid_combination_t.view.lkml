view: nonvalid_combination_t {
  sql_table_name: `ibps.nonvalid_combination_t` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: employee_category_code {
    type: string
    sql: ${TABLE}.employee_category_code ;;
  }
  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }
  dimension: function_code {
    type: string
    sql: ${TABLE}.function_code ;;
  }
  dimension: hour_type_code {
    type: string
    sql: ${TABLE}.hour_type_code ;;
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
    drill_fields: [id]
  }
}
