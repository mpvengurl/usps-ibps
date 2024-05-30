view: spread_work_hour_plan_t {
  sql_table_name: `ibps.spread_work_hour_plan_t` ;;

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
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
  dimension: spread_name {
    type: string
    sql: ${TABLE}.spread_name ;;
  }
  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  dimension: week_number {
    type: string
    sql: ${TABLE}.week_number ;;
  }
  dimension: week_value {
    type: number
    sql: ${TABLE}.week_value ;;
  }
  measure: count {
    type: count
    drill_fields: [spread_name]
  }
}
