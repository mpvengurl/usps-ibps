view: user_t {
  sql_table_name: `ibps.user_t` ;;

  dimension: ace_id {
    type: string
    sql: ${TABLE}.ace_id ;;
  }
  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }
  dimension_group: create_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.create_date_time ;;
  }
  dimension: divisions {
    type: string
    sql: ${TABLE}.divisions ;;
  }
  dimension: duty_finance_number {
    type: string
    sql: ${TABLE}.duty_finance_number ;;
  }
  dimension: facility_id {
    type: string
    sql: ${TABLE}.facility_id ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: identity_type {
    type: string
    sql: ${TABLE}.identity_type ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension_group: last_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_update_date_time ;;
  }
  dimension: middle_initial {
    type: string
    sql: ${TABLE}.middle_initial ;;
  }
  dimension: occupation_code {
    type: string
    sql: ${TABLE}.occupation_code ;;
  }
  dimension: regions {
    type: string
    sql: ${TABLE}.regions ;;
  }
  dimension: role_id {
    type: number
    sql: ${TABLE}.role_id ;;
  }
  dimension: user_modified {
    type: string
    sql: ${TABLE}.user_modified ;;
  }
  measure: count {
    type: count
    drill_fields: [last_name, first_name]
  }
}
