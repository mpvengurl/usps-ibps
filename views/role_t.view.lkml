view: role_t {
  sql_table_name: `ibps.role_t` ;;

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: role_id {
    type: string
    sql: ${TABLE}.role_id ;;
  }
  dimension: role_name {
    type: string
    sql: ${TABLE}.role_name ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [role_name]
  }
}
