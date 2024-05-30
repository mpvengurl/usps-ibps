view: area_region_t {
  sql_table_name: `ibps.area_region_t` ;;

  dimension: area_region_code {
    type: string
    sql: ${TABLE}.area_region_code ;;
  }
  dimension: area_region_name {
    type: string
    sql: ${TABLE}.area_region_name ;;
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
    drill_fields: [area_region_name]
  }
}
