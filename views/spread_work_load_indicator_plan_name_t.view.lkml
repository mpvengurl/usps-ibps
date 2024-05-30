view: spread_work_load_indicator_plan_name_t {
  sql_table_name: `ibps.spread_work_load_indicator_plan_name_t` ;;

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: created_by {
    type: string
    sql: ${TABLE}.created_by ;;
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
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [spread_name]
  }
}
