view: user_settings_t {
  sql_table_name: `ibps.user_settings_t` ;;

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
  dimension: district_division_code {
    type: string
    sql: ${TABLE}.district_division_code ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: last_updated_by {
    type: string
    sql: ${TABLE}.last_updated_by ;;
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
  dimension_group: user_last_login {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.user_last_login ;;
  }
  dimension: user_name {
    type: string
    sql: ${TABLE}.user_name ;;
  }
  dimension: user_role {
    type: string
    sql: ${TABLE}.user_role ;;
  }
  measure: count {
    type: count
    drill_fields: [user_name]
  }
}
