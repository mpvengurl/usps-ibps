view: labor_distribution_t {
  sql_table_name: `ibps.labor_distribution_t` ;;

  dimension_group: create_date_time_x {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time_x ;;
  }
  dimension_group: create_date_time_y {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time_y ;;
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
  dimension: hour_type_name {
    type: string
    sql: ${TABLE}.hour_type_name ;;
  }
  dimension: labor_distribution_code {
    type: string
    sql: ${TABLE}.labor_distribution_code ;;
  }
  dimension: labor_distribution_name {
    type: string
    sql: ${TABLE}.labor_distribution_name ;;
  }
  dimension_group: last_update_date_time_x {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time_x ;;
  }
  dimension_group: last_update_date_time_y {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time_y ;;
  }
  dimension: user_modified_x {
    type: string
    sql: ${TABLE}.user_modified_x ;;
  }
  dimension: user_modified_y {
    type: string
    sql: ${TABLE}.user_modified_y ;;
  }
  measure: count {
    type: count
    drill_fields: [hour_type_name, labor_distribution_name]
  }
}
